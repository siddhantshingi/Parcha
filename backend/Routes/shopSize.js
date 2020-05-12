let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
shopSizeService = require('../Services/shopSize');

/**Api to get the list of user */
router.get('/get-shop-size', (req, res) => {
	shopSizeService.getShopSize(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;