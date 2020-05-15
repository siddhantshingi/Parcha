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
				"duration" : data.duration,
				"status" : data.status
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
						if (data[0])
						{
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
						} else {
							cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "Requested shop time slot does not exists.", "result": {} });
							return;
						}
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

/**API to cancel a token */
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
			var wcriteria = {
				"id1" : data.id,
				"id2" : data.id,
			}
			var wdataToSet={
				"status1" : "4",
				"status2" : "1",
			}
			tokenDAO.findNextToken(criteria, (err, data)=>{
				if (data.length === 0) {
					tokenDAO.cancelToken(criteria, dataToSet, (err, dbData)=>{
						if(err){
							cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
							return; 
						}
						else{
							cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": {"tokenId" : criteria.id, "status" : "4"} });                        
						}
					});
				}
				else
				{
					wcriteria.id2 = data[0].id;
					tokenDAO.cancelAndUpdateNextToken(wcriteria, wdataToSet, (err, dbData)=>{
						if(err){
							cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
							return; 
						}
						else{
							cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": {"tokenId1" : wcriteria.id1, "status1" : "4", "tokenId2" : wcriteria.id2, "status2" : "1"} });                        
						}
					});
					
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				
			});	
		}
	}, (err,response) => {
		callback(response.tokenCancel);
	});
}

/***API to get token detials */
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
	});
}

/***API to get encrypted token detials */
let getEncryptedToken = (data, callback) => {
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
				if(data.length === 1)
				{
					var shopId = data[0].shopId;
					var userId = data[0].userId;
					var startTime = data[0].startTime;
					var duration = data[0].duration;
					var status = data[0].status;
					//KHARE HASH THEM
					cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				}
				else
				{
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "NO UNIQUE TOKEN EXISTS", "result": {} });
				}
				
				return;
			});
		}
	}, (err, response) => {
		callback(response.token);
	});
}

/***API to verify a token */
let verifyToken = (data, callback) => {
	async.auto({
		tokenVerify: (cb) => {
			let criteria = {
				"tokenId" : data.tokenId,
				"userId" : data.userId,
				"date" : data.date,
				"shopId" : data.shopId,
				"startTime" : data.startTime,
				"duration" : data.duration,
			}
			tokenDAO.checkLive(criteria,(err, data) => {
				if(data.length === 0)
				{
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "Token is not live", "result": {} });
					return;	
				}
				else
				{
					tokenDAO.verifyToken(criteria,(err, data) => {
						if (err) {
							cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}
						cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
						return;
					});
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
			});
		}
	}, (err, response) => {
		callback(response.tokenVerify);
	});
}

module.exports = {
	bookToken : bookToken,
	cancelToken : cancelToken,
	getToken : getToken,
	verifyToken : verifyToken,
	getEncryptedToken : getEncryptedToken
};