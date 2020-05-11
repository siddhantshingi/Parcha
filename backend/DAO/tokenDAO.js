let dbConfig = require("../Utilities/mysqlConfig");

let bookToken = (dataToSet, callback) => {
	let setData = "";
	dataToSet.verified ? setData += `verified = ${dataToSet.verified}` : `verified = 0`;
	dataToSet.date ? setData += `, date = '${dataToSet.date}'` : true;
	dataToSet.userId ? setData += `, userId = ${dataToSet.userId}` : true;
	dataToSet.shopId ? setData += `, shopId = ${dataToSet.shopId}` : true;
	dataToSet.startTime ? setData += `, startTime = '${dataToSet.startTime}'` : true;
	dataToSet.duration ? setData += `, duration = '${dataToSet.duration}'` : true;
	dataToSet.status ? setData += `, status = '${dataToSet.status}'` : true;
	console.log(`insert into tokens set ${setData}`);
	dbConfig.getDB().query(`insert into tokens set ${setData}`, callback);
}

let cancelToken = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;
	console.log(`UPDATE tokens SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData} where 1 ${conditions}`, callback);
}

let getToken = (criteria, callback) => {
    let conditions = "";
	criteria.tokenId ? conditions += ` and id = ${criteria.tokenId}` : true;
	criteria.userId ? conditions += ` and userId = ${criteria.userId}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.startTime ? conditions += ` and startTime = '${criteria.startTime}'` : true;
	criteria.duration ? conditions += ` and duration = '${criteria.duration}'` : true;
	criteria.dateLowerLim ? conditions += ` and dateLowerLim = '${criteria.dateLowerLim}'` : true;
	criteria.dateUpperLim ? conditions += ` and dateUpperLim = '${criteria.dateUpperLim}'` : true;
	criteria.status ? conditions += ` and status = ${criteria.status}` : true;
	criteria.verified ? conditions += ` and verified = ${criteria.verified}` : true;
	console.log(`select * from tokens where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from tokens where 1 ${conditions}`, callback);
}

module.exports = {
	bookToken : bookToken,
	cancelToken : cancelToken,
	getToken : getToken
}