var config = require("../Utilities/config").config;
var mysql = require('mysql');
var connection = mysql.createConnection({
	host: config.DB_URL_MYSQL.host,
	user: config.DB_URL_MYSQL.user,
	password: config.DB_URL_MYSQL.password,
	database: config.DB_URL_MYSQL.database,
});

connection.connect(() => {
	console.log("connection setup");
	require('../Models/User').initialize();
	require('../Models/Shop').initialize();
	require('../Models/LocalAuth').initialize();
});

let getDB = () => {
	return connection;
}

module.exports = {
	getDB: getDB
}