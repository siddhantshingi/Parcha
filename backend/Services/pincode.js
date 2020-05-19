let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
pincodeDAO = require('../DAO/pincodeDAO');

/***API to pincode details*/
let getPincode = (data, callback) => {
	async.auto({
		pincode: (cb) => {
			let criteria = {
				"pincode": data.pincode
			}
			pincodeDAO.getPincode(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null,{"statusCode": util.statusCode.FOUR_ZERO_ONE,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
			
		}
	}, (err, response) => {
		callback(response.pincode);
	})
}

module.exports = {
    getPincode : getPincode
};