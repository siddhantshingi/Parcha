let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS tokens (id INT auto_increment primary key, verified INT, date TIMESTAMP, userId INT, shopId INT, startTime TIME, duration TIME, status INT)");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}