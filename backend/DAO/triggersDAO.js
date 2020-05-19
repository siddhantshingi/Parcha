let dbConfig = require("../Utilities/mysqlConfig");

//Models/triggers.js
let updatetokensOnUserNameUpdate = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updatetokensOnUserNameUpdate`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updatetokensOnUserNameUpdate`);
	dbConfig.getDB().query(`CREATE TRIGGER updatetokensOnUserNameUpdate
		AFTER UPDATE 
		ON users FOR EACH ROW 
		BEGIN 
			IF NEW.name != OLD.name THEN
				UPDATE tokens SET userName = NEW.name WHERE userId = NEW.id; 
			END IF;
		END`, callback);		
}

//Models/triggers.js
let updatetokensOnShopNameUpdate = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updatetokensOnShopNameUpdate`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updatetokensOnShopNameUpdate`);
	dbConfig.getDB().query(`CREATE TRIGGER updatetokensOnShopNameUpdate
		AFTER UPDATE 
		ON shops FOR EACH ROW 
		BEGIN 
			IF NEW.shopName != OLD.shopName THEN
				UPDATE tokens SET shopName = NEW.shopName WHERE shopId = NEW.id; 
			END IF;
		END`, callback);		
}

//Models/triggers.js
let updateRequestsOnShopUpdate = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updateRequestsOnShopUpdate`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updateRequestsOnShopUpdate`);
	dbConfig.getDB().query(`CREATE TRIGGER updateRequestsOnShopUpdate
		AFTER UPDATE 
		ON shops FOR EACH ROW 
		BEGIN 
			IF NEW.shopName != OLD.shopName OR NEW.address != OLD.address THEN
				UPDATE request SET shopName = NEW.shopName, address = NEW.address WHERE shopId = OLD.id; 
			END IF;
		END`, callback);		
}

//Models/triggers.js
let updateRequestsOnAuthUpdate = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updateRequestsOnAuthUpdate`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updateRequestsOnAuthUpdate`);
	dbConfig.getDB().query(`CREATE TRIGGER updateRequestsOnAuthUpdate
		AFTER UPDATE 
		ON localAuths FOR EACH ROW 
		BEGIN 
			IF NEW.mobileNumber != OLD.mobileNumber THEN
				UPDATE request SET authMobile = NEW.mobileNumber WHERE authId = NEW.id; 
			END IF;
		END`, callback);		
}

//Models/triggers.js
let updateShopBookingOnInsertInToken = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updateShopBookingOnInsertInToken`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updateShopBookingOnInsertInToken`);
	dbConfig.getDB().query(`CREATE TRIGGER updateShopBookingOnInsertInToken
		AFTER INSERT 
		ON tokens FOR EACH ROW 
		BEGIN 
			IF NEW.status = 1 THEN
				UPDATE shopBookings SET capacityLeft = capacityLeft - 1 WHERE shopId = NEW.shopId AND date = NEW.date AND slotNumber = NEW.slotNumber; 
			END IF;

			IF NEW.verified = 1 THEN
		        UPDATE shopBookings SET tokensVerified = tokensVerified + 1 WHERE shopId = NEW.shopId AND date = NEW.date AND slotNumber = NEW.slotNumber;
		    END IF;
		END`, callback);		
}

//Models/triggers.js
let updateShopBookingOnUpdateInToken = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updateShopBookingOnUpdateInToken`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updateShopBookingOnUpdateInToken`);
	dbConfig.getDB().query(`CREATE TRIGGER updateShopBookingOnUpdateInToken
		AFTER UPDATE
		ON tokens FOR EACH ROW
		BEGIN
		    IF NEW.status = 0 AND OLD.status = 1 THEN 
		        UPDATE shopBookings SET capacityLeft = capacityLeft + 1 WHERE shopId = OLD.shopId AND date = OLD.date AND slotNumber = OLD.slotNumber;
		    END IF;

		    IF NEW.status = 1 AND OLD.status = 2 THEN 
		        UPDATE shopBookings SET capacityLeft = GREATEST(capacityLeft - 1, 0) WHERE shopId = NEW.shopId AND date = NEW.date AND slotNumber = NEW.slotNumber;
		    END IF;

		    IF NEW.verified = 1 AND OLD.verified = 0 THEN
		        UPDATE shopBookings SET tokensVerified = tokensVerified + 1 WHERE shopId = NEW.shopId AND date = NEW.date AND slotNumber = NEW.slotNumber;
		    END IF;
		END	`, callback);			
}

//Models/triggers.js
let updateShopOnResolveRequest = (callback) => {
	console.log(`CREATE TRIGGER IF EXISTS updateShopOnResolveRequest`);
	dbConfig.getDB().query(`DROP TRIGGER IF EXISTS updateShopOnResolveRequest`);
	dbConfig.getDB().query(`CREATE TRIGGER updateShopOnResolveRequest
		AFTER UPDATE
		ON request FOR EACH ROW
		BEGIN
			IF NEW.status = 1 AND OLD.status = 2 THEN 
				IF NEW.capacity = 0 THEN
					UPDATE shops SET authVerification = 1, openingTimeApp = LEAST(openingTimeApp, NEW.openingTime), closingTimeApp = GREATEST(closingTimeApp, NEW.closingTime) WHERE id = NEW.shopId;
				ELSE
					UPDATE shops SET authVerification = 1, capacityApp = NEW.capacity WHERE id = NEW.shopId;
				END IF;

		    END IF;
		END	`, callback);			
}


module.exports = {
	updatetokensOnUserNameUpdate : updatetokensOnUserNameUpdate,
	updatetokensOnShopNameUpdate : updatetokensOnShopNameUpdate,
	updateShopBookingOnInsertInToken : updateShopBookingOnInsertInToken,
	updateShopBookingOnUpdateInToken : updateShopBookingOnUpdateInToken,
	updateRequestsOnShopUpdate : updateRequestsOnShopUpdate,
	updateRequestsOnAuthUpdate : updateRequestsOnAuthUpdate,
	updateShopOnResolveRequest : updateShopOnResolveRequest
}