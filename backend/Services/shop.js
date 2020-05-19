let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
pincodeDAO = require('../DAO/pincodeDAO'),
shopDAO = require('../DAO/shopDAO');

/**API to create a shop */
let createShop = (data, callback) => {
	async.auto({
		shop: (cb) => {
			var dataToSet = {
				"shopName": data.shopName,
				"ownerName": data.ownerName,
				"email":data.email,
				"password":data.password,
				"mobileNumber":data.mobileNumber,
				"aadhaarNumber":data.aadhaarNumber,
				"address":data.address,
				"landmark":data.landmark,
				"shopTypeId":data.shopTypeId,
				"shopType":data.shopType,
				"pincode":data.pincode,
			}
			let criteria = {
				"email": data.email
			}
			let pincodeCriteria = {
				"pincode":data.pincode
			}
			shopDAO.getShopByEmail(criteria,(err, data) => {
				if (data.length === 0) {
					pincodeDAO.getPincode(pincodeCriteria, (err,data) => {
						if(data.length === 1)
						{
							shopDAO.createShop(dataToSet, (err, dbData) => {
								if (err) {
									cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
									return;
								}

								cb(null, { "statusCode": util.statusCode.TWO_ZERO_ONE, "statusMessage": util.statusMessage.CREATED + " New Shop Created", "result": dataToSet });
								return;
							});
						}
						else
						{
							cb(null, { "statusCode": util.statusCode.FOUR_ONE_TWO, "statusMessage": util.statusMessage.PRECONDITION_FAILED + " NO OR MULTIPLE PINCODE MATCHED", "result": {} });
							return;
						}
						if (err) {
							cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}
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
				"shopName": data.shopName,
				"ownerName": data.ownerName,
				"mobileNumber":data.mobileNumber,
				"aadhaarNumber":data.aadhaarNumber,
				"address":data.address,
				"landmark":data.landmark,
				"shopTypeId":data.shopTypeId,
				"shopType":data.shopType,
				"currOpeningTime":data.currOpeningTime,
				"currClosingTime":data.currClosingTime,
				"pincode":data.pincode
			}
			if(data.pincode)
			{
				var pincodeCriteria = {
					pincode : data.pincode,
				}
				pincodeDAO.getPincode(pincodeCriteria, (err,data) => {
					if(data.length === 1)
					{
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
					else
					{
						cb(null, { "statusCode": util.statusCode.FOUR_ONE_TWO, "statusMessage": util.statusMessage.PRECONDITION_FAILED + " NO OR MULTIPLE PINCODE MATCHED", "result": {} });
						return;
					}
					if (err) {
						cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
						return;
					}
				});
			}
			else {
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
		}
	}, (err,response) => {
		callback(response.shopUpdate);
	});
}

/**API to update the user password*/
let updateShopPassword = (data,callback) => {
	async.auto({
		shopUpdate :(cb) =>{
			if (!data.id || !data.oldPassword || !data.newPassword) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				"id" : data.id
			}
			var dataToSet={
				"password": data.newPassword
			}
			console.log(data);
			console.log(dataToSet);
			shopDAO.getShopById(criteria, (err, dbData)=>{
				if(err){
					cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
					return; 
				}
				else{
					console.log(dbData);
					if(dbData[0].password === data.oldPassword)
					{
						shopDAO.updateShopPassword(criteria, dataToSet, (err, dbData)=>{
							if(err){
								cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
								return; 
							}
							else
							{
								cb(null,{"statusCode":util.statusCode.OK,"statusMessage":util.statusMessage.SUCCESS + " Password Successfully Reset", "result": dbData });
								return; 
							}
						});
					}
					else
					{
						cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.UNAUTHORIZED + " Wrong Password", "result": {} });  
					}                      
				}
			});
		}
	}, (err,response) => {
		callback(response.shopUpdate);
	});
}

/***API to verify the shop */
let verifyShop = (data, callback) => {
	async.auto({
		shop: (cb) => {
			if (!data.email || !data.password) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			let criteria = {
				"email":data.email
			}
			shopDAO.getShopByEmail(criteria,(err, getData) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				if (getData.length === 0) {
					cb(null,{"statusCode": util.statusCode.FOUR_ZERO_FOUR,"statusMessage": util.statusMessage.NOT_FOUND + " Email-id not found", "result": {} });
					return;
				}
				else if(getData[0].password === data.password)
				{
					var result = getData[0];
					delete result.email;
					delete result.password;
					delete result.emailVerification;
					delete result.shopTypeId;
					delete result.capacityIdApp;
					cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": result });
					return;
				}
				else
				{
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ONE,"statusMessage": util.statusMessage.UNAUTHORIZED + " Password did not match", "result": {} });
					return;
				}
			});
		}
	}, (err, response) => {
		callback(response.shop);
	})
}

/***API to get shop for users */
let getShopForUser = (data, callback) => {
	async.auto({
		shop: (cb) => {
			let criteria = {
				"id":data.id,
				"shopName":data.shopName,
				"pincode":data.pincode,
				"shopType":data.shopType,
				"capacityApp":data.capacityApp,
			}
			shopDAO.getShopForUser(criteria,(err, data) => {
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


/***API to get shop for local Authorities */
let getShopForAuth = (data, callback) => {
	async.auto({
		shop: (cb) => {
			let criteria = {
				"id":data.id,
				"shopName":data.shopName,
				"pincode":data.pincode,
				"shopType":data.shopType,
				"capacityApp":data.capacityApp,
			}
			console.log(criteria);
			shopDAO.getShopForAuth(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				console.log(data);
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
	updateShopPassword : updateShopPassword,
	verifyShop : verifyShop,
	getShopForUser : getShopForUser,
	getShopForAuth : getShopForAuth,
	getPublicKey: getPublicKey
};