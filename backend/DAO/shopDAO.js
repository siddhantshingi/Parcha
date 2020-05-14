let dbConfig = require("../Utilities/mysqlConfig");

let createShop = (dataToSet, callback) => {
	let setData = "";
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
	dataToSet.owner ? setData += `, owner = '${dataToSet.owner}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.contactNumber ? setData += `, contactNumber = '${dataToSet.contactNumber}'` : true;
	dataToSet.shopType ? setData += `, shopType = '${dataToSet.shopType}'` : true;
	dataToSet.address ? setData += `, address = '${dataToSet.address}'` : true;
	dataToSet.landmark ? setData += `, landmark = '${dataToSet.landmark}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.state ? setData += `, state = '${dataToSet.state}'` : true;
	dataToSet.district ? setData += `, district = '${dataToSet.district}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	if (typeof dataToSet.verificationStatus !== 'undefined' && dataToSet.verificationStatus !== null) 
		setData += `, verificationStatus = ${dataToSet.verificationStatus}`;
	dataToSet.openTime ? setData += `, openTime = '${dataToSet.openTime}'` : true;
	dataToSet.closeTime ? setData += `, closeTime = '${dataToSet.closeTime}'` : true;
	if (typeof dataToSet.verifierId !== 'undefined' && dataToSet.verifierId !== null) 
		setData += `, verifierId = ${dataToSet.verifierId}`;
	if (typeof dataToSet.shopSize !== 'undefined' && dataToSet.shopSize !== null) 
		setData += `, shopSize = ${dataToSet.shopSize}`;
	console.log(`insert into shops set ${setData}`);
	dbConfig.getDB().query(`insert into shops set ${setData}`, callback);
}


let updateShop = (criteria,dataToSet,callback) => {
	let setData = "";
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
	dataToSet.owner ? setData += `, owner = '${dataToSet.owner}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.contactNumber ? setData += `, contactNumber = '${dataToSet.contactNumber}'` : true;
	if (typeof dataToSet.shopType !== 'undefined' && dataToSet.shopType !== null) 
		setData += `, shopType = ${dataToSet.shopType}`;
	dataToSet.address ? setData += `, address = '${dataToSet.address}'` : true;
	dataToSet.landmark ? setData += `, landmark = '${dataToSet.landmark}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.state ? setData += `, state = '${dataToSet.state}'` : true;
	dataToSet.district ? setData += `, district = '${dataToSet.district}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	if (typeof dataToSet.verificationStatus !== 'undefined' && dataToSet.verificationStatus !== null) 
		setData += `, verificationStatus = ${dataToSet.verificationStatus}`;
	dataToSet.openTime ? setData += `, openTime = '${dataToSet.openTime}'` : true;
	dataToSet.closeTime ? setData += `, closeTime = '${dataToSet.closeTime}'` : true;
	if (typeof dataToSet.verifierId !== 'undefined' && dataToSet.verifierId !== null) 
		setData += `, verifierId = ${dataToSet.verifierId}`;
	if (typeof dataToSet.shopSize !== 'undefined' && dataToSet.shopSize !== null) 
		setData += `, shopSize = ${dataToSet.shopSize}`;
	
    let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	
	console.log(`UPDATE shops SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE shops SET ${setData} where 1 ${conditions}`, callback);
}

let getShop = (criteria, callback) => {
    let conditions = "";
	criteria.email ? conditions += ` and email = '${criteria.email}'` : true;
	criteria.name ? conditions += ` and name = '${criteria.name}'` : true;
	criteria.pincode ? conditions += ` and pincode = '${criteria.pincode}'` : true;
	criteria.shopId ? conditions += ` and id = ${criteria.shopId}` : true;
	if (typeof criteria.shopType !== 'undefined' && criteria.shopType !== null) 
		conditions += `and shopType = ${criteria.shopType}`;
	if (typeof criteria.shopSize !== 'undefined' && criteria.shopSize !== null) 
		conditions += `and shopSize = ${criteria.shopSize}`;
	if (typeof criteria.verificationStatus !== 'undefined' && criteria.verificationStatus !== null) 
		conditions += `and verificationStatus = ${criteria.verificationStatus}`;
	console.log(`select * from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shops where 1 ${conditions}`, callback);
}

let getShopWithShopSize = (criteria, callback) => {
    let conditions = "";
	if (typeof criteria.verificationStatus !== 'undefined' && criteria.verificationStatus !== null) 
		conditions += `and verificationStatus = ${criteria.verificationStatus}`;
	console.log(`select shops.id, shops.shopSize, shops.openTime, shops.closeTime, shopSizes.capacity, shopSizes.slotDuration, shopSizes.bufferDuration from shops left join shopSizes on shops.shopSize = shopSizes.id where 1 ${conditions}`);
	dbConfig.getDB().query(`select shops.id, shops.shopSize, shops.openTime, shops.closeTime, shopSizes.capacity, shopSizes.slotDuration, shopSizes.bufferDuration from shops left join shopSizes on shops.shopSize = shopSizes.id where 1 ${conditions}`, callback);
}

module.exports = {
	createShop : createShop,
	updateShop : updateShop,
	getShop : getShop,
	getShopWithShopSize : getShopWithShopSize
}