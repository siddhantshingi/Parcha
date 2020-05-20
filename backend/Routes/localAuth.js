let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
localAuthService = require('../Services/localAuth');

/**Api to create local authority*/
router.post('/create-localAuth', (req, res) => {
	localAuthService.createLocalAuth(req.body, (data) => {
		res.send(data);
	});
});

/**Api to verify local authority */
router.get('/verify-localAuth', (req, res) => {
	localAuthService.verifyLocalAuth(req.query, (data) => {
		res.send(data);
	});
});

// /**Api to update local authority */
router.put('/update-localAuth', (req, res) => {
	localAuthService.updateLocalAuth(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to update local authority password */
router.put('/update-localAuth-password', (req, res) => {
	localAuthService.updateLocalAuthPassword(req.body, (data) => {
		res.send(data);
	});
});

// /**API to get the user by email... */
router.get('/get-localAuth', (req, res) => {
	localAuthService.getLocalAuth(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;