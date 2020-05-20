let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
userDAO = require('../DAO/userDAO'),
pincodeDAO = require('../DAO/pincodeDAO');

let email   = require('emailjs/email');
sender_email = require("../Utilities/config").sender_email;
sender_password = require("../Utilities/config").sender_password;

//send email
let sendEmail = (data_pack, callback) => {
	var server  = email.server.connect({
	   user:    sender_email,
	   password:sender_password, 
	   host:    "smtp.gmail.com", 
	   ssl:     true
	});
	server.send({
		   from:    sender_email, 
		   to:      data_pack.email,
		   subject: data_pack.subject,
		   text:    data_pack.msg, 
	}, (err, response) => { 
	    if(err)
	    	console.log(err);
	    else {
	    	console.log("Email Sent!!");
	    	callback(response.user);
	    }
	});
}

/**API to create the user */
let createUser = (data, callback) => {
	async.auto({
		user: (cb) => {
			var dataToSet = {
				"name":data.name,
				"email":data.email,
				"mobileNumber":data.mobileNumber,
				"password":data.password,
				"aadharNumber":data.aadharNumber,
				"pincode":data.pincode,
			}
			let criteria = {
				"email":data.email
			}
			let pincodeCriteria = {
				"pincode":data.pincode
			}
			userDAO.getUserDetailUsingEmail(criteria,(err, data) => {
				if (data.length === 0) {
					pincodeDAO.getPincode(pincodeCriteria, (err,data) => {
						if(data.length === 1)
						{
							userDAO.createUser(dataToSet, (err, dbData) => {
								if (err) {
									cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
									return;
								}

								cb(null, { "statusCode": util.statusCode.TWO_ZERO_ONE, "statusMessage": util.statusMessage.CREATED + " New User Created", "result": dataToSet });
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
		console.log(response.user);

		callback(response.user);
	});
}

/**API to update the user */
let updateUser = (data,callback) => {
	async.auto({
		userUpdate :(cb) =>{
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
						userDAO.updateUser(criteria, dataToSet, (err, dbData)=>{
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
				userDAO.updateUser(criteria, dataToSet, (err, dbData)=>{
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
		console.log(response.userUpdate);

		callback(response.userUpdate);
	});
}

/**API to update the user password*/
let updateUserPassword = (data,callback) => {
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
			userDAO.getUserDetailUsingId(criteria, (err, dbData)=>{
				if(err){
					cb(null,{"statusCode":util.statusCode.FOUR_ZERO_ZERO,"statusMessage":util.statusMessage.BAD_REQUEST + err, "result": {} });
					return; 
				}
				else{
					if(dbData[0].password === data.oldPassword)
					{
						userDAO.updateUserPassword(criteria, dataToSet, (err, dbData)=>{
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
		console.log(response.userUpdate);

		callback(response.userUpdate);
	});
}

/**API to delete the user */
let deleteUser = (data,callback) => {
	async.auto({
		removeUser :(cb) =>{
			if (!data.id) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			var criteria = {
				id : data.id,
			}
			userDAO.deleteUser(criteria,(err,dbData) => {
				if (err) {
					cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ZERO, "statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, { "statusCode": util.statusCode.OK, "statusMessage": util.statusMessage.DELETE_DATA, "result": {} });
			});
		}
	}, (err,response) => {
		console.log(response.removeUser);
		callback(response.removeUser);
	});
}

/***API to get the user list */
let verifyUser = (data, callback) => {
	async.auto({
		user: (cb) => {
			if (!data.email || !data.password) {
				cb(null, { "statusCode": util.statusCode.FOUR_ZERO_ONE, "statusMessage": util.statusMessage.PARAMS_MISSING, "result": {} })
				return;
			}
			let criteria = {
				"email":data.email
			}
			userDAO.getUserDetailUsingEmail(criteria,(err, getData) => {
				console.log(getData);
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
					console.log(result);
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
		console.log(response.user);

		callback(response.user);
	})
}

module.exports = {
	sendEmail : sendEmail,
	createUser : createUser,
	updateUser : updateUser,
	deleteUser : deleteUser,
	verifyUser : verifyUser,
	updateUserPassword : updateUserPassword
};