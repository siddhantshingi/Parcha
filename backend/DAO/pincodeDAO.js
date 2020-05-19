let dbConfig = require("../Utilities/mysqlConfig");

//service/shop.js/createShop
//service/shop.js/updateShop
//service/user.js/createUser
//service/user.js/updateUser
let getPincode = (criteria, callback) => {
    let conditions = "";
	criteria.pincode ? conditions += ` and pincode = '${criteria.pincode}'` : true;
	console.log(`select * from pincode where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from pincode where 1 ${conditions}`, callback);
}

module.exports = {
    getPincode : getPincode
}