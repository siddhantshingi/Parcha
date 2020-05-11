let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
shopDAO = require('../DAO/shopDAO');

let email   = require('emailjs/email');
sender_email = require("../Utilities/config").sender_email;
sender_password = require("../Utilities/config").sender_password;

/**API to create the user */
let createShop = (data, callback) => {
	async.auto({
		shop: (cb) => {
			console.log(data);
			var dataToSet = {
				"id": data.id,
				"name": data.name,
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
				"capacity":data.capacity,
				"slotDuration":data.slotDuration,
				"bufferDuration":data.bufferDuration,
				"openTime":data.openTime,
				"closeTime":data.closeTime,
			}
			console.log(dataToSet);
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
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + "EmailID already exists", "result": {} });
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

/**API to update the user */
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
				"name":data.name,
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
				"capacity":data.capacity,
				"slotDuration":data.slotDuration,
				"bufferDuration":data.bufferDuration,
				"openTime":data.openTime,
				"closeTime":data.closeTime,
			}
			console.log(dataToSet);
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

/***API to get the user list */
let getShopListByName = (data, callback) => {
	async.auto({
		shopList: (cb) => {
			let criteria = {
				"name": data.name
			}
			shopDAO.getShopListByName(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.shopList);
	})
}

/***API to get the user list */
let getShopListByCategory = (data, callback) => {
	async.auto({
		shopList: (cb) => {
			let criteria = {
				"category": data.category
			}
			shopDAO.getShopListByCategory(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.shopList);
	})
}

/***API to get the shop details by email */
let getShopByEmail = (data, callback) => {
	async.auto({
		shop: (cb) => {
			let criteria = {
				"email": data.email
			}
			shopDAO.getShopByEmail(criteria,(err, data) => {
				if (data.length === 0) {
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_FOUR,"statusMessage": util.statusMessage.NOT_FOUND, "result": {} });
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
		callback(response.shop);
	})
}

module.exports = {
	createShop : createShop,
	updateShop : updateShop,
	getShopListByName : getShopListByName,
	getShopListByCategory : getShopListByCategory,
	getShopByEmail : getShopByEmail
};