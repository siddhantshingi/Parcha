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
	dataToSet.contactNumber ? setData += `, contactNumber = '${dataToSet.contactNumber}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.aadharNumber ? setData += `, aadharNumber = '${dataToSet.aadharNumber}'` : true;
	dataToSet.state ? setData += `, state = '${dataToSet.state}'` : true;
	dataToSet.district ? setData += `, district = '${dataToSet.district}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	setData += `, verificationStatus = ${dataToSet.verificationStatus}`;
	console.log(`insert into users set ${setData}`,'pankaj');
	dbConfig.getDB().query(`insert into users set ${setData}`, callback);
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
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
	dataToSet.email ? setData += `email = '${dataToSet.email}'` : true;
	dataToSet.contactNumber ? setData += `contactNumber = '${dataToSet.contactNumber}'` : true;
	dataToSet.password ? setData += `password = '${dataToSet.password}'` : true;
	dataToSet.aadharNumber ? setData += `aadharNumber = '${dataToSet.aadharNumber}'` : true;
	dataToSet.state ? setData += `state = '${dataToSet.state}'` : true;
	dataToSet.district ? setData += `district = '${dataToSet.district}'` : true;
	dataToSet.pincode ? setData += `pincode = '${dataToSet.pincode}'` : true;
	dataToSet.verificationStatus ? setData += `verificationStatus = '${dataToSet.verificationStatus}'` : true;
	console.log(`UPDATE users SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE users SET ${setData} where 1 ${conditions}`, callback);
}

module.exports = {
	getUser : getUser,
	getUserDetailUsingId : getUserDetailUsingId,
	getUserDetailUsingEmail : getUserDetailUsingEmail,
	createUser : createUser,
	deleteUser : deleteUser,
	updateUser : updateUser
}