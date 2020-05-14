let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
requestService = require('../Services/request');

/**Api to create request */
router.post('/create-request', (req, res) => {
	requestService.createRequest(req.body, (data) => {
		res.send(data);
	});
});

/**Api to resolve request */
router.put('/resolve-request', (req, res) => {
	requestService.resolveRequest(req.body, (data) => {
		res.send(data);
	});
});

/**API to get the request by pincode... */
router.get('/get-request-list-by-pincode', (req, res) => {
	requestService.getRequestByPincode(req.query, (data) => {
		res.send(data);
	});
});

/**API to get the request by shopId... */
router.get('/get-request-list', (req, res) => {
	requestService.getRequestList(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;