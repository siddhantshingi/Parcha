let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS users (id INT auto_increment primary key, name VARCHAR(30), DOB VARCHAR(30), email VARCHAR(30), password VARCHAR(30), contact_number VARCHAR(30), adhaar_number VARCHAR(30))");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}