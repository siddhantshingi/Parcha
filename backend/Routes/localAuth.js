let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
localAuthService = require('../Services/localAuth');

/**Api to create user */
router.post('/create-localAuth', (req, res) => {
	localAuthService.createLocalAuth(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to update user */
router.put('/update-localAuth', (req, res) => {
	localAuthService.updateLocalAuth(req.body, (data) => {
		res.send(data);
	});
});

// /**API to get the user by email... */
router.get('/get-localAuth-by-email', (req, res) => {
	localAuthService.getLocalAuthByEmail(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;