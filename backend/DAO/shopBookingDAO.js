let dbConfig = require("../Utilities/mysqlConfig");

let getTimeSlotDetailUsingShopId = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId} and date = curdate()` : true;
	console.log(`select * from shopBookings where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shopBookings where 1 ${conditions}`, callback);
}

let addShopTimeSlot = (dataToSet, callback) => {
	let setData = "";
	dataToSet.shopId ? setData += `shopId = ${dataToSet.shopId}` : true;
	dataToSet.date ? setData += `, date = '${dataToSet.date}'` : true;
	dataToSet.startTime ? setData += `, startTime = '${dataToSet.startTime}'` : true;
	dataToSet.duration ? setData += `, duration = '${dataToSet.duration}'` : true;
	if (typeof dataToSet.capacityLeft !== 'undefined' && dataToSet.capacityLeft !== null) 
		setData += `, capacityLeft = ${dataToSet.capacityLeft}`;
	if (typeof dataToSet.tokensVerified !== 'undefined' && dataToSet.tokensVerified !== null) 
		setData += `, tokensVerified = ${dataToSet.tokensVerified}`;
	if (typeof dataToSet.status !== 'undefined' && dataToSet.status !== null) 
		setData += `, status = ${dataToSet.status}`;
	// console.log(`insert into shopBookings set ${setData}`);
	dbConfig.getDB().query(`insert into shopBookings set ${setData}`, callback);
}

let deleteShopTimeSlot = (criteria, callback) => {
	let conditions = "";
	conditions += ` and date < curdate() - INTERVAL 3 DAY`;
	console.log(`delete from shopBookings where 1 ${conditions}`);
	dbConfig.getDB().query(`delete from shopBookings where 1 ${conditions}`, callback);
}

module.exports = {
	getTimeSlotDetailUsingShopId : getTimeSlotDetailUsingShopId,
	addShopTimeSlot : addShopTimeSlot,
	deleteShopTimeSlot : deleteShopTimeSlot
}