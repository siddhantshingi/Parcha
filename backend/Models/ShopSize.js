let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS shopSizes (id INT primary key, description VARCHAR(30), capacity INT, slotDuration TIME, bufferDuration TIME)");
	mysqlConfig.getDB().query("INSERT INTO shopSizes (id, description, capacity, slotDuration, bufferDuration) SELECT * FROM (SELECT 0, NULL as description, NULL as capacity, NULL as slotDuration, NULL as bufferDuration) AS tmp WHERE NOT EXISTS (SELECT id FROM shopSizes WHERE description IS NULL AND id = 0) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopSizes (id, description, capacity, slotDuration, bufferDuration) SELECT * FROM (SELECT 1, 'SMALL', 5, '00:15:00', '00:05:00') AS tmp WHERE NOT EXISTS (SELECT id FROM shopSizes WHERE description = 'SMALL' AND id = 1) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopSizes (id, description, capacity, slotDuration, bufferDuration) SELECT * FROM (SELECT 2, 'MEDIUM', 10, '00:30:00', '00:05:00') AS tmp WHERE NOT EXISTS (SELECT id FROM shopSizes WHERE description = 'MEDIUM' AND id = 2) LIMIT 1");
	mysqlConfig.getDB().query("INSERT INTO shopSizes (id, description, capacity, slotDuration, bufferDuration) SELECT * FROM (SELECT 3, 'LARGE', 15, '00:30:00', '00:10:00') AS tmp WHERE NOT EXISTS (SELECT id FROM shopSizes WHERE description = 'LARGE' AND id = 3) LIMIT 1");
	console.log("table created if not EXISTS");
}

module.exports = {
	initialize: initialize
}