let dbConfig = require("../Utilities/mysqlConfig");

//service/shopBooking.js/getShopBookings
//service/token.js/bookToken
let getShopBookings = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.slotNumber ? conditions += ` and slotNumber = ${criteria.slotNumber}` : true;
	console.log(`select * from shopBookings where 1 ${conditions} ORDER BY date, slotNumber`);
	dbConfig.getDB().query(`select * from shopBookings where 1 ${conditions} ORDER BY date, slotNumber`, callback);
}

let getValidShopBookings = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.slotNumber ? conditions += ` and slotNumber = ${criteria.slotNumber}` : true;
	conditions += ' and date >= curdate() '
	console.log(`select * from shopBookings where 1 ${conditions} ORDER BY date, slotNumber`);
	dbConfig.getDB().query(`select * from shopBookings where 1 ${conditions} ORDER BY date, slotNumber`, callback);
}

//models/Periodic.js/large-periodic function
let addShopTimeSlot = (dataToSet, callback) => {
	let setData = "";
	dataToSet.shopId ? setData += `shopId = ${dataToSet.shopId}` : true;
	dataToSet.date ? setData += `, date = '${dataToSet.date}'` : true;
	dataToSet.slotNumber ? setData += `, slotNumber = ${dataToSet.slotNumber}` : true;
	if (typeof dataToSet.capacityLeft !== 'undefined' && dataToSet.capacityLeft !== null) 
		setData += `, capacityLeft = ${dataToSet.capacityLeft}`;
	if (typeof dataToSet.maxCapacity !== 'undefined' && dataToSet.maxCapacity !== null) 
		setData += `, maxCapacity = ${dataToSet.maxCapacity}`;
	console.log(`insert into shopBookings set ${setData}`);
	dbConfig.getDB().query(`insert into shopBookings set ${setData}`, callback);
}

//model/Periodic.js/large-periodic function
let deleteShopTimeSlot = (criteria, callback) => {
	let conditions = "";
	conditions += ` and date < curdate() - INTERVAL 3 DAY`;
	console.log(`delete from shopBookings where 1 ${conditions}`);
	dbConfig.getDB().query(`delete from shopBookings where 1 ${conditions}`, callback);
}

module.exports = {
	getShopBookings : getShopBookings,
	addShopTimeSlot : addShopTimeSlot,
	deleteShopTimeSlot : deleteShopTimeSlot,
	getValidShopBookings : getValidShopBookings
}