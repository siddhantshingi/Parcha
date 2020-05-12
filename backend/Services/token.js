let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
tokenDAO = require('../DAO/tokenDAO'),
shopBookingDAO = require('../DAO/shopBookingDAO');

/**API to book a token */
let bookToken = (data, callback) => {
	async.auto({
		token: (cb) => {
			var dataToSet = {
				"id":data.id,
				"verified":data.verified,
				"date":data.date,
				"userId":data.userId,
				"shopId":data.shopId,
				"startTime":data.startTime,
				"duration":data.duration,
				"status":data.status,
			}
			let criteria = {
				"date" : data.date,
				"userId" : data.userId,
				"shopId" : data.shopId,
				"startTime" : data.startTime,
				"duration" : data.duration
			}
			let criteria_booking = {
				"shopId":data.shopId,
				"date":data.date,
				"startTime":data.startTime,
				"duration":data.duration
			}
			tokenDAO.getToken(criteria,(err, data) => {
				if (data.length === 0) {
					shopBookingDAO.getShopBookings(criteria_booking,(err, data) => {
						if (err) {
							cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}
						if (data[0].capacityLeft != 0) {
							dataToSet.status = "1";
						} else {
							dataToSet.status = "2";
						}
						tokenDAO.bookToken(dataToSet, (err, dbData) => {
							if (err) {
								cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
								return;
							}

							cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });
							return;
						});
						return;
					});
					
				} else {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "Token already exists", "result": {} });
					return;	
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
			});
		}
	}, (err, response) => {
		callback(response.token);
	});
}

/**API to update the user */
let cancelToken = (data,callback) => {
	async.auto({
		tokenCancel :(cb) =>{
			console.log(data.id);
			if (!data.id) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				"id" : data.id,
			}
			var dataToSet={
				"status" : "4",
			}
            tokenDAO.cancelToken(criteria, dataToSet, (err, dbData)=>{
	            if(err){
					cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
                    return; 
                }
                else{
					cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": {"tokenId" : data.id, "status" : "4"} });                        
                }
            });
		}
	}, (err,response) => {
		callback(response.tokenCancel);
	});
}

/***API to get the user detail by id */
let getToken = (data, callback) => {
	async.auto({
		token: (cb) => {
			let criteria = {
				"tokenId" : data.tokenId,
				"userId" : data.userId,
				"date" : data.date,
				"shopId" : data.shopId,
				"startTime" : data.startTime,
				"duration" : data.duration,
				"dateLowerLim" : data.dateLowerLim,
				"dateUpperLim" : data.dateUpperLim,
				"status" : data.status,
				"verified" : data.verified,
			}
			tokenDAO.getToken(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.token);
	})
}

module.exports = {
	bookToken : bookToken,
	cancelToken : cancelToken,
	getToken : getToken
};