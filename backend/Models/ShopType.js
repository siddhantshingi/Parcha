let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shopTypes (id INT primary key, shopType VARCHAR(255))");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 1, 'General Market') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'General Market' AND id = 1) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 2, 'Sabzi Market') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Sabzi Market' AND id = 2) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 3, 'Supermarket') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Supermarket' AND id = 3) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 4, 'Restaurant and Cafes') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Restaurant and Cafes' AND id = 4) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 5, 'Medical Store') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Medical Store' AND id = 5) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 6, 'Parlour and Hair Saloon') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Parlour and Hair Saloon' AND id = 6) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 7, 'Dairy') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Dairy' AND id = 7) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 8, 'Liquor') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Liquor' AND id = 8) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 9, 'Jwellery Shop') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Jwellery Shop' AND id = 9) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 10, 'Stationery Shop') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Stationery Shop' AND id = 10) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopTypes (id, shopType) SELECT * FROM (SELECT 11, 'Hardware and Construction Shops') AS tmp WHERE NOT EXISTS (SELECT id FROM shopTypes WHERE shopType = 'Hardware and Construction Shops' AND id = 11) LIMIT 1");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}