let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS localAuths (id INT auto_increment primary key, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255), mobileNumber VARCHAR(10), aadharNumber VARCHAR(12), state VARCHAR(255), district VARCHAR(255), pincode VARCHAR(6), emailVerification INT, authVerification INT)");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}

