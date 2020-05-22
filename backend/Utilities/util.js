// Define Error Codes
let statusCode = {
	OK: 200,
	TWO_ZERO_ONE: 201,
	FOUR_ZERO_FOUR: 404,
	FOUR_ZERO_THREE: 403,
	FOUR_ZERO_ONE: 401,
	FOUR_ZERO_ZERO: 400,
	FIVE_ZERO_ZERO: 500,
	FOUR_ZERO_NINE: 409,
	FOUR_ONE_TWO: 412,
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
	UNAUTHORIZED : 'You are not authorized',
	CREATED : 'Object created',
	PRECONDITION_FAILED : 'Precondition failed',
	CONFLICT : 'There is some cnflict'
};

// Encryption Function
let crypto = require("crypto"),
fs = require("fs"),
path = require("path");
// let privateKey = fs.readFileSync(path.resolve("private.pem"), "utf8");
let encryptStringWithRsaPrivateKey = function(toSign) {
    var absolutePath = path.resolve("private.pem");
    var privateKey = fs.readFileSync(absolutePath, "utf8");
    var privateKeyWithPassphrase = crypto.createPrivateKey({
    key: privateKey,
    format: 'pem',
    passphrase: "mySecret",
  });
    var signer = crypto.createSign('sha256');
	signer.update(toSign);
	var sign = signer.sign(privateKeyWithPassphrase,'base64');
    var output = toSign +"\n"+sign;
    return output;
};

let createNewHashedPassword = function(cleartext){
	var salt = crypto.randomBytes(16).toString('base64');
	var iterationcount = 10000;
	var key = crypto.pbkdf2Sync(cleartext, salt, iterationcount, 64, 'sha512').toString('base64');
	var password = salt +","+iterationcount+","+key;
	return password;
}

let verifyPassword = function(savedPassword, cleartext){
	var splitPassword = savedPassword.split(',');
	var savedSalt = splitPassword[0];
	var savedIterationCount = parseInt(splitPassword[1]);
	var savedKey = splitPassword[2];
	var enteredKey = crypto.pbkdf2Sync(cleartext, savedSalt, savedIterationCount, 64, 'sha512').toString('base64');
	return (savedKey===enteredKey);
}



module.exports = {
	statusCode: statusCode,
	statusMessage: statusMessage,
	encryptStringWithRsaPrivateKey: encryptStringWithRsaPrivateKey,
	createNewHashedPassword: createNewHashedPassword,
	verifyPassword: verifyPassword
}