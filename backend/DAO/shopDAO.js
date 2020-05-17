let dbConfig = require("../Utilities/mysqlConfig");

//service/shop.js/createShop
let createShop = (dataToSet, callback) => {
	let setData = "";
	dataToSet.shopName ? setData += `shopName = '${dataToSet.shopName}'` : true;
	dataToSet.ownerName ? setData += `, ownerName = '${dataToSet.ownerName}'` : true;
	dataToSet.email ? setData += `, email = '${dataToSet.email}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	dataToSet.mobileNumber ? setData += `, mobileNumber = '${dataToSet.mobileNumber}'` : true;
	dataToSet.aadhaarNumber ? setData += `, aadhaarNumber = '${dataToSet.aadhaarNumber}'` : true;
	dataToSet.address ? setData += `, address = '${dataToSet.address}'` : true;
	dataToSet.landmark ? setData += `, landmark = '${dataToSet.landmark}'` : true;
	if (typeof dataToSet.shopTypeId !== 'undefined' && dataToSet.shopTypeId !== null) 
		setData += `, shopTypeId = ${dataToSet.shopTypeId}`;
	dataToSet.shopType ? setData += `, shopType = '${dataToSet.shopType}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	console.log(`insert into shops set ${setData}`);
	dbConfig.getDB().query(`insert into shops set ${setData}`);
	console.log(`update shops, pincode set shops.state = pincode.state, shops.district = pincode.district where shops.pincode = pincode.pincode and shops.email = '${dataToSet.email}'`);
	dbConfig.getDB().query(`update shops, pincode set shops.state = pincode.state, shops.district = pincode.district where shops.pincode = pincode.pincode and shops.email = '${dataToSet.email}'`, callback);
}

//service/shop.js/updateShop
let updateShop = (criteria,dataToSet,callback) => {
	let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	criteria.id ? setData += `id = '${criteria.id}'` : true;
	dataToSet.shopName ? setData += `, shopName = '${dataToSet.shopName}'` : true;
	dataToSet.ownerName ? setData += `, ownerName = '${dataToSet.ownerName}'` : true;
	dataToSet.mobileNumber ? setData += `, mobileNumber = '${dataToSet.mobileNumber}'` : true;
	dataToSet.aadharNumber ? setData += `, aadharNumber = '${dataToSet.aadharNumber}'` : true;
	dataToSet.address ? setData += `, address = '${dataToSet.address}'` : true;
	dataToSet.landmark ? setData += `, landmark = '${dataToSet.landmark}'` : true;
	if (typeof dataToSet.shopTypeId !== 'undefined' && dataToSet.shopTypeId !== null) 
		setData += `, shopTypeId = ${dataToSet.shopTypeId}`;
	dataToSet.shopType ? setData += `, shopType = '${dataToSet.shopType}'` : true;
	dataToSet.currOpeningTime ? setData += `, currOpeningTime = '${dataToSet.currOpeningTime}'` : true;
	dataToSet.currClosingTime ? setData += `, currClosingTime = '${dataToSet.currClosingTime}'` : true;
	dataToSet.pincode ? setData += `, pincode = '${dataToSet.pincode}'` : true;
	console.log(`UPDATE shops SET ${setData} where 1 ${conditions}`);
	console.log(`update shops, pincode set shops.state = pincode.state, shops.district = pincode.district where shops.pincode = pincode.pincode and shops.id = '${criteria.id}'`);
	dbConfig.getDB().query(`UPDATE shops SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`update shops, pincode set shops.state = pincode.state, shops.district = pincode.district where shops.pincode = pincode.pincode and shops.id = '${criteria.id}'`, callback);
}

//service/shop.js/updateShopPassword
let updateShopPassword = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	criteria.id ? setData += `id = '${criteria.id}'` : true;
	dataToSet.password ? setData += `, password = '${dataToSet.password}'` : true;
	console.log("in update password");
	console.log(`UPDATE shops SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE shops SET ${setData} where 1 ${conditions}`, callback);
}

//service/shop.js/getShopForUser
let getShopForUser = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and shops.id = '${criteria.id}'` : true;
	criteria.shopName ? conditions += ` and shops.shopName = '${criteria.shopName}'` : true;
	criteria.pincode ? conditions += ` and shops.pincode = '${criteria.pincode}'` : true;
	criteria.shopType ? conditions += ` and shops.shopType = '${criteria.shopType}'` : true;
	criteria.capacityApp ? conditions += ` and shops.capacityApp = '${criteria.capacityApp}'` : true;
	console.log(`select id, shopName, ownerName, mobileNumber, address, landmark, shopType, capacityApp, currOpeningTime, currClosingTime from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select id, shopName, ownerName, mobileNumber, aadhaarNumber, address, landmark, capacityApp, shopType, currOpeningTime, currClosingTime from shops where 1 ${conditions}`, callback);
}

//service/shop.js/getShopForLocalAuth
let getShopForAuth = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and shops.id = '${criteria.id}'` : true;
	criteria.shopName ? conditions += ` and shops.shopName = '${criteria.shopName}'` : true;
	criteria.pincode ? conditions += ` and shops.pincode = '${criteria.pincode}'` : true;
	criteria.shopType ? conditions += ` and shops.shopType = '${criteria.shopType}'` : true;
	criteria.capacityApp ? conditions += ` and shops.capacityApp = '${criteria.capacityApp}'` : true;
	console.log(`select id, shopName, ownerName, mobileNumber, aadhaarNumber, address, landmark, shopType, capacityApp, openingTimeApp, closingTimeApp, emailVerification, mobileVerification, authVerification from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select id, shopName, ownerName, mobileNumber, aadhaarNumber, address, landmark, shopType, capacityApp, openingTimeApp, closingTimeApp, emailVerification, mobileVerification, authVerification from shops where 1 ${conditions}`, callback);
}


//service/shop.js/updateShop
let getShopById = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and shops.id = ${criteria.id}` : true;
	console.log(`select * from shops where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shops where 1 ${conditions}`, callback);
}

//service/shop.js/createShop
let getShopByEmail = (criteria, callback) => {
    let conditions = "";
	criteria.email ? conditions += ` and shops.email = '${criteria.email}'` : true;
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
	updateShopPassword : updateShopPassword,
	getShopByEmail : getShopByEmail,
	getShopById : getShopById,
	getShopForUser : getShopForUser,
	getShopForAuth : getShopForAuth,
	getShopWithShopSize : getShopWithShopSize
}