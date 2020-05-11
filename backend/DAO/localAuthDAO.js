let dbConfig = require("../Utilities/mysqlConfig");

let getLocalAuthByEmail = (criteria, callback) => {
    let conditions = "";
	criteria.email ? conditions += ` and email = '${criteria.email}'` : true;
	console.log(`select * from localAuths where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from localAuths where 1 ${conditions}`, callback);
}

let createLocalAuth = (dataToSet, callback) => {
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
	console.log(`insert into localAuths set ${setData}`);
	dbConfig.getDB().query(`insert into localAuths set ${setData}`, callback);
}

let updateLocalAuth = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.contactNumber ? setData += `, contactNumber = '${dataToSet.contactNumber}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.aadharNumber ? setData += `, aadharNumber = '${dataToSet.aadharNumber}'` : true;
	dataToSet.state ? setData += `, state = '${dataToSet.state}'` : true;
	dataToSet.district ? setData += `, district = '${dataToSet.district}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	dataToSet.verificationStatus ? setData += `, verificationStatus = '${dataToSet.verificationStatus}'` : true;
	console.log(`UPDATE localAuths SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE localAuths SET ${setData} where 1 ${conditions}`, callback);
}

module.exports = {
	getLocalAuthByEmail : getLocalAuthByEmail,
	createLocalAuth : createLocalAuth,
	updateLocalAuth : updateLocalAuth
}