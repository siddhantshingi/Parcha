let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
requestDAO = require('../DAO/requestDAO'),
localAuthDAO = require('../DAO/localAuthDAO');

/**API to create a request */
let createRequest = (data, callback) => {
	async.auto({
		request: (cb) => {
			console.log(data);
			var dataToSet = {
				"shopId": data.shopId,
				"pincode": data.pincode,
				"shopSize":data.shopSize,
				"openTime":data.openTime,
				"closeTime":data.closeTime,
			}
			let criteria = {
				"shopId": data.shopId,
				"shopSize": data.shopSize,
				"openTime": data.openTime,
				"closeTime": data.closeTime
			}
			requestDAO.getRequestList(criteria,(err, data) => {
				if (data.length === 0) {
					requestDAO.createRequest(dataToSet, (err, dbData) => {
		                if (err) {
		                    cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
		                    return;
		                }
		                cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });
		            	return;
		            });
					return;
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "this request already exists", "result": {} });
				return;
			});
			// console.log(dataToSet);
			
		}
	}, (err, response) => {
		callback(response.request);
	});
}

/**API to resolve the request */
let resolveRequest = (data,callback) => {
	async.auto({
		resolveRequest :(cb) =>{
			if (!data.shopId) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			let criteria_localAuth = {
				"id": data.localAuthId,
				"pincode": data.pincode
			}
			let criteria_request = {
                "shopId" : data.shopId,
                "shopSize" : data.shopSize,
                "openTime" : data.openTime,
                "closeTime" : data.closeTime,
			}
			var dataToSet={
				"status": data.status,
			}
			// console.log(dataToSet);
			localAuthDAO.getLocalAuth(criteria_localAuth,(err, data) => {
				if (data.length === 0) {
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "You are not authorised", "result": {} });
					return;
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
	            requestDAO.resolveRequest(criteria_request, dataToSet, (err, dbData)=>{
		            if(err){
						cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
	                    return; 
	                }
	                else{
						cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": {}});                        
	                }
	            });
            });
		}
	}, (err,response) => {
		callback(response.resolveRequest);
	});
}

/***API to get request by pincode*/
let getRequestByPincode = (data, callback) => {
	async.auto({
		request: (cb) => {
			let criteria_localAuth = {
				"id": data.localAuthId,
				"pincode": data.pincode
			}
			let criteria_request = {
				"pincode": data.pincode,
				"status": data.status
			}
			localAuthDAO.getLocalAuth(criteria_localAuth,(err, data) => {
				if (data.length === 0) {
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "You are not authorised", "result": {} });
					return;
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				requestDAO.getRequestByPincode(criteria_request,(err, data) => {
					if (err) {
						cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
						return;
					}
					cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
					return;
				});
				return;
			});
			
		}
	}, (err, response) => {
		callback(response.request);
	})
}

/***API to get request by shopId*/
let getRequestList = (data, callback) => {
	async.auto({
		request: (cb) => {
			let criteria = {
				"shopId": data.shopId,
				"shopSize": data.shopSize,
				"openTime": data.openTime,
				"closeTime": data.closeTime
			}
			requestDAO.getRequestList(criteria,(err, data) => {
				if (data.length === 0) {
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_FOUR,"statusMessage": util.statusMessage.NOT_FOUND, "result": {} });
					return;
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.request);
	})
}

module.exports = {
    createRequest : createRequest,
    resolveRequest : resolveRequest,
    getRequestByPincode : getRequestByPincode,
    getRequestList : getRequestList
};