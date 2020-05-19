let express = require('express'),
router = express.Router(),
util = require('../Utilities/util'),
capacitiesService = require('../Services/capacities');

/**Api to get the list of capacities */
router.get('/get-capacities', (req, res) => {
	capacitiesService.getCapacities(req.query, (data) => {
		res.send(data);
	});
});

module.exports = router;