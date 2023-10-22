const express = require('express');
const router = express.Router();
const fs = require('fs');
const config = require("../config")


//For file upload
const multer = require('multer');
const path = require('path');
router.use(express.static(__dirname + '/public'));
const helpers = require('./helpers');

var currentFileName;

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, 'uploads/');
    },

    // By default, multer removes file extensions so let's add them back
    filename: function(req, file, cb) {
        currentFileName = file.fieldname + '-' + Date.now() + path.extname(file.originalname);
        cb(null, currentFileName);
    }
});

router.use(express.urlencoded({
    extended: true
}));
const con = require('../db')

router.get('/', (req, res) => {

    if (!req.session.email) {
        return res.redirect('../');

    }
    var query = 'SELECT * FROM `receipts` WHERE user_id=?';
    con.query(query, [req.session.user_id], function(err, result) {
        if (err) throw err;

        res.render('pages/user.ejs', { email: req.session.email, r: result });
    });

})

router.get('/logout', (req, res, next) => {
    req.session.destroy(function(err) {

        res.redirect('/');
    });

});

router.get('/update-receipt/:id/:flag', (req, res) => {
    var id = req.params.id;
    var flag = req.params.flag;
    var query = 'UPDATE `receipts` SET flag=? WHERE id=?';
    con.query(query, [flag, id], function(err, result) {
        if (err) throw err;

        res.redirect('/user');
    });
})

router.get('/delete-receipt/:id', (req, res) => {
    var id = req.params.id;
    var query2 = 'SELECT * FROM `receipts` WHERE id=? limit 1';
    con.query(query2, [id], function(err, result1) {
        if (err) throw err;
        var path1 = `C:/Users/pmap1/Desktop/Computer Science/MediLog/uploads/${result1[0].file}`;
        //Deleting File
        fs.unlink(path1, function(err) {
            if (err) throw err;


        });
    });

    var query = 'DELETE FROM `receipts` WHERE id=?';
    con.query(query, [id], function(err, result) {
        if (err) throw err;

        var query = 'DELETE FROM `shares` WHERE r_id=?';
        con.query(query, [id], function(err, result) {
            if (err) throw err;


            res.redirect('/user');
        });



    });

})

router.get('/new-receipt/:flagg', (req, res) => {


    res.render('pages/new-receipt', { error: '', f: req.params.flagg, email: req.session.email });
})
router.post('/new-receipt/:flagg', (req, res) => {

    var error;


    let upload = multer({ storage: storage, fileFilter: helpers.imageFilter }).single('file');

    upload(req, res, function(err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            error = req.fileValidationError;
        } else if (!req.file) {
            error = 'Please upload proper file';
        } else if (err instanceof multer.MulterError) {
            error = err;
        } else if (err) {
            error = err;
        }


        var f = req.params.flagg

        var title = req.body.title;
        var body = req.body.body;
        var dateUpload = new Date();
        var dateEdit = new Date();
        console.log(title, body, currentFileName);

        if (f == 0) {
            dateEdit = dateUpload;
        }


        var query = 'INSERT INTO `receipts`(`title`, `body`,`file`,`date_created`,`date_updated`, `user_id`) VALUES (?,?,?,?,?,?)'
        con.query(query, [title, body, currentFileName, dateUpload, dateEdit, req.session.user_id], function(err, result) {
            if (err) console.log(err);
            console.log(query);
            res.redirect('/user');


        });
    });


})

router.get('/new-report/:flagg', (req, res) => {
    res.render('pages/new-report', { error: '', f: req.params.flagg, email: req.session.email });
})
router.post('/new-report/:flagg', (req, res) => {

    var error;


    let upload = multer({ storage: storage, fileFilter: helpers.imageFilter }).single('file');

    upload(req, res, function(err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            error = req.fileValidationError;
        } else if (!req.file) {
            error = 'Please upload proper file';
        } else if (err instanceof multer.MulterError) {
            error = err;
        } else if (err) {
            error = err;
        }


        var f = req.params.flagg

        var title = req.body.title;
        var body = req.body.body;
        var dateUpload = new Date();
        var dateEdit = new Date();
        if (f == 0) {
            dateEdit = dateUpload;
        }


        var query = 'INSERT INTO `test_reports`(`title`, `body`,`file`,`date_created`,`date_updated`, `user_id`) VALUES (?,?,?,?,?,?)'
        con.query(query, [title, body, currentFileName, dateUpload, dateEdit, req.session.user_id], function(err, result) {


            res.redirect('/user/test-reports');


        });
    });


})
router.get('/test-reports', (req, res) => {
    if (!req.session.email) {
        return res.redirect('../');
    }
    var query = 'SELECT * FROM `test_reports` WHERE user_id=?';
    con.query(query, [req.session.user_id], function(err, result) {
        if (err) throw err;

        res.render('pages/user-test-reports.ejs', { email: req.session.email, r: result });
    });

})

router.get('/delete-report/:id', (req, res) => {
    var id = req.params.id;
    var query = 'DELETE FROM `test_reports` WHERE id=?';
    con.query(query, [id], function(err, result) {
        if (err) throw err;

        var query = 'DELETE FROM `shares` WHERE r_id=?';
        con.query(query, [id], function(err, result) {
            if (err) throw err;

            res.redirect('/user/test-reports');
        });


    });
})

router.get('/download-receipt/:id', (req, res) => {
    var id = req.params.id;
    var query = 'SELECT * FROM `receipts` WHERE id=? limit 1';
    con.query(query, [id], function(err, result) {
        if (err) throw err;
        res.download(`./uploads/${result[0].file}`);

    });
})

router.get('/download-report/:id', (req, res) => {
    var id = req.params.id;
    var query = 'SELECT * FROM `test_reports` WHERE id=? limit 1';
    con.query(query, [id], function(err, result) {
        if (err) throw err;
        res.download(`./uploads/${result[0].file}`);
    });
})

router.get('/view-file/:name', (req, res) => {
    res.sendFile(req.params.name, { root: `./uploads/` });
})

router.get('/edit-receipt/:id', (req, res) => {
    var id = req.params.id;
    var query = 'SELECT * FROM `receipts` WHERE id=? limit 1';
    con.query(query, [id], function(err, result) {
        if (err) throw err;

        res.render('pages/edit-receipt.ejs', { r: result, email: req.session.email });
    });

});

router.post('/edit-receipt/:id', (req, res) => {
    var id = parseInt(req.params.id);
    var date1 = new Date();
    currentFileName = ""
    var error;


    let upload = multer({ storage: storage, fileFilter: helpers.imageFilter }).single('file');

    upload(req, res, function(err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            error = req.fileValidationError;
        } else if (!req.file) {
            error = 'Please upload proper file';
        } else if (err instanceof multer.MulterError) {
            error = err;
        } else if (err) {
            error = err;
        }


        var f = req.params.flagg;
        var title = req.body.title;
        var body = req.body.body;
        if (f == 0) {
            dateEdit = dateUpload;
        }
        if (currentFileName == "") {

            var query = 'UPDATE `receipts` SET `title`=?,`body`=? ,`date_updated`=? WHERE `id`=?';
            con.query(query, [title, body, date1, id], function(err, result) {
                if (err) throw err;
                res.redirect('/user');

            });
        } else {

            var path1 = `C:/Users/pmap1/Desktop/Computer Science/MediLog/uploads/${req.body.fileName}`;
            //Deleting File
            fs.unlink(path1, function(err) {
                if (err) throw err;


            });

            var query = 'UPDATE `receipts` SET `title`=?,`body`=?,file=? ,`date_updated`=? WHERE `id`=?';
            con.query(query, [title, body, currentFileName, date1, id], function(err, result) {
                if (err) throw err;
                res.redirect('/user');
            });
        }

    });
});

router.get('/edit-report/:id', (req, res) => {
    var id = req.params.id;
    var query = 'SELECT * FROM `test_reports` WHERE id=? limit 1';
    con.query(query, [id], function(err, result) {
        if (err) throw err;

        res.render('pages/edit-report.ejs', { r: result, email: req.session.email });
    });

});

router.post('/edit-report/:id', (req, res) => {
    var id = parseInt(req.params.id);
    var date1 = new Date();

    var error;


    let upload = multer({ storage: storage, fileFilter: helpers.imageFilter }).single('file');
    currentFileName = "";
    upload(req, res, function(err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            error = req.fileValidationError;
        } else if (!req.file) {
            error = 'Please upload proper file';
        } else if (err instanceof multer.MulterError) {
            error = err;
        } else if (err) {
            error = err;
        }


        var f = req.params.flagg;
        var title = req.body.title;
        var body = req.body.body;
        if (f == 0) {
            dateEdit = dateUpload;
        }


        if (currentFileName == "") {
            var query = 'UPDATE `test_reports` SET `title`=?,`body`=? ,`date_updated`=? WHERE `id`=?';
            con.query(query, [title, body, date1, id], function(err, result) {
                if (err) throw err;
                res.redirect('/user/test-reports');

            });
        } else {
            var path1 = `C:/Users/pmap1/Desktop/Computer Science/MediLog/uploads/${req.body.fileName}`;
            //Deleting File
            fs.unlink(path1, function(err) {
                if (err) throw err;

            });

            var query = 'UPDATE `test_reports` SET `title`=?,`body`=?,file=? ,`date_updated`=? WHERE `id`=?';
            con.query(query, [title, body, currentFileName, date1, id], function(err, result) {
                if (err) throw err;
                res.redirect('/user/test-reports');
            });
        }

    });
});

router.get('/share-receipt/:id', (req, res) => {
    var id = req.params.id;
    var key = parseInt(Math.random() * 1000);
    var link = `${req.headers.host}/view-shared/${id}/${key}`;
    var query = 'INSERT INTO `shares`( `r_table`, `r_id`, `r_key`) VALUES (?,?,?)'
    con.query(query, [0, id, key], function(err, result) {

    });
    res.render('pages/share-receipt.ejs', { l: link, email: req.session.email });
});

router.get('/share-report/:id', (req, res) => {
    var id = req.params.id;
    var key = parseInt(Math.random() * 1000);
    var link = `${req.headers.host}/view-shared-rep/${id}/${key}`;
    var query = 'INSERT INTO `shares`( `r_table`, `r_id`, `r_key`) VALUES (?,?,?)'
    con.query(query, [1, id, key], function(err, result) {

    });
    res.render('pages/share-report.ejs', { l: link, email: req.session.email });
});

//To remove shares after an hour
var hour = (3.6 * Math.pow(10, 6));
setInterval(deleteShares, hour);

function deleteShares() {
    var query = 'DELETE FROM `shares`';
    con.query(query, [], function(err, result) {
        if (err) throw err;
        console.log("Shares table Reset Successful");
    });
}






module.exports = router;
module.exports = router;