let dbConfig = require("../Utilities/mysqlConfig");

let createShop = (dataToSet, callback) => {
	let setData = "";
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
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
	if (typeof dataToSet.capacity !== 'undefined' && dataToSet.capacity !== null) 
		setData += `, capacity = ${dataToSet.capacity}`;
	dataToSet.slotDuration ? setData += `, slotDuration = '${dataToSet.slotDuration}'` : true;
	dataToSet.bufferDuration ? setData += `, bufferDuration = '${dataToSet.bufferDuration}'` : true;
	dataToSet.openTime ? setData += `, openTime = '${dataToSet.openTime}'` : true;
	dataToSet.closeTime ? setData += `, closeTime = '${dataToSet.closeTime}'` : true;
	console.log(`insert into shops set ${setData}`);
	dbConfig.getDB().query(`insert into shops set ${setData}`, callback);
}


let updateShop = (criteria,dataToSet,callback) => {
	let setData = "";
	dataToSet.name ? setData += `name = '${dataToSet.name}'` : true;
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
	if (typeof dataToSet.capacity !== 'undefined' && dataToSet.capacity !== null) 
		setData += `, capacity = ${dataToSet.capacity}`;
	dataToSet.slotDuration ? setData += `, slotDuration = '${dataToSet.slotDuration}'` : true;
	dataToSet.bufferDuration ? setData += `, bufferDuration = '${dataToSet.bufferDuration}'` : true;
	dataToSet.openTime ? setData += `, openTime = '${dataToSet.openTime}'` : true;
	dataToSet.closeTime ? setData += `, closeTime = '${dataToSet.closeTime}'` : true;

    let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	
	console.log(`UPDATE shops SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE shops SET ${setData} where 1 ${conditions}`, callback);
}

let getShopByEmail = (criteria, callback) => {
    let conditions = "";
	criteria.email ? conditions += ` and email = '${criteria.email}'` : true;
	console.log(`select * from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shops where 1 ${conditions}`, callback);
}

let getShopListByName = (criteria, callback) => {
    let conditions = "";
	criteria.name ? conditions += ` and name = '${criteria.name}'` : true;
	console.log(`select * from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shops where 1 ${conditions}`, callback);
}

let getShopListByCategory = (criteria, callback) => {
    let conditions = "";
	criteria.category ? conditions += ` and category = '${criteria.category}'` : true;
	console.log(`select * from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shops where 1 ${conditions}`, callback);
}

module.exports = {
	createShop : createShop,
	updateShop : updateShop,
	getShopListByName : getShopListByName,
	getShopListByCategory : getShopListByCategory,
	getShopByEmail : getShopByEmail
}