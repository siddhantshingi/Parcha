let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
shopDAO = require('../DAO/shopDAO');

/**API to create a shop */
let createShop = (data, callback) => {
	async.auto({
		shop: (cb) => {
			var dataToSet = {
				"id": data.id,
				"name": data.name,
				"owner": data.owner,
				"email":data.email,
				"contactNumber":data.contactNumber,
				"shopType":data.shopType,
				"address":data.address,
				"landmark":data.landmark,
				"password":data.password,
				"state":data.state,
				"district":data.district,
				"pincode":data.pincode,
				"verificationStatus":data.verificationStatus,
				"openTime":data.openTime,
				"closeTime":data.closeTime,
				"verifierId":data.verifierId,
				"shopSize":data.shopSize
			}
			let criteria = {
				"email": data.email
			}
			shopDAO.getShopByEmail(criteria,(err, data) => {
				if (data.length === 0) {
					shopDAO.createShop(dataToSet, (err, dbData) => {
						if (err) {
							cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}
						cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });
						});
				} else {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_NINE,"statusMessage": util.statusMessage.DUPLICATE_ENTRY, "result": {} });
					return;	
				}
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				
			});
			
		}
	}, (err, response) => {
		callback(response.shop);
	});
}

/**API to update the shop */
let updateShop = (data,callback) => {
	async.auto({
		shopUpdate :(cb) =>{
			if (!data.id) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				id : Number(data.id),
			}
			var dataToSet={
				"name": data.name,
				"owner": data.owner,
				"email":data.email,
				"contactNumber":data.contactNumber,
				"shopType":data.shopType,
				"address":data.address,
				"landmark":data.landmark,
				"password":data.password,
				"state":data.state,
				"district":data.district,
				"pincode":data.pincode,
				"verificationStatus":data.verificationStatus,
				"openTime":data.openTime,
				"closeTime":data.closeTime,
				"verifierId":data.verifierId,
				"shopSize":data.shopSize
			}
            shopDAO.updateShop(criteria, dataToSet, (err, dbData)=>{
	            if(err){
					cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
                    return; 
                }
                else{
					cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });                        
                }
            });
		}
	}, (err,response) => {
		callback(response.shopUpdate);
	});
}

/***API to get the shop details */
let getShop = (data, callback) => {
	async.auto({
		shop: (cb) => {
			let criteria = {
				"email": data.email,
				"name" : data.name,
				"shopType" : data.shopType,
				"pincode" : data.pincode,
				"shopId" : data.shopId,
				"shopSize" : data.shopSize,
				"verificationStatus" : data.verificationStatus 
			}
			shopDAO.getShop(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.shop);
	})
}

/***API to get the public key */
let getPublicKey = (data, callback) => {
	async.auto({
		pubKey: (cb) => {
			let fs = require("fs"),
			path = require("path");
			var absolutePath = path.resolve("public.pem");
    		var publicKey = fs.readFileSync(absolutePath, "utf8");
			cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": publicKey });
			return;
		}
	}, (err, response) => {
		console.log("statement before calllback");
		callback(response.pubKey);
	})
}

module.exports = {
	createShop : createShop,
	updateShop : updateShop,
	getShop : getShop,
	getPublicKey: getPublicKey
};