let dbConfig = require("../Utilities/mysqlConfig");

let getTimeSlotDetailUsingShopId = (criteria, callback) => {
    let conditions = "";
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId} and date = curdate()` : true;
	console.log(`select * from shopBooking where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shopBooking where 1 ${conditions}`, callback);
}

module.exports = {
	getTimeSlotDetailUsingShopId : getTimeSlotDetailUsingShopId
}