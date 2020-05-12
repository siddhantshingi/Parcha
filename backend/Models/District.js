let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
    mysqlConfig.getDB().query("create table IF NOT EXISTS district (district VARCHAR(30) primary key, stateName VARCHAR(30))");
    mysqlConfig.getDB().query("LOAD DATA LOCAL INFILE './Data/district.csv'  INTO TABLE district FIELDS TERMINATED BY ','  LINES TERMINATED BY '\n'");
}

module.exports = {
	initialize: initialize
}