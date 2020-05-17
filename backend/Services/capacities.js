let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
capacitiesDAO = require('../DAO/capacitiesDAO');

/***API to get the shopSize by shopSizeId */
let getCapacities = (data, callback) => {
	async.auto({
		capacities: (cb) => {
			let criteria = {
				"id" : data.id
			}
			capacitiesDAO.getCapacities(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
								
			});
		}
	}, (err, response) => {
		callback(response.capacities);
	})
}

module.exports = {
	getCapacities : getCapacities
};