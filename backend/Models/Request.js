let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS request (shopId INT, pincode VARCHAR(30), shopSize INT, openTime TIME, closeTime TIME, status INT, time TIMESTAMP, PRIMARY KEY(shopId, shopSize, openTime, closeTime))");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}