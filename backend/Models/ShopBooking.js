let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shopBooking (shopId INT, date DATE, startTime TIME, duration TIME, capacityLeft INT, tokensVerified INT, status INT, PRIMARY KEY (shopId, date, startTime, duration))");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}