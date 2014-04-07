SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS user;
CREATE TABLE user 
(
    id INT AUTO_INCREMENT, 
    facebook_id INT,
    email VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    othername VARCHAR(50),
    dateOfBirth VARCHAR(50),
    placeOfBirth VARCHAR(50),
    gender VARCHAR(6),
    martialstatus VARCHAR(10),
    passpportNo VARCHAR(20),
    dateOfIssue VARCHAR(10),
    dateOfExpiry VARCHAR(10),
    issuingAuth VARCHAR(20),
    placeOfIssue VARCHAR(20),
    passportType VARCHAR(15),
    residentialAddress VARCHAR(50),
    residentialTel VARCHAR(20),
    residentialMobileNo VARCHAR(20),
    occupation VARCHAR(30),
    partner_occupation VARCHAR(30),
    created_at DATETIME,
    updated_at DATETIME,
    INDEX (facebook_id),
    PRIMARY KEY (id)
) ENGINE=INNODB;;

DROP TABLE IF EXISTS employer;
CREATE TABLE employer 
(
    id INT AUTO_INCREMENT,   
    name VARCHAR(30),
    address VARCHAR(50),
    tel VARCHAR(30),
    PRIMARY KEY (id)
) ENGINE=INNODB;;

DROP TABLE IF EXISTS employer_map;
CREATE TABLE employer_map 
(
    user_id INT,
    employer_id INT,
    created_at DATETIME,
    FOREIGN KEY(user_id) REFERENCES user(id)
      ON DELETE CASCADE,
    FOREIGN KEY(employer_id) REFERENCES employer(id)
      ON DELETE CASCADE
) ENGINE=INNODB;;


DROP TABLE IF EXISTS supporter;
CREATE TABLE supporter 
(
    id INT AUTO_INCREMENT,   
    type VARCHAR(10),
    name VARCHAR(30),
    tel VARCHAR(30),
    address VARCHAR(50),
    dateOfBirth VARCHAR(50),
    gender VARCHAR(6),
    occupation_position VARCHAR(30),
    nationality_immigrant_status VARCHAR(30),
    PRIMARY KEY (id)
) ENGINE=INNODB;;

DROP TABLE IF EXISTS supporter_map;
CREATE TABLE supporter_map 
(
    user_id INT,
    supporter_id INT,
    relation VARCHAR(30),
    created_at DATETIME,
    FOREIGN KEY(user_id) REFERENCES user(id)
      ON DELETE CASCADE,
    FOREIGN KEY(supporter_id) REFERENCES supporter(id)
      ON DELETE CASCADE
) ENGINE=INNODB;;


DROP TABLE IF EXISTS travel;
CREATE TABLE travel 
(
    id INT AUTO_INCREMENT,   
    purpose VARCHAR(30),
    stay_length VARCHAR(10), 
    arrival_date VARCHAR(20),
    departure_date VARCHAR(20),
    port_entry VARCHAR(15),
    airline_ship_name VARCHAR(15),
    remarks VARCHAR(50),
    created_at DATETIME,
    PRIMARY KEY (id)
) ENGINE=INNODB;

DROP TABLE IF EXISTS accommodation;
CREATE TABLE accommodation 
(
    id INT AUTO_INCREMENT,   
    name VARCHAR(50),
    address VARCHAR(50),
    tel VARCHAR(10),
    PRIMARY KEY (id)
) ENGINE=INNODB;;

DROP TABLE IF EXISTS travel_map;
CREATE TABLE travel_map 
(
    user_id INT,
    travel_id INT,
    accommodation_id INT,
    created_at DATETIME,
    FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
      ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES user(id)
      ON DELETE CASCADE,
    FOREIGN KEY(travel_id) REFERENCES travel(id)
      ON DELETE CASCADE,
    PRIMARY KEY(user_id,travel_id)
) ENGINE=INNODB;;


SET FOREIGN_KEY_CHECKS=1;

