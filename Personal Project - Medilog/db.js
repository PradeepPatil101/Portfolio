//mysql connection
var mysql = require('mysql');
const config = require("./config")

var con = mysql.createConnection(config.dbconfig);



con.connect(function(err) {
    if (err) console.log(err);
    else
        console.log("Connected!");
});



module.exports = con;