# Token-System Backend
This API server uses REACT framework and is built using nodejs. Data is stored in MYSQL database.

Steps to run the server in developement environment: _
1. Login to MYSQL using root user:_
	`sudo mysql -u root -p`_
Create MYSQL user (username: "token_system", password: "password")_
	`create user 'token_system'@'%' IDENTIFIED BY 'password';`_
grant all the privileges to the created user_
	`GRANT ALL PRIVILEGES ON *.* TO 'token_system'@'%';`_
login using token_system user_
	`mysql -u token_system -p`_
create database with name: token_system_db_
 
2. To run the backend server:_
	`cd backend _
	nodejs server.js`_
it is running perfectly with nodejs version 12.16.1._

3. To send email using this API: change the sender_email and sender_password in /backend/Utilities/config.js._
You will need to allow "access to less secure app" from your sender_email ID.
