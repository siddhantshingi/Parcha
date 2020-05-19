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

// /**Api to update shop profile*/
router.put('/update-shop', (req, res) => {
	shopService.updateShop(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to update shop password*/
router.put('/update-shop-password', (req, res) => {
	shopService.updateShopPassword(req.body, (data) => {
		res.send(data);
	});
});

/**Api to verify a shop */
router.get('/verify-shop', (req, res) => {
	shopService.verifyShop(req.query, (data) => {
		res.send(data);
	});
});

/**Api to get the list of shops for user */
router.get('/get-shop-for-user', (req, res) => {
	shopService.getShopForUser(req.query, (data) => {
		res.send(data);
	});
});

/**Api to get the list of shops for user */
router.get('/get-shop-for-auth', (req, res) => {
	shopService.getShopForAuth(req.query, (data) => {
		res.send(data);
	});
});

/**Api to get the list of user */
router.get('/get-public-key', (req, res) => {
	console.log("getpubkey");
	shopService.getPublicKey(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;