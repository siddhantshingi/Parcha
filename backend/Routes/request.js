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

/**API to get pending requests by pincode... */
router.get('/get-pending-requests', (req, res) => {
	requestService.getPendingRequests(req.query, (data) => {
		res.send(data);
	});
});

/**API to get requests by shopId... */
router.get('/get-requests-by-shopId', (req, res) => {
	requestService.getRequestByShopId(req.query, (data) => {
		res.send(data);
	});
});

/**API to get requests by authId... */
router.get('/get-requests-by-authId', (req, res) => {
	requestService.getRequestByAuthId(req.query, (data) => {
		res.send(data);
	});
});


module.exports = router;