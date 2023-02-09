sudo apt install nodejs


sudo apt install npm


npm init -y


npm install express bootstrap express-handlebars mysql dotenv body-parser


npm install --save-dev nodemon

Installing Xampp

chmod 755 xampp-linux-x64-8.2.0-0-installer.run

sudo ./xampp-linux-x64-8.2.0-0-installer.run

Run Xampp

sudo /opt/lampp/manager-linux-x64.run


sudo apt-get install apache2

sudo apt install php

sudo apt-get install mysql-server mysql-client

on 1st tab we will do,

    sudo mysql
    
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '01711813256';
    
on 2nd tab we will do,

sudo mysql_secure_installation

then we will provide rootpassword(01711813256)

then we will provide new password 

then we will give all yes

we can log in mysql by,

mysql -u root -p

create user 'SifatSikder'@'localhost' identified by 'password';

grant all privileges on *.* 'SifatSikder'@'localhost' with grant option;

exit;

Installing php myadmin

sudo apt-get install phpmyadmin

If phpmyadmin shows an error

sudo -H nano /etc/apache2/apache2.conf

Then at the end of the file add

Include /etc/phpmyadmin/apache.conf

Then ctrl+o then enter then ctrl+x

Restart apache

/etc/init.d/apache2 restart


User name: root
 
Password: 01711813256

User name: SifatSikder 

Password: password


give permission

sudo chmod 777 /var/www/html -R



