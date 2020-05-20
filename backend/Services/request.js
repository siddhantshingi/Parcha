let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
requestDAO = require('../DAO/requestDAO'),
localAuthDAO = require('../DAO/localAuthDAO'),
shopDAO = require('../DAO/shopDAO');


/**API to create a request */
let createRequest = (data, callback) => {
	async.auto({
		request: (cb) => {
			console.log(data);
			var dataToSet = {
				"shopId": data.shopId,
				"shopName": data.shopName,
				"address": data.address,
				"pincode": data.pincode,
				"capacity":data.capacity,
				"openingTime":data.openingTime,
				"closingTime":data.closingTime,
			}
			var criteria = {
				"id" : data.shopId,
			}
			// console.log(data,dataToSet,criteria);
			shopDAO.getShopById(criteria, (err,shopData) => {
				if (err) {
					cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				var conflict = 0;
				if(data.capacity)
				{
					if(data.capacity <= shopData[0].capacityApp)
					{
						conflict = 1;
					}
				}
				if(data.openingTime)
				{
					if((shopData[0].openingTimeApp <= data.openingTime) && (shopData[0].closingTimeApp >= data.closingTime))
					{
						conflict = 1;
					}
				}
				if(conflict === 1)
				{
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_NINE,"statusMessage": util.statusMessage.PRECONDITION_FAILED, "result": {} });
					return;
				}
				else
				{
					requestDAO.createRequest(dataToSet, (err, dbData) => {
						if (err) {
							cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}
						cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });
						return;
					});
				}
				
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
			let shop_criteria= {
				"id": data.shopId
			}
			let criteria_request = {
				"shopId" : data.shopId,
				"createdAt" : data.createdAt
			}
			var dataToSet={
				"status": data.accepted,
				"authId" : data.authId,
				"authMobile" : data.authMobile
			}
			// console.log(dataToSet);
			shopDAO.getShopById(shop_criteria, (err, shopData) =>
			{
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				if(data.authPincode === shopData[0].pincode)
				{
					requestDAO.getRequest(criteria_request, (err,data) => {
						if (err) {
							cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}
						if(data[0].status === 2) // still pending
						{
							//resolve request
							requestDAO.resolveRequest(criteria_request, dataToSet, (err,data) => {
								if (err) {
									cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
									return;
								}
								else
								{
									cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED + " REQUEST RESOLVED", "result": {}}); 
									return;
								}
							});
						}
						else
						{
							cb(null, {"statusCode": util.statusCode.FOUR_ZERO_NINE,"statusMessage": util.statusMessage.CONFLICT + " REQUEST ALREADY RESOLVED", "result": {} });
					return;
						}
					});
				}
				else
				{
					cb(null, {"statusCode": util.statusCode.FOUR_ONE_TWO,"statusMessage": util.statusMessage.PRECONDITION_FAILED + " PINCODES DID NOT MATCH", "result": {} });
					return;
				}
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
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_ONE,"statusMessage": util.statusMessage.UNAUTHORIZED, "result": {} });
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
let getRequestByShopId = (data, callback) => {
	async.auto({
		request: (cb) => {
			let criteria = {
				"shopId": data.shopId
			}
			requestDAO.getRequestByShopId(criteria,(err, data) => {
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

/***API to get request by authId*/
let getRequestByAuthId = (data, callback) => {
	async.auto({
		request: (cb) => {
			let criteria = {
				"authId": data.authId
			}
			requestDAO.getRequestByAuthId(criteria,(err, data) => {
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

/***API to get pending requests by pincode*/
let getPendingRequests = (data, callback) => {
	async.auto({
		request: (cb) => {
			let criteria = {
				"pincode": data.pincode
			}
			requestDAO.getPendingRequests(criteria,(err, data) => {
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
	getPendingRequests : getPendingRequests,
	getRequestByShopId : getRequestByShopId,
	getRequestByAuthId : getRequestByAuthId
};