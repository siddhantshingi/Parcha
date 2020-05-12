let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
    mysqlConfig.getDB().query("create table IF NOT EXISTS pincode (pincode varchar(30) primary key, district VARCHAR(30), stateName VARCHAR(30))");
    mysqlConfig.getDB().query("LOAD DATA LOCAL INFILE './Data/pincode.csv'  INTO TABLE pincode FIELDS TERMINATED BY ','  LINES TERMINATED BY '\n'");
}

module.exports = {
	initialize: initialize
}


