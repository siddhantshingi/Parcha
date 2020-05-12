let mysqlConfig = require("../Utilities/mysqlConfig");

let util = require('../Utilities/util'),
tokenDAO = require('../DAO/tokenDAO'),
shopDAO = require('../DAO/shopDAO'),
shopSizeDAO = require('../DAO/shopSizeDAO');

let ONE_MINUTE = 60*1000;
let ONE_DAY = 24*60*60*1000;

let initialize = () => {
	//periodic function
	function updateStatus() {
		console.log(new Date().toString() + ": performing token update query!");
		let now = new Date()
		let time = ("0" + now.getHours()).slice(-2) + ":" + ("0" + now.getMinutes()).slice(-2) + ":" + ("0" + now.getSeconds()).slice(-2);
		let date = now.getFullYear() + "-" + ("0" + (now.getMonth() + 1)).slice(-2) + "-" + ("0" + now.getDate()).slice(-2)

		let criteria = {
			"curr_time" : time,
			"curr_date" : date,
			"status" : "1", //Confirmed
		}
		var dataToSet={
			"status" : "0", //live
		}
		tokenDAO.updateLiveTokens(criteria, dataToSet, (err, data) => {
			if (err) {
				console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
				return;
			}
			// console.log({"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
			return;
		});

		criteria = {
			"curr_time" : time,
			"curr_date" : date,
			"status" : "0", //Live
		}
		dataToSet={
			"status" : "3", //expired
		}
		tokenDAO.updateExpTokens(criteria, dataToSet, (err, data) => {
			if (err) {
				console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
				return;
			}
			// console.log({"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
			return;
		});
	}

	function repeatEveryShort(func, interval) {
	    var now = new Date(),
	        delay = interval - now % interval;
	    console.log("delay to run short periodic function:",delay);

	    function start() {
	        func();
	        setInterval(func, interval);
	    }
	    setTimeout(start, delay);
	}

	repeatEveryShort(updateStatus, 0.5*ONE_MINUTE);

	//periodic function
	// function addShopTimeSlots() {
	// 	console.log(new Date().toString() + ": performing time slot addition query!");
	// 	let now = new Date()
	// 	let date = now.getFullYear() + "-" + ("0" + (now.getMonth() + 1)).slice(-2) + "-" + ("0" + now.getDate()).slice(-2)


	// 	let criteria = {
	// 		"verificationStatus" : "1" 
	// 	}
	// 	shopDAO.getShopWithShopSize(criteria,(err, data) => {
	// 		if (err) {
	// 			console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
	// 			return;
	// 		}
	// 		// console.log(data);
	// 		for (var i = 0; i < data.length; i++) {
	// 			console.log("shopId",data[i].id," shopSize:",data[i].shopSize," openTime:",data[i].openTime," closeTime:",data[i].closeTime," capacity:",data[i].capacity," slotDuration:",data[i].slotDuration," bufferDuration:", data[i].bufferDuration);
	// 			ot = new Date(date + " " + data[i].openTime);
	// 			ct = new Date(date + " " + data[i].closeTime);
	// 			sd = new Date(date + " " + data[i].slotDuration);
	// 			bd = new Date(date + " " + data[i].bufferDuration);
	// 			it = ot;
	// 			for (var j = 0; j >= 0; j++) {
	// 				let it_date = it.getFullYear() + "-" + ("0" + (it.getMonth() + 1)).slice(-2) + "-" + ("0" + it.getDate()).slice(-2)
	// 				let it_time = it.getHours() + ":" + ("0" + it.getMinutes()).slice(-2) + ":" + ("0" + it.getSeconds()).slice(-2)
	// 				console.log("insert start point:",it_date,it_time);
					
	// 				it.setHours( it.getHours() + Number(sd.getHours()) + Number(bd.getHours()) );
	// 				it.setMinutes( it.getMinutes() + Number(sd.getMinutes()) + Number(bd.getMinutes()) );
	// 				it.setSeconds( it.getSeconds() + Number(sd.getSeconds()) + Number(bd.getSeconds()) );
	// 				if (it > ct) {
	// 					break;
	// 				}
	// 			}
	// 			console.log("")
	// 		}
	// 		return;
	// 	});
	// }

	// function repeatEveryLarge(func, interval) {
	//     var now = new Date(),
	//         delay = interval - now % interval;
	//     console.log("delay to run large periodic function:",delay);

	//     function start() {
	//         func();
	//         setInterval(func, interval);
	//     }
	//     setTimeout(start, delay);
	// }

	// repeatEveryLarge(addShopTimeSlots, ONE_DAY/(24*60*2));
}

module.exports = {
	initialize: initialize
}