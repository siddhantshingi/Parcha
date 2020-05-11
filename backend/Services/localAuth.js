let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
localAuthDAO = require('../DAO/localAuthDAO');

let email   = require('emailjs/email');
sender_email = require("../Utilities/config").sender_email;
sender_password = require("../Utilities/config").sender_password;

/**API to create the user */
let createLocalAuth = (data, callback) => {
	async.auto({
		localAuth: (cb) => {
			var dataToSet = {
				"id":data.id,
				"name":data.name,
				"email":data.email,
				"contactNumber":data.contactNumber,
				"password":data.password,
				"aadharNumber":data.aadharNumber,
				"state":data.state,
				"district":data.district,
				"pincode":data.pincode,
				"verificationStatus":data.verificationStatus,
			}
			let criteria = {
				"email":data.email
			}
			localAuthDAO.getLocalAuthByEmail(criteria,(err, data) => {
				if (data.length === 0) {
					localAuthDAO.createLocalAuth(dataToSet, (err, dbData) => {
						if (err) {
							cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
							return;
						}

						cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DATA_UPDATED, "result": dataToSet });
						return;
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
		callback(response.localAuth);
	});
}

/**API to update the user */
let updateLocalAuth = (data,callback) => {
	async.auto({
		localAuthUpdate :(cb) =>{
			if (!data.id) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				id : data.id,
			}
			var dataToSet={
				"name":data.name,
				"name":data.name,
				"email":data.email,
				"contactNumber":data.contactNumber,
				"password":data.password,
				"aadharNumber":data.aadharNumber,
				"state":data.state,
				"district":data.district,
				"pincode":data.pincode,
				"verificationStatus":data.verificationStatus
			}
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
	}, (err,response) => {
		callback(response.localAuthUpdate);
	});
}

/***API to get the user detail by email */
let getLocalAuthByEmail = (data, callback) => {
	async.auto({
		localAuth: (cb) => {
			let criteria = {
				"email": data.email
			}
			localAuthDAO.getLocalAuthByEmail(criteria,(err, data) => {
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
		callback(response.localAuth);
	})
}

module.exports = {
	createLocalAuth : createLocalAuth,
	updateLocalAuth : updateLocalAuth,
	getLocalAuthByEmail : getLocalAuthByEmail
};