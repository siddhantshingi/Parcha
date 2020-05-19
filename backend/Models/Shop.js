let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shops (id INT auto_increment primary key, shopName VARCHAR(255), ownerName VARCHAR(255), email VARCHAR(255), password VARCHAR(255), mobileNumber VARCHAR(10), aadhaarNumber varchar(12), address VARCHAR(255), landmark VARCHAR(255), shopTypeId INT, shopType VARCHAR(255), currOpeningTime TIME DEFAULT '00:00:00', currClosingTime TIME DEFAULT '00:00:00', capacityIdApp INT DEFAULT 0, capacityApp INT DEFAULT 0, openingTimeApp TIME DEFAULT '23:59:59', closingTimeApp TIME DEFAULT '00:00:00', state VARCHAR(255), district VARCHAR(255), pincode VARCHAR(6), emailVerification INT DEFAULT 1, mobileVerification INT DEFAULT 0, authVerification INT DEFAULT 0)");
	console.log("shops created if not EXISTS");
}

module.exports = {
	initialize: initialize
}