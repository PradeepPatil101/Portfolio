// config.js
require('dotenv').config();
const env = process.env.NODE_ENV; // 'dev' or 'test'
const dev = {
    clientId: ``,
    secret: `Sbz9jjRx8AOPLnLqZiBszsfg`,
    callback: `http://localhost:3000/callback`,
    server: 'http://localhost:3000',
    adminemail: 'admin@login.com',
    dbconfig: {
        host: "localhost",
        user: "root",
        password: "root",
        database: "medilog",
        port: 8889
    }
};
const prod = {
    clientId: ``,
    secret: `QbbBkMN2kROaHTFjGepyWoOS`,
    callback: `https://codershop.in/callback`,
    adminemail: 'admin@login.com',
    dbconfig: {
        host: "148.72.88.30",
        user: "medilog_pradeep",
        password: "EnnHOvkCoXmS",
        database: "medilog_pradeep",
        port: 3306
    }
};

const config = {
    dev,
    prod
};

module.exports = config[env];
// module.exports = {
//     // clientId: `810339610172-u2u8120j9i6qg8g83mq5mm988tus2q2p.apps.googleusercontent.com`,
//     // secret: `Sbz9jjRx8AOPLnLqZiBszsfg`,
//     // callback: `http://localhost:3000/callback`,
//     clientId: `178725023775-r6ud4u7s81i0vl341anl01nhuuf7gold.apps.googleusercontent.com`,
//     secret: `QbbBkMN2kROaHTFjGepyWoOS`,
//     callback: `http://codershop.in/callback`,
//     adminemail: 'admin@login.com',
//     //server: 'http://localhost:3000',
//     // dbconfig: {
//     //     host: "localhost",
//     //     user: "root",
//     //     password: "root",
//     //     database: "medilog",
//     //     port: 8889
//     // }
//     dbconfig: {
//         host: "148.72.88.30",
//         user: "medilog_pradeep",
//         password: "EnnHOvkCoXmS",
//         database: "medilog_pradeep",
//         port: 3306
//     }
// }