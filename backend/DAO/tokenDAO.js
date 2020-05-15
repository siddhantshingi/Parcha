let dbConfig = require("../Utilities/mysqlConfig");

let bookToken = (dataToSet, callback) => {
	let setData = "";
	dataToSet.verified ? setData += `verified = ${dataToSet.verified}` : setData += `verified = 0`;
	dataToSet.date ? setData += `, date = '${dataToSet.date}'` : true;
	dataToSet.userId ? setData += `, userId = ${dataToSet.userId}` : true;
	dataToSet.shopId ? setData += `, shopId = ${dataToSet.shopId}` : true;
	dataToSet.startTime ? setData += `, startTime = '${dataToSet.startTime}'` : true;
	dataToSet.duration ? setData += `, duration = '${dataToSet.duration}'` : true;
	dataToSet.status ? setData += `, status = '${dataToSet.status}'` : true;
	console.log(`insert into tokens set ${setData}`);
	dbConfig.getDB().query(`insert into tokens set ${setData}`, callback);
}

let cancelToken = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;
	console.log(`UPDATE tokens SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData} where 1 ${conditions}`, callback);
}

let getToken = (criteria, callback) => {
    let conditions = "";
	criteria.tokenId ? conditions += ` and tokens.id = ${criteria.tokenId}` : true;
	criteria.userId ? conditions += ` and tokens.userId = ${criteria.userId}` : true;
	criteria.date ? conditions += ` and tokens.date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and tokens.shopId = ${criteria.shopId}` : true;
	criteria.startTime ? conditions += ` and tokens.startTime = '${criteria.startTime}'` : true;
	criteria.duration ? conditions += ` and tokens.duration = '${criteria.duration}'` : true;
	criteria.dateLowerLim ? conditions += ` and tokens.date >= '${criteria.dateLowerLim}'` : true;
	criteria.dateUpperLim ? conditions += ` and tokens.date <= '${criteria.dateUpperLim}'` : true;
	criteria.status ? conditions += ` and tokens.status = ${criteria.status}` : true;
	criteria.verified ? conditions += ` and tokens.verified = ${criteria.verified}` : true;
	console.log(`select tokens.*, shops.shopName from tokens left join shops on tokens.shopId = shops.id where 1 ${conditions}`);
	dbConfig.getDB().query(`select tokens.*, shops.name as shopName from tokens left join shops on tokens.shopId = shops.id where 1 ${conditions}`, callback);
}

let updateLiveTokens = (criteria,dataToSet,callback) => {//for periodic functions
    let conditions = "";
	let setData = "";
	criteria.curr_time ? conditions += ` and startTime > CONVERT('${criteria.curr_time}', TIME) - INTERVAL 1 MINUTE and startTime <= CONVERT('${criteria.curr_time}', TIME) + INTERVAL 1 MINUTE` : true;
	criteria.curr_date ? conditions += ` and date = '${criteria.curr_date}'` : true;
	criteria.status ? conditions += ` and status = ${criteria.status}` : true;
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;
	console.log(`UPDATE tokens SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData} where 1 ${conditions}`, callback);
}

let updateExpTokens = (criteria,dataToSet,callback) => {//for periodic functions
    let conditions = "";
	let setData = "";
	criteria.curr_time ? conditions += ` and startTime + duration > CONVERT('${criteria.curr_time}', TIME) - INTERVAL 1 MINUTE and startTime + duration <= CONVERT('${criteria.curr_time}', TIME) + INTERVAL 1 MINUTE` : true;
	criteria.curr_date ? conditions += ` and date = '${criteria.curr_date}'` : true;
	criteria.status ? conditions += ` and status = ${criteria.status}` : true;
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;
	console.log(`UPDATE tokens SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData} where 1 ${conditions}`, callback);
}

let findNextToken = (criteria,callback) => {//find next waitlisted token
	console.log(`SELECT * from (SELECT * from tokens where shopId = (SELECT shopId from tokens where id = ${criteria.id}) and startTime = (SELECT startTime from tokens where id = ${criteria.id}) and duration = (SELECT duration from tokens where id = ${criteria.id}) and date = (SELECT date from tokens where id = ${criteria.id}) and status = 2) as waitlist order by createdAt limit 1`);
	dbConfig.getDB().query(`SELECT * from (SELECT * from tokens where shopId = (SELECT shopId from tokens where id = ${criteria.id}) and startTime = (SELECT startTime from tokens where id = ${criteria.id}) and duration = (SELECT duration from tokens where id = ${criteria.id}) and date = (SELECT date from tokens where id = ${criteria.id}) and status = 2) as waitlist order by createdAt limit 1`, callback);
}

let cancelAndUpdateNextToken = (criteria,dataToSet,callback) => {//cancel the token and confirm waitlisted token
    let conditions1 = "";
	let setData1 = "";
	criteria.id1 ? conditions1 += ` and id = ${criteria.id1}` : true;
	dataToSet.status1 ? setData1 += `status = '${dataToSet.status1}'` : true;
	console.log(`UPDATE tokens SET ${setData1} where 1 ${conditions1}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData1} where 1 ${conditions1}`);
	let conditions2 = "";
	let setData2 = "";
	criteria.id2 ? conditions2 += ` and id = ${criteria.id2}` : true;
	dataToSet.status2 ? setData2 += `status = '${dataToSet.status2}'` : true;
	console.log(`UPDATE tokens SET ${setData2} where 1 ${conditions2}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData2} where 1 ${conditions2}`, callback);
}

let checkLive = (criteria, callback) => {//check if a token is live or not
    let conditions = "";
	criteria.tokenId ? conditions += ` and id = ${criteria.tokenId}` : true;
	criteria.userId ? conditions += ` and userId = ${criteria.userId}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.startTime ? conditions += ` and startTime = '${criteria.startTime}'` : true;
	criteria.duration ? conditions += ` and duration = '${criteria.duration}'` : true;
	conditions += ` and status = 0`;
	console.log(`SELECT * FROM tokens where 1 ${conditions}`);
	dbConfig.getDB().query(`SELECT * FROM tokens where 1 ${conditions}`, callback);
}

let verifyToken = (criteria, callback) => {
    let conditions = "";
	criteria.tokenId ? conditions += ` and id = ${criteria.tokenId}` : true;
	criteria.userId ? conditions += ` and userId = ${criteria.userId}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.startTime ? conditions += ` and startTime = '${criteria.startTime}'` : true;
	criteria.duration ? conditions += ` and duration = '${criteria.duration}'` : true;
	conditions += ` and status = 0`;
	console.log(`UPDATE tokens SET verified = 1 where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET verified = 1 where 1 ${conditions}`, callback);
}

module.exports = {
	bookToken : bookToken,
	cancelToken : cancelToken,
	getToken : getToken,
	updateLiveTokens : updateLiveTokens,
	updateExpTokens : updateExpTokens,
	findNextToken : findNextToken,
	cancelAndUpdateNextToken : cancelAndUpdateNextToken,
	verifyToken : verifyToken,
	checkLive : checkLive
}