let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
requestDAO = require('../DAO/requestDAO');

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
			console.log(dataToSet);
			requestDAO.createRequest(dataToSet, (err, dbData) => {
                if (err) {
                    cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
                    return;
                }
                cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });
                });
			
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
			var criteria = {
                shopId : data.shopId,
                shopSize : data.shopSize,
                openTime : data.openTime,
                closeTime : data.closeTime,
                localAuthId : data.localAuthId
			}
			var dataToSet={
				"status": data.status,
			}
			// console.log(dataToSet);
            requestDAO.resolveRequest(criteria, dataToSet, (err, dbData)=>{
	            if(err){
					cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
                    return; 
                }
                else{
					cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": data });                        
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
			let criteria = {
				"pincode": data.pincode
			}
			requestDAO.getRequestByPincode(criteria,(err, data) => {
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

/***API to get request by shopId*/
let getRequestById = (data, callback) => {
	async.auto({
		request: (cb) => {
			let criteria = {
				"shopId": data.shopId
			}
			requestDAO.getRequestById(criteria,(err, data) => {
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
    getRequestById : getRequestById
};