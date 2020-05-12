let dbConfig = require("../Utilities/mysqlConfig");

let getShopType = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	console.log(`select * from shopTypes where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shopTypes where 1 ${conditions}`, callback);
}

module.exports = {
	getShopType : getShopType
}