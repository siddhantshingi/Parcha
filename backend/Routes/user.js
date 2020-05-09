let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
userService = require('../Services/user');

/**Api to send email */
router.post('/send_email', (req, res) => {
	userService.sendEmail(req.body, (data) => {
		res.send(data);
	});
});

/**Api to create user */
router.post('/create-user', (req, res) => {
	userService.createUser(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to update user */
router.put('/update-user', (req, res) => {
	userService.updateUser(req.body, (data) => {
		res.send(data);
	});
});

// /**Api to delete the user */
router.delete('/delete-user', (req, res) => {
	userService.deleteUser(req.query, (data) => {
		res.send(data);
	});
});

/**Api to get the list of user */
router.get('/get-user', (req, res) => {
	userService.getUser(req.query, (data) => {
		res.send(data);
	});
});

// /**API to get the user by id... */
router.get('/get-user-by-id', (req, res) => {
	userService.getUserById(req.query, (data) => {
		res.send(data);
	});
});

// /**API to get the user by email... */
router.get('/get-user-by-email', (req, res) => {
	userService.getUserByEmail(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;