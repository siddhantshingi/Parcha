// Define Error Codes
let statusCode = {
	OK: 200,
	FOUR_ZERO_FOUR: 404,
	FOUR_ZERO_THREE: 403,
	FOUR_ZERO_ONE: 401,
	FIVE_ZERO_ZERO: 500
};

// Define Error Messages
let statusMessage = {
	SERVER_BUSY : 'Our Servers are busy. Please try again later.',
	USER_NOT_FOUND : 'user not found',
	DATA_UPDATED: 'Data updated successfully.',
	DELETE_DATA : 'Delete data successfully',

};

module.exports = {
	statusCode: statusCode,
	statusMessage: statusMessage
}