let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
tokenService = require('../Services/token');

/**Api to book a token */
router.post('/book-token', (req, res) => {
	tokenService.bookToken(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to cancel a token */
router.put('/cancel-token', (req, res) => {
	tokenService.cancelToken(req.body, (data) => {
		res.send(data);
	});
});

/**Api to get token details given criteria */
router.get('/get-token', (req, res) => {
	tokenService.getToken(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;