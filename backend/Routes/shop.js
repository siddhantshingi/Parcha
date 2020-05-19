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
router.get('/get-shop', (req, res) => {
	shopService.getShop(req.query, (data) => {
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