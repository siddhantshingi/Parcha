let dbConfig = require("../Utilities/mysqlConfig");

let getShopSize = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	console.log(`select * from shopSizes where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from shopSizes where 1 ${conditions}`, callback);
}

module.exports = {
	getShopSize : getShopSize
}