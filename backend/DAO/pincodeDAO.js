let dbConfig = require("../Utilities/mysqlConfig");

let getPincode = (criteria, callback) => {
    let conditions = "";
	criteria.pincode ? conditions += ` and pincode = '${criteria.pincode}'` : true;
	console.log(`select * from pincode where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from pincode where 1 ${conditions}`, callback);
}

module.exports = {
    getPincode : getPincode
}