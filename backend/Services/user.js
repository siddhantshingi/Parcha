let async = require('async'),
parseString = require('xml2js').parseString;

let util = require('../Utilities/util'),
userDAO = require('../DAO/userDAO');

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
			userDAO.getUserDetailUsingEmail(criteria,(err, data) => {
				if (data.length === 0) {
					userDAO.createUser(dataToSet, (err, dbData) => {
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
				id : data.id,
			}
			var dataToSet={
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
	}, (err,response) => {
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
		callback(response.removeUser);
	});
}

/***API to get the user list */
let getUser = (data, callback) => {
	async.auto({
		user: (cb) => {
			userDAO.getUser({},(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
				return;
			});
		}
	}, (err, response) => {
		callback(response.user);
	})
}

/***API to get the user detail by id */
let getUserById = (data, callback) => {
	async.auto({
		user: (cb) => {
			let criteria = {
				"id":data.id
			}
			userDAO.getUserDetailUsingId(criteria,(err, data) => {
				if (err) {
					cb(null, {"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
					return;
				}
				cb(null, {"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data[0] });
				return;
			});
		}
	}, (err, response) => {
		callback(response.user);
	})
}

/***API to get the user detail by email */
let getUserByEmail = (data, callback) => {
	async.auto({
		user: (cb) => {
			let criteria = {
				"email":data.email
			}
			userDAO.getUserDetailUsingEmail(criteria,(err, data) => {
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
		callback(response.user);
	})
}

module.exports = {
	sendEmail : sendEmail,
	createUser : createUser,
	updateUser : updateUser,
	deleteUser : deleteUser,
	getUser : getUser,
	getUserById : getUserById,
	getUserByEmail : getUserByEmail
};