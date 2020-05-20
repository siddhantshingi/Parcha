let dbConfig = require("../Utilities/mysqlConfig");

let createRequest = (dataToSet, callback) => {
	let setData = "";
	dataToSet.shopId ? setData += `shopId = '${dataToSet.shopId}'` : true;
	dataToSet.shopName ? setData += `,shopName = '${dataToSet.shopName}'` : true;
	dataToSet.address ? setData += `,address = '${dataToSet.address}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	dataToSet.capacity ? setData += `, capacity = ${dataToSet.capacity}` : true;
	dataToSet.openingTime ? setData += `, openingTime = '${dataToSet.openingTime}'` : true;
    dataToSet.closingTime ? setData += `, closingTime = '${dataToSet.closingTime}'` : true;
	console.log(`insert into request set ${setData}`);
	dbConfig.getDB().query(`insert into request set ${setData}`, callback);
}


let resolveRequest = (criteria,dataToSet,callback) => {
	let setData = "";
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;
	dataToSet.authId ? setData += `, authId = '${dataToSet.authId}'` : true;
	dataToSet.authMobile ? setData += `, authMobile = '${dataToSet.authMobile}'` : true;

    let conditions = "";
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
    criteria.createdAt ? conditions += ` and createdAt = '${criteria.createdAt}'` : true;
	console.log(`UPDATE request SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE request SET ${setData} where 1 ${conditions}`,callback);
}

let getRequestByPincode = (criteria, callback) => {
    let conditions = "";
	criteria.pincode ? conditions += ` and request.pincode = '${criteria.pincode}'` : true;
	console.log(`select * from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select request.*, shops.name as shopName from request left join shops on request.shopId = shops.id where 1 ${conditions}`, callback);
}

let getRequest = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and request.shopId = '${criteria.shopId}'` : true;
	criteria.createdAt ? conditions += ` and request.createdAt = '${criteria.createdAt}'` : true;
	console.log(`select * from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from request where 1 ${conditions}`, callback);
}

let getRequestByShopId = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and request.shopId = '${criteria.shopId}'` : true;
	console.log(`select shopId, openingTime, closingTime, capacity, createdAt, status, authId, authMobile from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select shopId, openingTime, closingTime, capacity, createdAt, status, authId, authMobile from request where 1 ${conditions}`, callback);
}

let getRequestByAuthId = (criteria, callback) => {
    let conditions = "";
	criteria.authId ? conditions += ` and request.authId = '${criteria.authId}'` : true;
	console.log(`select shopId, shopName, address, openingTime, closingTime, capacity, createdAt, status from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select shopId, shopName, address, openingTime, closingTime, capacity, createdAt, status from request where 1 ${conditions}`, callback);
}

let getPendingRequests = (criteria, callback) => {
    let conditions = "";
	criteria.pincode ? conditions += ` and request.pincode = ${criteria.pincode}` : true;
	conditions += ' and status = 2'
	console.log(`select shopId, shopName, address, openingTime, closingTime, capacity, createdAT from request where 1 ${conditions}`);
	dbConfig.getDB().query(`select shopId, shopName, address, openingTime, closingTime, capacity, createdAT from request where 1 ${conditions}`, callback);
}

module.exports = {
    createRequest : createRequest,
    resolveRequest : resolveRequest,
    getRequestByPincode : getRequestByPincode,
	getRequest : getRequest,
	getPendingRequests : getPendingRequests,
	getRequestByShopId : getRequestByShopId,
	getRequestByAuthId : getRequestByAuthId
}