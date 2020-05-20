let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
shopBookingService = require('../Services/shopBooking');

/**Api to Get time slots details using shop ID or date */
router.post('/create-shop-bookings-testing', (req, res) => {
	shopBookingService.runPeriodicFunction(req.query, (data) => {
		res.send(data);
	});
});

/**Api to Get time slots details using shop ID or date */
router.get('/get-shop-bookings', (req, res) => {
	shopBookingService.getShopBookings(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;