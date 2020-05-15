var crypto = require("crypto");
var path = require("path");
var fs = require("fs");
const passphrase = "mySecret"

var encryptStringWithRsaPublicKey = function(toEncrypt, publicKey) {
    // var absolutePath = path.resolve(relativeOrAbsolutePathToPublicKey);
    // var publicKey = fs.readFileSync(absolutePath, "utf8");
    // console.log(publicKey.toString())
    var buffer = new Buffer.from(toEncrypt);
    var encrypted = crypto.publicEncrypt(publicKey, buffer);
    return encrypted.toString("base64");
};
var encryptStringWithRsaPrivateKey = function(toEncrypt, privateKey) {
    // var absolutePath = path.resolve(relativeOrAbsolutePathToPublicKey);
    // var publicKey = fs.readFileSync(absolutePath, "utf8");
    // console.log(privateKey.toString())
    var buffer = new Buffer.from(toEncrypt);
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
    var buffer = new Buffer.from(toDecrypt, "base64");
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
    var buffer = new Buffer.from(toDecrypt, "base64");
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

values = generateKeys(2048);
shopPublicKey = values[0];
shopPrivateKey = values[1];
values = generateKeys(4096);
cusPublicKey = values[0];
cusPrivateKey = values[1];

// let a = encryptStringWithRsaPublicKey("hello", "public.pem", publicKey)
// let b = decryptStringWithRsaPrivateKey(a, "private.pem", privateKey);
var token = "12-14,20/5/2020,akshat,34,dilipstore";
var tokenencryptedSPUB = encryptStringWithRsaPublicKey(token, shopPublicKey);
// console.log("tokenencryptedSPUB is")
// console.log(tokenencryptedSPUB)
var tokenencryptedCPRI_SPUB = encryptStringWithRsaPrivateKey(tokenencryptedSPUB, cusPrivateKey);
console.log("tokenencryptedCPRI_SPUB is");
console.log(tokenencryptedCPRI_SPUB);
console.log("customerPublicKey is");
console.log(cusPublicKey);
console.log("message total size is ")
console.log(tokenencryptedCPRI_SPUB.length+cusPublicKey.length)
console.log(tokenencryptedCPRI_SPUB.length+"+"+cusPublicKey.length)
var tokendecryptedCPUB = decryptStringWithRsaPublicKey(tokenencryptedCPRI_SPUB, cusPublicKey);
console.log("tokendecryptedCPUB is");
console.log(tokendecryptedCPUB);
var tokendecryptedCPUB_SPRI = decryptStringWithRsaPrivateKey(tokendecryptedCPUB, shopPrivateKey);
console.log(tokendecryptedCPUB_SPRI);

values = generateKeys(4096);
shopPublicKey = values[0];
shopPrivateKey = values[1];
values = generateKeys(2048);
cusPublicKey = values[0];
cusPrivateKey = values[1];

var token = "12-14,20/5/2020,akshat,34,dilipstore";
var tokenencryptedCPRI = encryptStringWithRsaPrivateKey(token, cusPrivateKey);

var tokenencryptedSPUB_CPRI = encryptStringWithRsaPublicKey(tokenencryptedCPRI, shopPublicKey);
// console.log("tokenencryptedSPUB is")
// console.log(tokenencryptedSPUB)
console.log("tokenencryptedSPUB_CPRI is");
console.log(tokenencryptedSPUB_CPRI);
console.log("customerPublicKey is");
console.log(cusPublicKey);
console.log("message total size is ")
console.log(tokenencryptedSPUB_CPRI.length+cusPublicKey.length)
console.log(tokenencryptedSPUB_CPRI.length+"+"+cusPublicKey.length)
var tokendecryptedSPRI = decryptStringWithRsaPrivateKey(tokenencryptedSPUB_CPRI, shopPrivateKey);
console.log("tokendecryptedSPRI is");
console.log(tokendecryptedSPRI);
var tokendecryptedSPRI_CPUB = decryptStringWithRsaPublicKey(tokendecryptedSPRI, cusPublicKey);
console.log(tokendecryptedSPRI_CPUB);
// var a = encryptStringWithRsaPrivateKey("hello", privateKey);
// console.log(a);
// console.log(typeof a);
// var b = decryptStringWithRsaPublicKey(a, publicKey);
// console.log(b)
values = generateKeys(4096);
serverPublicKey = values[0];
serverPrivateKey = values[1];
var token = "12-14,20/5/2020,akshat,34,dilipstore";
var tokenencryptedSERPRI = encryptStringWithRsaPrivateKey(token, serverPrivateKey);

// console.log("tokenencryptedSPUB is")
// console.log(tokenencryptedSPUB)
console.log("tokenencryptedSERPRI is");
console.log(tokenencryptedSERPRI);
console.log("message total size is ")
console.log(tokenencryptedSERPRI.length)
var tokendecryptedSERPUB = decryptStringWithRsaPublicKey(tokenencryptedSERPRI, serverPublicKey);
console.log("tokendecryptedSERPUB is");
console.log(tokendecryptedSERPUB);