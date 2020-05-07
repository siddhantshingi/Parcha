# Token-System Backend
This API server uses REACT framework and is built using nodejs. Data is stored in MYSQL database.

Steps to run the server in developement environment:
1. Login to MYSQL using root user:
	`sudo mysql -u root -p`
Create MYSQL user (username: "token_system", password: "password")
	`create user 'token_system'@'%' IDENTIFIED BY 'password';`
grant all the privileges to the created user
	`GRANT ALL PRIVILEGES ON *.* TO 'token_system'@'%';`
login using token_system user
	`mysql -u token_system -p`
create database with name: token_system_db
 
2. To run the backend server:
	`cd backend 
	nodejs server.js`
it is running perfectly with nodejs version 12.16.1.

3. To send email using this API: change the sender_email and sender_password in /backend/Utilities/config.js.
You will need to allow "access to less secure app" from your sender_email ID.