let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
    mysqlConfig.getDB().query("create table IF NOT EXISTS state (stateName VARCHAR(30) primary key)");
    mysqlConfig.getDB().query("LOAD DATA LOCAL INFILE './Data/state.csv' INTO TABLE state LINES TERMINATED BY '\n'");
}

module.exports = {
	initialize: initialize
}