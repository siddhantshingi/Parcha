let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS localAuths (id INT auto_increment primary key, name VARCHAR(30), email VARCHAR(30), contactNumber VARCHAR(30), password VARCHAR(30), aadharNumber VARCHAR(30), state VARCHAR(30), district VARCHAR(30), pincode VARCHAR(30), verificationStatus INT)");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}