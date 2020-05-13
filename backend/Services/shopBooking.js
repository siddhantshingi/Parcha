let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
shopBookingDAO = require('../DAO/shopBookingDAO');

let email   = require('emailjs/email');
sender_email = require("../Utilities/config").sender_email;
sender_password = require("../Utilities/config").sender_password;


/**Api to Get time slots details using shop ID */
let getShopBookings = (data, callback) => {
	async.auto({
		shopBooking: (cb) => {
			let criteria = {
				"shopId":data.shopId,
				"date":data.date,
				"startTime":data.startTime,
				"duration":data.duration,
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
    getShopBookings : getShopBookings
};