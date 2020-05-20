let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
shopBookingDAO = require('../DAO/shopBookingDAO'),
periodicFunc = require('../Models/Periodic');

/**Api to Get time slots details using shop ID, date, startTime, duration */
let runPeriodicFunction = (data, callback) => {
	async.auto({
		shopBooking: (cb) => {
			periodicFunc.addShopTimeSlots();		
			cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": {} });
			return;
		}
	}, (err, response) => {
		callback(response.shopBooking);
	})
}

/**Api to Get time slots details using shop ID, date, startTime, duration */
let getShopBookings = (data, callback) => {
	async.auto({
		shopBooking: (cb) => {
			let criteria = {
				"shopId":data.shopId,
				"date":data.date,
				"slotNumber":data.slotNumber
			}
			shopBookingDAO.getShopBookings(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.shopBooking);
	})
}

module.exports = {
	getShopBookings : getShopBookings,
	runPeriodicFunction : runPeriodicFunction
};