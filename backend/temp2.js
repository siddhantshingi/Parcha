var crypto = require("crypto");
var path = require("path");
var fs = require("fs");
const passphrase = "mySecret"

var encryptStringWithRsaPublicKey = function(toEncrypt, publicKey) {
    // var absolutePath = path.resolve(relativeOrAbsolutePathToPublicKey);
    // var publicKey = fs.readFileSync(absolutePath, "utf8");
    // console.log(publicKey.toString())
    var buffer = new Buffer(toEncrypt);
    var encrypted = crypto.publicEncrypt(publicKey, buffer);
    return encrypted.toString("base64");
};
var encryptStringWithRsaPrivateKey = function(toEncrypt, privateKey) {
    // var absolutePath = path.resolve(relativeOrAbsolutePathToPublicKey);
    // var publicKey = fs.readFileSync(absolutePath, "utf8");
    // console.log(privateKey.toString())
    var buffer = new Buffer(toEncrypt);
    // var encrypted = crypto.privateEncrypt(privateKey, buffer);
    var encrypted = crypto.privateEncrypt({
            key: privateKey.toString(),
            passphrase: passphrase,
        }, buffer);

    return encrypted.toString("base64");
};

var decryptStringWithRsaPrivateKey = function(toDecrypt, privateKey) {
    // var absolutePath = path.resolve(relativeOrAbsolutePathtoPrivateKey);
    // var privateKey = fs.readFileSync(absolutePath, "utf8");
    var buffer = new Buffer(toDecrypt, "base64");
    //var decrypted = crypto.privateDecrypt(privateKey, buffer);
    const decrypted = crypto.privateDecrypt(
        {
            key: privateKey.toString(),
            passphrase: passphrase,
        },
        buffer,
    )
    return decrypted.toString("utf8");
};
var decryptStringWithRsaPublicKey = function(toDecrypt, publicKey) {
    // var absolutePath = path.resolve(relativeOrAbsolutePathtoPrivateKey);
    // var privateKey = fs.readFileSync(absolutePath, "utf8");
    // console.log(publicKey)
    var buffer = new Buffer(toDecrypt, "base64");
    //var decrypted = crypto.privateDecrypt(privateKey, buffer);
    const decrypted = crypto.publicDecrypt(
        {
            key: publicKey.toString(),
            passphrase: passphrase,
        },
        buffer,
    )
    return decrypted.toString("utf8");
};

const { writeFileSync } = require('fs')
const { generateKeyPairSync } = require('crypto')

function generateKeys(modulusLength) {
    const { publicKey, privateKey } = generateKeyPairSync('rsa', 
    {
            modulusLength: modulusLength,
            generator: 5,
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

    // writeFileSync('private.pem', privateKey)
    // writeFileSync('public.pem', publicKey)
    return [publicKey, privateKey]
}

values = generateKeys(1024);
shopPublicKey = values[0];
shopPrivateKey = values[1];
values = generateKeys(2048);
cusPublicKey = values[0];
cusPrivateKey = values[1];

// let a = encryptStringWithRsaPublicKey("hello", "public.pem", publicKey)
// let b = decryptStringWithRsaPrivateKey(a, "private.pem", privateKey);
var token = "token";
var tokenencryptedSPUB = encryptStringWithRsaPublicKey(token, shopPublicKey);
// console.log("tokenencryptedSPUB is")
// console.log(tokenencryptedSPUB)
var tokenencryptedCPRI_SPUB = encryptStringWithRsaPrivateKey(tokenencryptedSPUB, cusPrivateKey);
console.log("tokenencryptedCPRI_SPUB is");
console.log(tokenencryptedCPRI_SPUB);
console.log("customerPublicKey is")
console.log(cusPublicKey)
var tokendecryptedCPUB = decryptStringWithRsaPublicKey(tokenencryptedCPRI_SPUB, cusPublicKey);
console.log("tokendecryptedCPUB is");
console.log(tokendecryptedCPUB);
console.log("shopKeeperPrivateKey is")
var tokendecryptedCPUB_SPRI = decryptStringWithRsaPrivateKey(tokendecryptedCPUB, shopPrivateKey);
console.log(tokendecryptedCPUB_SPRI);

// var a = encryptStringWithRsaPrivateKey("hello", privateKey);
// console.log(a);
// console.log(typeof a);
// var b = decryptStringWithRsaPublicKey(a, publicKey);
// console.log(b)