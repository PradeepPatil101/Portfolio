const express = require('express')
const app = express()
const port = 3000
const session = require('express-session')
const config = require("./config")
    //Google Login
const passport = require("passport");
app.use(passport.initialize());
const googleStrategy = require("./googleStrategy");


//To render views
app.set('view engine', 'ejs');

//database
const con = require('./db')

//URL encoding for POST data
app.use(express.urlencoded());

// Session Setup 
app.use(session({

    // It holds the secret key for session 
    secret: '9aa6e5f2256c17d2d430b100032b997c',

    // Forces the session to be saved 
    // back to the session store 
    resave: true,

    // Forces a session that is "uninitialized" 
    // to be saved to the store 
    saveUninitialized: true
}));

//To make routes work
const admin = require('./routes/admin');
app.use('/admin', admin);
const user = require('./routes/user');
app.use('/user', user);

app.get('/', (req, res) => {
    if (req.session.email && req.session.email == config.adminemail) {
        return res.redirect('/admin/dashboard');
    } else if (req.session.email && req.session.email) {
        return res.redirect('/user');
    }
    res.render('pages/log-in', { error: '' });
})



app.post('/log-in', (req, res) => {

    var email = req.body.emailid;
    var password = req.body.password;
    var query = 'SELECT * FROM `users` WHERE email=? and password=? limit 1'
    con.query(query, [email, password], function(err, result) {
        if (err) {
            res.render('pages/log-in', { error: err });
            res.end();
        } else if (result.length == 0) {
            res.render('pages/log-in', { error: "Wrong Credentials" });
            res.end();
        } else {

            req.session.email = email;
            req.session.user_id = result[0].user_id;

            if (req.session.email == "admin@medilog.com") {
                res.redirect('/admin/dashboard');
            } else {
                res.redirect('/user');
            }

        }

    });
})

app.get("/google",
    passport.authenticate("google", { scope: ["email", "profile"] }), (req, res) => {});

// Api call back function
app.get("/callback", passport.authenticate("google", { scope: ["email", "profile"] }),
    (req, res) => {
        var profile = googleStrategy.getUserProfile();

        var query = 'SELECT * FROM `users` WHERE `email`=?'
        con.query(query, [profile._json.email], function(err, result) {
            if (err) {
                res.render('pages/log-in', { error: err });
                res.end();
            } else {
                if (result.length == 0) {
                    var query = 'INSERT INTO `users`( `email`,`password`) VALUES (?,?)'

                    var password1 = Math.random() * 100000000000;
                    con.query(query, [profile._json.email, password1], function(err, result) {
                        if (err) {
                            res.render('pages/log-in', { error: err });
                            res.end();
                        } else {


                            var query = 'SELECT * FROM `users` WHERE `email`= ? LIMIT 1'
                            con.query(query, [profile._json.email], function(err2, result2) {
                                if (err2) {
                                    res.render('pages/log-in', { error: err2 });
                                    res.end();
                                } else {
                                    req.session.email = profile._json.email;
                                    req.session.user_id = result2[0].id;

                                    return res.redirect('/user');
                                }

                            });

                        }

                    });
                } else {
                    var query = 'SELECT * FROM `users` WHERE `email`= ? LIMIT 1'
                    con.query(query, [profile._json.email], function(err2, result2) {
                        if (err2) {
                            res.render('pages/log-in', { error: err2 });
                            res.end();
                        } else {
                            req.session.email = profile._json.email;
                            req.session.user_id = result2[0].id;

                            return res.redirect('/user');
                        }

                    });

                }


            }

        });





    });


//For viewing shared receipt
app.get('/view-shared/:id/:key', (req, res) => {
    var id = req.params.id;
    var key = req.params.key;
    var query = 'SELECT * FROM `shares` WHERE r_id=? AND r_key=? AND r_table=? LIMIT 1';
    con.query(query, [id, key, 0], function(err, result) {
        if (err) throw err;
        if (result.length == 1) {
            if (result[0].r_key == key) {
                var query = 'SELECT * FROM `receipts` WHERE id=? limit 1';
                con.query(query, [id], function(err, result) {
                    if (err) throw err;
                    res.render('pages/shared-receipt.ejs', { r: result });
                });
            }
        } else {
            res.render('pages/shared-error.ejs', { r: result });
        }



    });



});

app.get('/view-shared-rep/:id/:key', (req, res) => {
    var id = req.params.id;
    var key = req.params.key;
    var query = 'SELECT * FROM `shares` WHERE r_id=? AND r_key=? AND r_table=? LIMIT 1';
    con.query(query, [id, key, 1], function(err, result) {
        if (err) throw err;
        if (result.length == 1) {
            if (result[0].r_key == key) {
                var query = 'SELECT * FROM `test_reports` WHERE id=? limit 1';
                con.query(query, [id], function(err, result) {
                    if (err) throw err;
                    res.render('pages/shared-report.ejs', { r: result });
                });
            }
        } else {
            res.render('pages/shared-error.ejs', { r: result });
        }



    });



});

app.get('/new-user', (req, res) => {
    res.render('pages/new-user-signup', { error: '' });
})
app.post('/new-user', (req, res) => {
    var email = req.body.emailid;
    var password = req.body.password;
    var query = 'INSERT INTO `users`(`email`, `password`) VALUES (?,?)'
    con.query(query, [email, password], function(err, result) {
        if (err) {
            res.render('pages/new-user-signup', { error: err });
            res.end();
        } else {

            res.redirect('/');
        }

    });
})

app.get("/testhostname", (req, res) => {
    res.send(req.headers.host);
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})