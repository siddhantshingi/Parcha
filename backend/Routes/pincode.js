let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
pincodeService = require('../Services/pincode');

/**API to get the pincode details... */
router.get('/get-pincode', (req, res) => {
	pincodeService.getPincode(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;