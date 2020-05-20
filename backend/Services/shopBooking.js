let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
shopBookingDAO = require('../DAO/shopBookingDAO');

/**Api to Get time slots details using shop ID, date, startTime, duration */
let createShopBooking = (data, callback) => {
	async.auto({
		shopBooking: (cb) => {
			let criteria = {
				"shopId":data.shopId,
				"date":data.date,
				"startTime":data.startTime,
				"duration":data.duration,
				"capacityLeft":data.capacity,
				"tokensVerified":"0",
				"status":"0"
			}
			shopBookingDAO.addShopTimeSlot(criteria,(err, data) => {
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
};