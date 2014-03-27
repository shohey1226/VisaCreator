SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS user;
CREATE TABLE user 
(
    id BIGINT AUTO_INCREMENT, 
    surname VARCHAR(50),
    facebook_id INT,
    created_at DATETIME,
    updated_at DATETIME,
    INDEX (facebook_id),
    PRIMARY KEY (id)
) ENGINE=INNODB;;

SET FOREIGN_KEY_CHECKS=1;

