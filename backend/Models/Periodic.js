let mysqlConfig = require("../Utilities/mysqlConfig");

let util = require('../Utilities/util'),
tokenDAO = require('../DAO/tokenDAO');

let ONE_MINUTE = 60*1000;

let initialize = () => {
	//periodic function
	function updateStatus() {
		console.log(new Date().toString() + ": performing token update query!");
		let now = new Date()
		let time = ("0" + now.getHours()).slice(-2) + ":" + ("0" + now.getMinutes()).slice(-2) + ":" + ("0" + now.getSeconds()).slice(-2);
		let date = now.getFullYear() + "-" + ("0" + (now.getMonth() + 1)).slice(-2) + "-" + ("0" + now.getDate()).slice(-2)
		console.log("Date: ",date," Time: ",time);

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
			console.log({"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
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
			console.log({"statusCode": util.statusCode.OK,"statusMessage": util.statusMessage.SUCCESS, "result": data });
			return;
		});
	}

	function repeatEvery(func, interval) {
	    var now = new Date(),
	        delay = interval - now % interval;
	    console.log("delay to run periodic function:",delay);

	    function start() {
	        func();
	        setInterval(func, interval);
	    }
	    setTimeout(start, delay);
	}

	repeatEvery(updateStatus, 0.5*ONE_MINUTE);
}

module.exports = {
	initialize: initialize
}