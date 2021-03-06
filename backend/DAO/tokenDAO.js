let dbConfig = require("../Utilities/mysqlConfig");

//service/token.js/bookToken
let bookToken = (dataToSet, callback) => {
	let setData = "";
	dataToSet.shopId ? setData += `shopId = ${dataToSet.shopId}` : true;
	dataToSet.shopName ? setData += `, shopName = '${dataToSet.shopName}'` : true;
	dataToSet.userId ? setData += `, userId = ${dataToSet.userId}` : true;
	dataToSet.userName ? setData += `, userName = '${dataToSet.userName}'` : true;
	dataToSet.userEmail ? setData += `, userEmail = '${dataToSet.userEmail}'` : true;
	dataToSet.date ? setData += `, date = '${dataToSet.date}'` : true;
	dataToSet.slotNumber ? setData += `, slotNumber = ${dataToSet.slotNumber}` : true;
	dataToSet.status ? setData += `, status = ${dataToSet.status}` : true;
	console.log(`insert into tokens set ${setData}`);
	dbConfig.getDB().query(`insert into tokens set ${setData}`, callback);
}

//service/token.js/bookToken
//service/token.js/getToken
let getToken = (criteria, callback) => {
    let conditions = "";
	criteria.userId ? conditions += ` and tokens.userId = ${criteria.userId}` : true;
	criteria.date ? conditions += ` and tokens.date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and tokens.shopId = ${criteria.shopId}` : true;
	criteria.slotNumber ? conditions += ` and tokens.slotNumber = '${criteria.slotNumber}'` : true;
	console.log(`select id, shopId, shopName, date, slotNumber, createdAt, verified, status from tokens where 1 ${conditions} ORDER BY createdAt DESC`);
	dbConfig.getDB().query(`select id, shopId, shopName, date, slotNumber, createdAt, verified, status from tokens where 1 ${conditions} ORDER BY createdAt DESC`, callback);
}

//service/token.js/bookToken
let getNotCancelledToken = (criteria, callback) => {
    let conditions = "";
	criteria.userId ? conditions += ` and tokens.userId = ${criteria.userId}` : true;
	criteria.date ? conditions += ` and tokens.date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and tokens.shopId = ${criteria.shopId}` : true;
	criteria.slotNumber ? conditions += ` and tokens.slotNumber = '${criteria.slotNumber}'` : true;
	conditions += 'and status != 0'
	console.log(`select id, shopId, shopName, date, slotNumber, createdAt, verified, status from tokens where 1 ${conditions}`);
	dbConfig.getDB().query(`select id, shopId, shopName, date, slotNumber, createdAt, verified, status from tokens where 1 ${conditions}`, callback);
}

//service/token.js/getEncryptedToken
let getEncryptedToken = (criteria, callback) => {
    let conditions = "";
	criteria.id ? conditions += ` and tokens.id = ${criteria.id}` : true;
	criteria.userId ? conditions += ` and tokens.userId = ${criteria.userId}` : true;
	criteria.shopId ? conditions += ` and tokens.shopId = ${criteria.shopId}` : true;
	criteria.date ? conditions += ` and tokens.date = '${criteria.date}'` : true;
	criteria.slotNumber ? conditions += ` and tokens.slotNumber = ${criteria.slotNumber}` : true;
	console.log(`select * from tokens where 1 ${conditions}`);
	dbConfig.getDB().query(`select * from tokens where 1 ${conditions}`, callback);
}

//service/token.js/cancelToken
let findNextToken = (criteria,callback) => {//find next waitlisted token
	// console.log(`SELECT * from (SELECT * from tokens where shopId = (SELECT shopId from tokens where id = ${criteria.id}) and startTime = (SELECT startTime from tokens where id = ${criteria.id}) and duration = (SELECT duration from tokens where id = ${criteria.id}) and date = (SELECT date from tokens where id = ${criteria.id}) and status = 2) as waitlist order by createdAt limit 1`);
	// dbConfig.getDB().query(`SELECT * from (SELECT * from tokens where shopId = (SELECT shopId from tokens where id = ${criteria.id}) and startTime = (SELECT startTime from tokens where id = ${criteria.id}) and duration = (SELECT duration from tokens where id = ${criteria.id}) and date = (SELECT date from tokens where id = ${criteria.id}) and status = 2) as waitlist order by createdAt limit 1`, callback);
	console.log(`SELECT * FROM tokens WHERE (shopId, date, slotNumber) IN (SELECT shopId, date, slotNumber from tokens where id = ${criteria.id} ) and status = '2' ORDER BY createdAt LIMIT 1`);
	dbConfig.getDB().query(`SELECT * FROM tokens WHERE (shopId, date, slotNumber) IN (SELECT shopId, date, slotNumber from tokens where id = ${criteria.id} ) and status = '2' ORDER BY createdAt LIMIT 1`, callback);
}

//service/token.js/cancelToken
let cancelToken = (criteria,dataToSet,callback) => {
    let conditions = "";
	let setData = "";
	criteria.id ? conditions += ` and id = ${criteria.id}` : true;
	dataToSet.status ? setData += `status = '${dataToSet.status}'` : true;
	console.log(`UPDATE tokens SET ${setData} where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET ${setData} where 1 ${conditions}`, callback);
}

//service/token.js/cancelToken
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

//service/token.js/verifyToken
let checkLive = (criteria, callback) => {//check if a token is live or not
    let conditions = "";
	criteria.userEmail ? conditions += ` and userEmail = ${criteria.userEmail}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.slotNumber ? conditions += ` and slotNumber = '${criteria.slotNumber}'` : true;
	conditions += ` and status = 1`;
	console.log(`SELECT * FROM tokens where 1 ${conditions}`);
	dbConfig.getDB().query(`SELECT * FROM tokens where 1 ${conditions}`, callback);
}

//service/token.js/verifyToken
let verifyToken = (criteria, callback) => {
    let conditions = "";
	criteria.userEmail ? conditions += ` and userEmail = ${criteria.userEmail}` : true;
	criteria.date ? conditions += ` and date = '${criteria.date}'` : true;
	criteria.shopId ? conditions += ` and shopId = ${criteria.shopId}` : true;
	criteria.slotNumber ? conditions += ` and slotNumber = '${criteria.slotNumber}'` : true;
	conditions += ` and status = 1`;
	console.log(`UPDATE tokens SET verified = 1 where 1 ${conditions}`);
	dbConfig.getDB().query(`UPDATE tokens SET verified = 1 where 1 ${conditions}`, callback);
}

module.exports = {
	bookToken : bookToken,
	cancelToken : cancelToken,
	getToken : getToken,
	findNextToken : findNextToken,
	cancelAndUpdateNextToken : cancelAndUpdateNextToken,
	verifyToken : verifyToken,
	checkLive : checkLive,
	getEncryptedToken : getEncryptedToken,
	getNotCancelledToken : getNotCancelledToken
}