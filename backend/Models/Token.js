let mysqlConfig = require("../Utilities/mysqlConfig");
const crypto = require("crypto");
const path = require("path");
const fs = require("fs");
const passphrase = "mySecret";
function generateKeys(modulusLength) {
    const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', 
    {
            modulusLength: modulusLength,
            namedCurve: 'secp256k1', 
            publicKeyEncoding: {
                type: 'spki',
                format: 'pem'     
            },     
            privateKeyEncoding: {
                type: 'pkcs8',
                format: 'pem',
                cipher: 'aes-256-cbc',
                passphrase: passphrase
            } 
    });

    fs.writeFileSync('private.pem', privateKey)
    fs.writeFileSync('public.pem', publicKey)
}
let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS tokens (id INT auto_increment primary key, shopId INT, shopName VARCHAR(255), userId INT, userName VARCHAR(255), userEmail VARCHAR(255), date DATE, slotNumber INT, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, verified INT DEFAULT 0, status INT)");
	console.log("token created if not EXISTS");
	if (!fs.existsSync("public.pem") || !fs.existsSync("private.pem")) {
	    generateKeys(4096);
	    console.log("Server private and public key generated");
	}else{
		console.log("Using already made server public and private generated key")
	};
}

module.exports = {
	initialize: initialize
}
