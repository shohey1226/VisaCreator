SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS user;
CREATE TABLE user 
(
    id INT AUTO_INCREMENT, 
    facebook_id BIGINT,
    twitter_id BIGINT,
    google_id VARCHAR(30),
    email VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthday VARCHAR(50),
    gender VARCHAR(6),
    created_at DATETIME,
    INDEX (facebook_id),
    PRIMARY KEY (id)
) ENGINE=INNODB;;

SET FOREIGN_KEY_CHECKS=1;

