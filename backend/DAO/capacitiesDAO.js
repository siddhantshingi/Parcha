let dbConfig = require("../Utilities/mysqlConfig");

let getCapacities = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	console.log(`select * from capacities where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from capacities where 1 ${conditions}`, callback);
}

module.exports = {
	getCapacities : getCapacities
}