let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS request (shopId INT, shopName VARCHAR(255), address VARCHAR(255), openingTime TIME DEFAULT '00:00:00', closingTime TIME DEFAULT '00:00:00', capacity INT DEFAULT 0, pincode VARCHAR(6), createdAt TIMESTAMP, status INT DEFAULT 2, authId INT DEFAULT 0, authMobile VARCHAR(10) DEFAULT '----------', PRIMARY KEY(shopId, createdAt))");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}