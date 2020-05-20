let mysqlConfig = require("../Utilities/mysqlConfig");

let util = require('../Utilities/util'),
tokenDAO = require('../DAO/tokenDAO'),
shopDAO = require('../DAO/shopDAO'),
shopBookingDAO = require('../DAO/shopBookingDAO');

let ONE_MINUTE = 60*1000;
let ONE_DAY = 24*60*60*1000;
let SLOT_DURATION = 30;//in minutes 
let START_TIME = "06:00:00";
let CLOSE_TIME = "21:30:00";//enter actual close time - 1*slot duration 
var timeSlotNumberMap = {};

let initialize = () => {
	function fill_timeSlotNumberMap() {
		let start = new Date("2001-01-01 " + START_TIME);
		let close = new Date("2001-01-01 " + CLOSE_TIME);
		let intermediate = start;
		for (var i = 1; i > 0; i++) {
			timeSlotNumberMap[("0" + intermediate.getHours()).slice(-2) + ":" + ("0" + intermediate.getMinutes()).slice(-2) + ":" + ("0" + intermediate.getSeconds()).slice(-2)] = i;
			intermediate.setMinutes( intermediate.getMinutes() + 30);
			if (intermediate > close) 
				break;
		}
		console.log("Time slot list:",timeSlotNumberMap);
	}	

	function ceilTime(time) {
    	var timeToReturn = new Date(time);
    	timeToReturn.setMilliseconds(Math.ceil(timeToReturn.getMilliseconds() / 1000) * 1000);
    	timeToReturn.setSeconds(Math.ceil(timeToReturn.getSeconds() / 60) * 60);
    	timeToReturn.setMinutes(Math.ceil(timeToReturn.getMinutes() / 30) * 30);
    	return ("0" + timeToReturn.getHours()).slice(-2) + ":" + ("0" + timeToReturn.getMinutes()).slice(-2) + ":" + ("0" + timeToReturn.getSeconds()).slice(-2);
	}

	function floorTime(time) {
    	var timeToReturn = new Date(time);
    	timeToReturn.setMilliseconds(Math.floor(timeToReturn.getMilliseconds() / 1000) * 1000);
    	timeToReturn.setSeconds(Math.floor(timeToReturn.getSeconds() / 60) * 60);
    	timeToReturn.setMinutes(Math.floor(timeToReturn.getMinutes() / 30) * 30);
    	return ("0" + timeToReturn.getHours()).slice(-2) + ":" + ("0" + timeToReturn.getMinutes()).slice(-2) + ":" + ("0" + timeToReturn.getSeconds()).slice(-2);
	}

	function getSlotNumber(time) {
		let start = new Date("2001-01-01 " + START_TIME);
		let close = new Date("2001-01-01 " + CLOSE_TIME);
		let current = new Date("2001-01-01 " + time);
		if (current < start){
			return timeSlotNumberMap[START_TIME];
		} else if (current > close) {
			return timeSlotNumberMap[CLOSE_TIME];
		} else {
			return timeSlotNumberMap[time];
		}
	}

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
		let criteria = {
			"authVerification" : "1" 
		}
		shopDAO.getShopWithPrevBookings(criteria, (err,data) => {
			if (err) {
				console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
				return;
			}
			if (data.length === 0) { 
				console.log("no shops with previous bookings");
			} else {
				console.log("shops with previous bookings exists");
				
				let date_to_add = new Date();
				date_to_add.setDate(date_to_add.getDate() + 2);
				let date_str = date_to_add.getFullYear() + "-" + ("0" + (date_to_add.getMonth() + 1)).slice(-2) + "-" + ("0" + date_to_add.getDate()).slice(-2);

				for (var i = 0; i < data.length; i++) {
					let starting_slot_number = getSlotNumber(ceilTime(date_str + " " + data[i].openingTimeApp));
					let closing_slot_number = getSlotNumber(floorTime(date_str + " " + data[i].closingTimeApp));
					console.log("date:",date_str,"shopId:",data[i].id,"starting slotNumber:", starting_slot_number,"closing slotNumber:",closing_slot_number);
					for (var j = starting_slot_number; j<closing_slot_number; j++) {
						let dataToSet = {
							"shopId": data[i].id,
							"date": date_str,
							"slotNumber": j,
							"capacityLeft": data[i].capacityApp.toString(),
							"maxCapacity": data[i].capacityApp.toString()
						}
						shopBookingDAO.addShopTimeSlot(dataToSet, (err,data) => {});
					}
					console.log("")
				}
			}
			
		});

		shopDAO.getShopWithoutBookings(criteria, (err,data) => {
			if (err) {
				console.log({"statusCode": util.statusCode.FOUR_ZERO_ZERO,"statusMessage": util.statusMessage.BAD_REQUEST + err, "result": {} });
				return;
			}
			if (data.length === 0) { 
				console.log("no shops without bookings");
			} else {
				console.log("shops without bookings exists");
				for (var k=0; k <= 2; k++) {
					let date_to_add = new Date();
					date_to_add.setDate(date_to_add.getDate() + k);
					let date_str = date_to_add.getFullYear() + "-" + ("0" + (date_to_add.getMonth() + 1)).slice(-2) + "-" + ("0" + date_to_add.getDate()).slice(-2);
					for (var i = 0; i < data.length; i++) {
						let starting_slot_number = getSlotNumber(ceilTime(date_str + " " + data[i].openingTimeApp));
						let closing_slot_number = getSlotNumber(floorTime(date_str + " " + data[i].closingTimeApp));
						console.log("date:",date_str,"shopId:",data[i].id,"starting slotNumber:", starting_slot_number,"closing slotNumber:",closing_slot_number);
						for (var j = starting_slot_number; j<closing_slot_number; j++) {
							let dataToSet = {
								"shopId": data[i].id,
								"date": date_str,
								"slotNumber": j,
								"capacityLeft": data[i].capacityApp.toString(),
								"maxCapacity": data[i].capacityApp.toString()
							}
							shopBookingDAO.addShopTimeSlot(dataToSet, (err,data) => {});
						}
						console.log("")
					}
				}
			}
			
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

	fill_timeSlotNumberMap();
	repeatEveryLarge(addShopTimeSlots, ONE_DAY);
}

module.exports = {
	initialize: initialize
}
