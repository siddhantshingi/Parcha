let mysqlConfig = require("../Utilities/mysqlConfig");
const crypto = require("crypto");
const path = require("path");
const fs = require("fs");
const { writeFileSync } = require('fs')
const { generateKeyPairSync } = require('crypto')
const passphrase = "mySecret";
function generateKeys(modulusLength) {
    const { publicKey, privateKey } = generateKeyPairSync('rsa', 
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

    writeFileSync('private.pem', privateKey)
    writeFileSync('public.pem', publicKey)
}
let initialize = () => {
	mysqlConfig.getDB().query("create table IF NOT EXISTS tokens (id INT auto_increment primary key, verified INT, date DATE, userId INT, shopId INT, startTime TIME, duration TIME, status INT, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
	console.log("table created if not EXISTS");
	if (!fs.existsSync("public.pem") || !fs.existsSync("private.pem")) {
	    generateKeys(4096);
	    console.log("Server private and public key generated");
	}else{
		console.log("Using already made server public and private genrated key")
	};
}

module.exports = {
	initialize: initialize
}
