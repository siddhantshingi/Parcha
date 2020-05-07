let environment = "dev";

let serverURLs = {
	"dev": {
		"NODE_SERVER": "http://localhost",
		"NODE_SERVER_PORT": "3000",
		"MYSQL_HOST": 'localhost',
		"MYSQL_USER": 'token_system',
		"MYSQL_PASSWORD": 'password',
		'MYSQL_DATABASE': 'token_system_db',
	}
}

let config = {
	"DB_URL_MYSQL": {
		"host": `${serverURLs[environment].MYSQL_HOST}`,
		"user": `${serverURLs[environment].MYSQL_USER}`,
		"password": `${serverURLs[environment].MYSQL_PASSWORD}`,
		"database": `${serverURLs[environment].MYSQL_DATABASE}`
	},
	"NODE_SERVER_PORT": {
		"port": `${serverURLs[environment].NODE_SERVER_PORT}`
	},
	"NODE_SERVER_URL": {
		"url": `${serverURLs[environment].NODE_SERVER}`
	}
};

let sender_email = "email@address"; 
let sender_password = "password"; 

module.exports = {
	config: config,
	sender_email: sender_email,
	sender_password: sender_password
};