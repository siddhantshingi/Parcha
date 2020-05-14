let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shops (id INT auto_increment primary key, name VARCHAR(30), owner	 VARCHAR(30), email VARCHAR(30), contactNumber VARCHAR(30), shopType INT, address VARCHAR(50), landmark VARCHAR(30), password VARCHAR(30), state VARCHAR(30), district VARCHAR(30), pincode VARCHAR(30), verificationStatus INT, openTime TIME, closeTime TIME, verifierId INT, shopSize INT)");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}