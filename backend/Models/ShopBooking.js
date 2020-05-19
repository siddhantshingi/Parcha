let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shopBookings (shopId INT, date DATE, slotNumber INT, capacityLeft INT, tokensVerified INT DEFAULT 0, maxCapacity INT, PRIMARY KEY (shopId, date, slotNumber))");
	console.log("shopBookings created if not EXISTS")
}

module.exports = {
	initialize: initialize
}