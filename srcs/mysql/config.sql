FLUSH PRIVILEGES;
SET PASSWORD FOR root@'localhost' = PASSWORD('psw');
FLUSH PRIVILEGES;
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordpress.* TO 'mchardin'@'localhost' IDENTIFIED BY 'psw';
FLUSH PRIVILEGES;