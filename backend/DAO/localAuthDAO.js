let dbConfig = require("../Utilities/mysqlConfig");

let getLocalAuth = (criteria, callback) => {
    let conditions = "";
	criteria.email ? conditions += ` and email = '${criteria.email}'` : true;
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	criteria.pincode ? conditions += ` and pincode = '${criteria.pincode}'` : true;
	console.log(`select * from localAuths where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from localAuths where 1 ${conditions}`, callback);
}

let createLocalAuth = (dataToSet, callback) => {
	let setData = "";
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.mobileNumber ? setData += `, mobileNumber = '${dataToSet.mobileNumber}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.aadhaarNumber ? setData += `, aadhaarNumber = '${dataToSet.aadhaarNumber}'` : setData +=  `, aadhaarNumber = '------------'`;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	setData += `, emailVerification = 1`;
	setData += `, authVerification = 0`;
	console.log(`insert into localAuths set ${setData}`);
	dbConfig.getDB().query(`insert into localAuths set ${setData}`);
	console.log(`update localAuths, pincode set localAuths.state = pincode.state, localAuths.district = pincode.district where localAuths.pincode = pincode.pincode and localAuths.email = '${dataToSet.email}'`);
	dbConfig.getDB().query(`update localAuths, pincode set localAuths.state = pincode.state, localAuths.district = pincode.district where localAuths.pincode = pincode.pincode and localAuths.email = '${dataToSet.email}'`, callback);
}

let updateLocalAuth = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	criteria.id ? setData += `id = ${criteria.id}` : true;
	dataToSet.name ? setData += `, name = '${dataToSet.name}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.mobileNumber ? setData += `, mobileNumber = '${dataToSet.mobileNumber}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.aadhaarNumber ? setData += `, aadhaarNumber = '${dataToSet.aadhaarNumber}'` : true;
	dataToSet.state ? setData += `, state = '${dataToSet.state}'` : true;
	dataToSet.district ? setData += `, district = '${dataToSet.district}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	dataToSet.verificationStatus ? setData += `, verificationStatus = '${dataToSet.verificationStatus}'` : true;
	console.log(`UPDATE localAuths SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE localAuths SET ${setData} where 1 ${conditions}`);
	console.log(`update localAuths, pincode set localAuths.state = pincode.state, localAuths.district = pincode.district where localAuths.pincode = pincode.pincode and localAuths.id = '${criteria.id}'`);
	dbConfig.getDB().query(`update localAuths, pincode set localAuths.state = pincode.state, localAuths.district = pincode.district where localAuths.pincode = pincode.pincode and localAuths.id = '${criteria.id}'`, callback);
}

module.exports = {
	getLocalAuth : getLocalAuth,
	createLocalAuth : createLocalAuth,
	updateLocalAuth : updateLocalAuth
}