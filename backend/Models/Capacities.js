let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS capacities (id INT primary key, capacity INT)");
	mysqlConfig.getDB().query("INSERT INTO capacities (id, capacity) SELECT * FROM (SELECT 0, NULL as capacity) AS tmp WHERE NOT EXISTS (SELECT id FROM capacities WHERE capacity IS NULL AND id = 0) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO capacities (id, capacity) SELECT * FROM (SELECT 1, 5) AS tmp WHERE NOT EXISTS (SELECT id FROM capacities WHERE capacity = 5 AND id = 1) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO capacities (id, capacity) SELECT * FROM (SELECT 2, 10) AS tmp WHERE NOT EXISTS (SELECT id FROM capacities WHERE capacity = 10 AND id = 2) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO capacities (id, capacity) SELECT * FROM (SELECT 3, 15) AS tmp WHERE NOT EXISTS (SELECT id FROM capacities WHERE capacity = 15 AND id = 3) LIMIT 1");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}