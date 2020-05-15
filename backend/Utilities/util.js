// Define Error Codes
let statusCode = {
	OK: 200,
	FOUR_ZERO_FOUR: 404,
	FOUR_ZERO_THREE: 403,
	FOUR_ZERO_ONE: 401,
	FOUR_ZERO_ZERO: 400,
	FIVE_ZERO_ZERO: 500,
	FOUR_ZERO_NINE: 409,
};

// Define Error Messages
let statusMessage = {
	SUCCESS : 'Success',
	SERVER_BUSY : 'Our Servers are busy. Please try again later.',
	BAD_REQUEST : 'Bad request: ',
	NOT_FOUND : 'not found',
	DATA_UPDATED: 'Data updated successfully.',
	DELETE_DATA : 'Delete data successfully',
	PARAMS_MISSING : 'Parameter missing',
	DUPLICATE_ENTRY : 'Duplicate entry',
	UNAUTHORIZED : 'You are not authorized'
};

// Encryption Function
let crypto = require("crypto"),
fs = require("fs"),
path = require("path");
let privateKey = fs.readFileSync(path.resolve("private.pem"), "utf8");
let encryptStringWithRsaPrivateKey = function(toEncrypt) {
    // var absolutePath = path.resolve("private.pem");
    // var privateKey = fs.readFileSync(absolutePath, "utf8");
    // console.log(privateKey.toString())
    var buffer = new Buffer.from(toEncrypt);
    // var encrypted = crypto.privateEncrypt(privateKey, buffer);
    var encrypted = crypto.privateEncrypt({
            key: privateKey.toString(),
            passphrase: "mySecret",
        }, buffer);

    return encrypted.toString("base64");
};

module.exports = {
	statusCode: statusCode,
	statusMessage: statusMessage,
	encryptStringWithRsaPrivateKey: encryptStringWithRsaPrivateKey
}