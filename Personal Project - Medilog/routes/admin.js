const express = require('express')
const session = require('express-session')
const router = express.Router();
router.use(express.urlencoded({
    extended: true
}));
const con = require('../db')




router.get('/', (req, res) => {

    if (!req.session.email) {
        return res.redirect('../');

    }
    var query = 'SELECT * FROM users;';
    con.query(query, function(err, result) {
        if (err) throw err;

        res.render('pages/user-list', { r: result });
    });
})

router.get('/update-user/:id/:flag', (req, res) => {
    var id = req.params.id;
    var flag = req.params.flag;
    var query = 'UPDATE `users` SET flag=? WHERE id=?';
    con.query(query, [flag, id], function(err, result) {
        if (err) throw err;

        res.redirect('/admin');
    });
})

router.get('/delete-user/:id', (req, res) => {
    var id = req.params.id;
    var query = 'DELETE FROM `users` WHERE id=?';
    con.query(query, [id], function(err, result) {
        if (err) throw err;

        res.redirect('/admin');
    });
})

router.get('/new-user', (req, res) => {
    res.render('pages/new-user', { error: '' });
})
router.post('/new-user', (req, res) => {
    var email = req.body.emailid;
    var password = req.body.password;
    var query = 'INSERT INTO `users`(`email`, `password`) VALUES (?,?)'
    con.query(query, [email, password], function(err, result) {
        if (err) {
            res.render('pages/new-user', { error: err });
            res.end();
        } else {

            res.redirect('/');
        }

    });
})

router.get('/logout', (req, res, next) => {
    req.session.destroy(function(err) {

        res.redirect('/');
    });

});

router.get('/dashboard', (req, res) => {

    if (!req.session.email) {
        return res.redirect('../');

    }
    var totalUsers = 0;
    var totalReceipts = 0;
    var avgReceipts = 0;
    var totalReports = 0;
    var avgReports = 0;
    var shares = 0;
    var query = 'SELECT COUNT(id) as count FROM users;';
    con.query(query, function(err, result) {
        totalUsers = parseInt(result[0].count);

        var query = 'SELECT COUNT(id) as counta FROM receipts;';
        con.query(query, function(err, result) {
            totalReceipts = parseInt(result[0].counta);
            avgReceipts = parseInt(totalReceipts / (totalUsers - 1));

            var query = 'SELECT COUNT(id) as countr FROM test_reports;';
            con.query(query, function(err, result) {
                totalReports = parseInt(result[0].countr);
                avgReports = parseInt(totalReports / (totalUsers - 1));

                var query = 'SELECT * FROM test_reports;';
                con.query(query, function(err, result2) {


                    var query = 'SELECT * FROM receipts;';
                    con.query(query, function(err, result1) {

                        var query = 'SELECT count(id) as count FROM shares;';
                        con.query(query, function(err, result) {
                            shares = parseInt(result[0].count);
                            res.render('pages/admin-dashboard.ejs', { tu: totalUsers, tr: totalReceipts, avgr: avgReceipts, tre: totalReports, avgre: avgReports, r1: result1, r2: result2, s: shares });

                        });
                    });


                });


            });


        });


    });


})




module.exports = router;