let dbConfig = require("../Utilities/mysqlConfig");

let getUser = (criteria, callback) => {
	console.log(`select * from users where 1`);
	dbConfig.getDB().query(`select * from users where 1`, callback);
}

let getUserDetailUsingId = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	console.log(`select * from users where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from users where 1 ${conditions}`, callback);
}

let getUserDetailUsingEmail = (criteria, callback) => {
    let conditions = "";
	criteria.email ? conditions += ` and email = '${criteria.email}'` : true;
	console.log(`select * from users where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from users where 1 ${conditions}`, callback);
}

let createUser = (dataToSet, callback) => {
	let setData = "";
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.mobileNumber ? setData += `, mobileNumber = '${dataToSet.mobileNumber}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.aadharNumber ? setData += `, aadharNumber = '${dataToSet.aadharNumber}'` : setData +=  `, aadharNumber = '------------'`;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	setData += `, emailVerification = 1`;
	setData += `, mobileVerification = 0`;
	console.log(`insert into users set ${setData}`);
	console.log(`update users, pincode set users.state = pincode.state, users.district = pincode.district where users.pincode = pincode.pincode and users.email = '${dataToSet.email}'`);
	dbConfig.getDB().query(`insert into users set ${setData}`);
	dbConfig.getDB().query(`update users, pincode set users.state = pincode.state, users.district = pincode.district where users.pincode = pincode.pincode and users.email = '${dataToSet.email}'`, callback);
}

let deleteUser = (criteria, callback) => {
	let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	console.log(`delete from users where 1 ${conditions}`);
	dbConfig.getDB().query(`delete from users where 1 ${conditions}`, callback);
}

let updateUser = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	criteria.id ? setData += `id = '${criteria.id}'` : true;
	dataToSet.name ? setData += `, name = '${dataToSet.name}'` : true;
	dataToSet.mobileNumber ? setData += `, mobileNumber = '${dataToSet.mobileNumber}'` : true;
	dataToSet.aadharNumber ? setData += `, aadharNumber = '${dataToSet.aadharNumber}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	console.log(`UPDATE users SET ${setData} where 1 ${conditions}`);
	console.log(`update users, pincode set users.state = pincode.state, users.district = pincode.district where users.pincode = pincode.pincode and users.id = '${criteria.id}'`);
	dbConfig.getDB().query(`UPDATE users SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`update users, pincode set users.state = pincode.state, users.district = pincode.district where users.pincode = pincode.pincode and users.id = '${criteria.id}'`, callback);
}

let updateUserPassword = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	criteria.id ? setData += `id = '${criteria.id}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	console.log(`UPDATE users SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE users SET ${setData} where 1 ${conditions}`, callback);
}

module.exports = {
	getUser : getUser,
	getUserDetailUsingId : getUserDetailUsingId,
	getUserDetailUsingEmail : getUserDetailUsingEmail,
	createUser : createUser,
	deleteUser : deleteUser,
	updateUser : updateUser,
	updateUserPassword : updateUserPassword
}