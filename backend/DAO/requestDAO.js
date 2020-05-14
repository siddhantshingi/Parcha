let dbConfig = require("../Utilities/mysqlConfig");

let createRequest = (dataToSet, callback) => {
	let setData = "";
	dataToSet.shopId ? setData += `shopId = '${dataToSet.shopId}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	dataToSet.shopSize ? setData += `, shopSize = ${dataToSet.shopSize}` : true;
	dataToSet.openTime ? setData += `, openTime = '${dataToSet.openTime}'` : true;
    dataToSet.closeTime ? setData += `, closeTime = '${dataToSet.closeTime}'` : true;
    setData += `, Time = now(), status = 0`;
	console.log(`insert into request set ${setData}`);
	dbConfig.getDB().query(`insert into request set ${setData}`, callback);
}


let resolveRequest = (criteria,dataToSet,callback) => {
	let setData = "";
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;

    let conditions = "";
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
    criteria.shopSize ? conditions += ` and shopSize = ${criteria.shopSize}` : true;
    criteria.openTime ? conditions += ` and openTime = '${criteria.openTime}'` : true;
    criteria.closeTime ? conditions += ` and closeTime = '${criteria.closeTime}'` : true;
	console.log(`UPDATE request SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE request SET ${setData} where 1 ${conditions}`,callback);
}

let getRequestByPincode = (criteria, callback) => {
    let conditions = "";
	criteria.pincode ? conditions += ` and request.pincode = '${criteria.pincode}'` : true;
	console.log(`select * from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select request.*, shops.name as shopName from request left join shops on request.shopId = shops.id where 1 ${conditions}`, callback);
}

let getRequestList = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and request.shopId = '${criteria.shopId}'` : true;
	criteria.openTime ? conditions += ` and request.openTime = '${criteria.openTime}'` : true;
	criteria.closeTime ? conditions += ` and request.closeTime = '${criteria.closeTime}'` : true;
	criteria.shopSize ? conditions += ` and request.shopSize = ${criteria.shopSize}` : true;
	console.log(`select * from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select request.*, shops.name as shopName from request left join shops on request.shopId=shops.id where 1 ${conditions}`, callback);
}

module.exports = {
    createRequest : createRequest,
    resolveRequest : resolveRequest,
    getRequestByPincode : getRequestByPincode,
    getRequestList : getRequestList
}