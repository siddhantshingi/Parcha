let mysqlConfig = require("../Utilities/mysqlConfig");

let initialize = () => {
	mysqlConfig.getDB().query("DROP TRIGGER IF EXISTS updateCapacityLeftOnInsert");
	mysqlConfig.getDB().query("CREATE TRIGGER updateCapacityLeftOnInsert AFTER INSERT ON tokens FOR EACH ROW BEGIN IF NEW.status = 1 THEN SET @cap = (SELECT capacityLeft FROM shopBookings WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration LIMIT 1); UPDATE shopBookings SET capacityLeft = @cap - 1 WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration; END IF;END");
	console.log("trigger 1 created if not EXISTS");
	mysqlConfig.getDB().query("DROP TRIGGER IF EXISTS updateCapacityLeftOnUpdate");
	mysqlConfig.getDB().query("CREATE TRIGGER updateCapacityLeftOnUpdate AFTER UPDATE ON tokens FOR EACH ROW BEGIN IF NEW.status = 4 AND OLD.status = 1 THEN UPDATE shopBookings SET capacityLeft = capacityLeft + 1 WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration; END IF; IF NEW.status = 1 AND OLD.status = 2 THEN UPDATE shopBookings SET capacityLeft = GREATEST(capacityLeft - 1, 0) WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration; END IF; END");
	console.log("trigger 2 created if not EXISTS");
	
}

module.exports = {
	initialize: initialize
}

// trigger 1
// CREATE TRIGGER updateCapacityLeftOnInsert
// AFTER INSERT 
// ON tokens FOR EACH ROW 
// BEGIN 
// 	IF NEW.status = 1 THEN
// 		SET @cap = (SELECT capacityLeft FROM shopBookings WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration LIMIT 1); 
// 		UPDATE shopBookings SET capacityLeft = @cap - 1 WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration; 
// 	END IF;
// END


// trigger 2
// CREATE TRIGGER updateCapacityLeftOnUpdate
// AFTER UPDATE
// ON tokens FOR EACH ROW
// BEGIN
//     IF NEW.status = 4 AND OLD.status = 1 THEN 
//         UPDATE shopBookings SET capacityLeft = capacityLeft + 1 WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration;
//     END IF;

//     IF NEW.status = 1 AND OLD.status = 2 THEN 
//         UPDATE shopBookings SET capacityLeft = GREATEST(capacityLeft - 1, 0) WHERE shopId = NEW.shopId AND date = NEW.date AND startTime = NEW.startTime AND duration = NEW.duration;
//     END IF;
// END