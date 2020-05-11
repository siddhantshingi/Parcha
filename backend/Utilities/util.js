// Define Error Codes
let statusCode = {
	OK: 200,
	FOUR_ZERO_FOUR: 404,
	FOUR_ZERO_THREE: 403,
	FOUR_ZERO_ONE: 401,
	FOUR_ZERO_ZERO: 400,
	FIVE_ZERO_ZERO: 500
};

// Define Error Messages
let statusMessage = {
	SUCCESS : 'Success',
	SERVER_BUSY : 'Our Servers are busy. Please try again later.',
	BAD_REQUEST : 'Bad request: ',
	USER_NOT_FOUND : 'user not found',
	DATA_UPDATED: 'Data updated successfully.',
	DELETE_DATA : 'Delete data successfully',

};

module.exports = {
	statusCode: statusCode,
	statusMessage: statusMessage
}