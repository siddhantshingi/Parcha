let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
shopBookingService = require('../Services/shopBooking');

/**Api to Get time slots details using shop ID */
router.get('/get-time-slots', (req, res) => {
	shopBookingService.getTimeSlotsByShopId(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;