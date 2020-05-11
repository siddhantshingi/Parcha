let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
shopService = require('../Services/shop');

/**Api to create shop */
router.post('/create-shop', (req, res) => {
	shopService.createShop(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to update shop */
router.put('/update-shop', (req, res) => {
	shopService.updateShop(req.body, (data) => {
		res.send(data);
	});
});

/**Api to get the list of user */
router.get('/get-shop-list-by-name', (req, res) => {
	shopService.getShopListByName(req.query, (data) => {
		res.send(data);
	});
});

// /**API to get the user by id... */
router.get('/get-shop-list-by-category', (req, res) => {
	shopService.getShopListByCategory(req.query, (data) => {
		res.send(data);
	});
});

// /**API to get the user by email... */
router.get('/get-shop-by-email', (req, res) => {
	shopService.getShopByEmail(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;