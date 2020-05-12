let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
shopSizeDAO = require('../DAO/shopSizeDAO');

/***API to get the shopSize by shopSizeId */
let getShopSize = (data, callback) => {
	async.auto({
		shopSize: (cb) => {
			if (!data.shopSize) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			let criteria = {
				"id" : data.shopSize
			}
			shopSizeDAO.getShopSize(criteria,(err, data) => {
				if (data.length === 0) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_FOUR,"statusMessage": util.statusMessage.NOT_FOUND, "result": {} });
					return;
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data[0] });
				return;
			});
		}
	}, (err, response) => {
		callback(response.shopSize);
	})
}

module.exports = {
	getShopSize : getShopSize
};