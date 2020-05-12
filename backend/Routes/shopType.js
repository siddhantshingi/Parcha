let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
shopTypeService = require('../Services/shopType');

/**Api to get the list of shop Type */
router.get('/get-shop-type', (req, res) => {
	shopTypeService.getShopType(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;