let mysqlConfig = require("../Utilities/mysqlConfig");

let util = require('../Utilities/util'),
tokenDAO = require('../DAO/tokenDAO'),
shopDAO = require('../DAO/shopDAO'),
shopSizeDAO = require('../DAO/shopSizeDAO'),
shopBookingDAO = require('../DAO/shopBookingDAO');

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

	repeatEveryShort(updateStatus, 5*ONE_MINUTE);

	//periodic function
	function addShopTimeSlots() {
		console.log(new Date().toString() + ": performing time slot deletion query!");
		shopBookingDAO.deleteShopTimeSlot((err, data) => {
			if (err) {
				console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
				return;
			}
			console.log({"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": {} });
			return;
		});
		console.log(new Date().toString() + ": performing time slot addition query!");
		let now = new Date()
		let date_str = now.getFullYear() + "-" + ("0" + (now.getMonth() + 1)).slice(-2) + "-" + ("0" + now.getDate()).slice(-2)
		zero = new Date(date_str + " " + "00:00:00" )

		let criteria = {
			"verificationStatus" : "1" 
		}
		shopDAO.getShopWithShopSize(criteria,(err, data) => {
			if (err) {
				console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
				return;
			}
			for (var i = 0; i < data.length; i++) {
				ot = new Date(date_str + " " + data[i].openTime);
				ct = new Date(date_str + " " + data[i].closeTime);
				sd = new Date(date_str + " " + data[i].slotDuration);
				bd = new Date(date_str + " " + data[i].bufferDuration);
				sd_zero = new Date(Math.abs(sd-zero));
				bd_zero = new Date(Math.abs(bd-zero));
				let it = ot;
				for (var j = 0; j >= 0; j++) {
					let it_time = it.getHours() + ":" + ("0" + it.getMinutes()).slice(-2) + ":" + ("0" + it.getSeconds()).slice(-2)
					var diff = new Date(Math.abs(ct - it));
					let dataToSet = {
						"shopId": data[i].id,
						"date": date_str,
						"startTime": it_time,
						"duration": data[i].slotDuration,
						"capacityLeft": data[i].capacity.toString(),
						"tokensVerified": "0",
						"status" :"0"
					}
					if (diff > bd_zero && diff < sd_zero) {
						var partial = new Date(Math.abs(diff-bd_zero));
						dataToSet.duration = partial.toGMTString().slice(17, 25);
					} else if (diff < bd_zero){
						break;
					}
					shopBookingDAO.addShopTimeSlot(dataToSet, (err,data) => {
						
					});
					it.setHours( it.getHours() + Number(sd.getHours()) + Number(bd.getHours()) );
					it.setMinutes( it.getMinutes() + Number(sd.getMinutes()) + Number(bd.getMinutes()) );
					it.setSeconds( it.getSeconds() + Number(sd.getSeconds()) + Number(bd.getSeconds()) );
					if (it > ct) {
						break;
					}
				}
				console.log("")
			}
			return;
		});
	}

	function repeatEveryLarge(func, interval) {
	    var now = new Date(),
	        delay = interval - now % interval;
	    console.log("delay to run large periodic function:",delay);

	    function start() {
	        func();
	        setInterval(func, interval);
	    }
	    setTimeout(start, delay);
	}

	repeatEveryLarge(addShopTimeSlots, ONE_DAY);
}

module.exports = {
	initialize: initialize
}