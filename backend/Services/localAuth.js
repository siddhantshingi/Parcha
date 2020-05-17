let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
localAuthDAO = require('../DAO/localAuthDAO'),
pincodeDAO = require('../DAO/pincodeDAO');

/**API to create the localAuth */
let createLocalAuth = (data, callback) => {
	async.auto({
		localAuth: (cb) => {
			var dataToSet = {
				"name":data.name,
				"email":data.email,
				"password":data.password,
				"mobileNumber":data.mobileNumber,
				"aadharNumber":data.aadharNumber,
				"pincode":data.pincode,
			}
			let criteria = {
				"email":data.email
			}
			let pincodeCriteria = {
				"pincode":data.pincode
			}
			localAuthDAO.getLocalAuth(criteria,(err, data) => {
				if (data.length === 0) {
					pincodeDAO.getPincode(pincodeCriteria, (err,data) => {
						if(data.length === 1)
						{
							localAuthDAO.createLocalAuth(dataToSet, (err, dbData) => {
								if (err) {
									cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
									return;
								}

								cb(null, { "statusCode": util.statusCode.TWO_ZERO_ONE, "statusMessage": util.statusMessage.CREATED + " New Local Authority Created", "result": dataToSet });
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
		callback(response.localAuth);
	});
}

/**API to update the localAuth */
let updateLocalAuth = (data,callback) => {
	async.auto({
		localAuthUpdate :(cb) =>{
			if (!data.id) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				"id" : data.id,
			}
			var dataToSet={
				"name":data.name,
				"mobileNumber":data.mobileNumber,
				"aadharNumber":data.aadharNumber,
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
						localAuthDAO.updateLocalAuth(criteria, dataToSet, (err, dbData)=>{
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
			else
			{
				localAuthDAO.updateLocalAuth(criteria, dataToSet, (err, dbData)=>{
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
		callback(response.localAuthUpdate);
	});
}

/**API to update the local Authority password*/
let updateLocalAuthPassword = (data,callback) => {
	async.auto({
		userUpdate :(cb) =>{
			if (!data.id || !data.newPassword || !data.newPassword) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				"id" : data.id
			}
			var dataToSet={
				"password":data.newPassword
			}
			localAuthDAO.getLocalAuth(criteria, (err, dbData)=>{
				if(err){
					cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
					return; 
				}
				else{
					if(dbData[0].password === data.oldPassword)
					{
						localAuthDAO.updateLocalAuth(criteria, dataToSet, (err, dbData)=>{
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
		callback(response.userUpdate);
	});
}

/***API to get the localAuth detail by email */
let getLocalAuth = (data, callback) => {
	async.auto({
		localAuth: (cb) => {
			let criteria = {
				"email": data.email,
				"id": data.id,
				"pincode": data.pincode,
			}
			localAuthDAO.getLocalAuth(criteria,(err, data) => {
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
		callback(response.localAuth);
	})
}

/***API to get the local authority */
let verifyLocalAuth = (data, callback) => {
	async.auto({
		user: (cb) => {
			if (!data.email || !data.password) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			let criteria = {
				"email":data.email
			}
			localAuthDAO.getLocalAuth(criteria,(err, getData) => {
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
		callback(response.user);
	})
}

module.exports = {
	createLocalAuth : createLocalAuth,
	updateLocalAuth : updateLocalAuth,
	getLocalAuth : getLocalAuth,
	verifyLocalAuth : verifyLocalAuth,
	updateLocalAuthPassword : updateLocalAuthPassword
};