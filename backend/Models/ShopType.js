let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shopTypes (id INT primary key, typeName VARCHAR(50))");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 1, 'General Market') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'General Market' AND id = 1) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 2, 'Sabzi Market') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Sabzi Market' AND id = 2) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 3, 'Supermarket') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Supermarket' AND id = 3) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 4, 'Restaurant and Cafes') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Restaurant and Cafes' AND id = 4) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 5, 'Medical Store') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Medical Store' AND id = 5) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 6, 'Parlour and Hair Saloon') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Parlour and Hair Saloon' AND id = 6) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 7, 'Dairy') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Dairy' AND id = 7) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 8, 'Liquor') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Liquor' AND id = 8) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 9, 'Jwellery Shop') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Jwellery Shop' AND id = 9) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 10, 'Stationery Shop') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Stationery Shop' AND id = 10) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, typeName) SELECT * FROM (SELECT 11, 'Hardware and Construction Shops') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE typeName = 'Hardware and Construction Shops' AND id = 11) LIMIT 1");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}