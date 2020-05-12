var config = require("../Utilities/config").config;
var mysql = require('mysql');
var connection = mysql.createConnection({
	host: config.DB_URL_MYSQL.host,
	user: config.DB_URL_MYSQL.user,
	password: config.DB_URL_MYSQL.password,
	database: config.DB_URL_MYSQL.database,
	dateStrings:true,
});

connection.connect((err) => {
	if (err) throw err;
	else{
		console.log("connection setup");
		require('../Models/User').initialize();
		require('../Models/Shop').initialize();
		require('../Models/LocalAuth').initialize();
		require('../Models/Token').initialize();
		require('../Models/ShopBooking').initialize();
		require('../Models/Periodic').initialize();
		require('../Models/Request').initialize();
		require('../Models/ShopSize').initialize();
		require('../Models/Pincode').initialize();
		require('../Models/District').initialize();
		require('../Models/State').initialize();
	}
});

let getDB = () => {
	return connection;
}

module.exports = {
	getDB: getDB
}