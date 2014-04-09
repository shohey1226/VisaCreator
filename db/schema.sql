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
    othername VARCHAR(50),
    birthday VARCHAR(50),
    birth_place VARCHAR(50),
    gender VARCHAR(6),
    martialstatus VARCHAR(10),
    passport_no VARCHAR(20),
    issue_date VARCHAR(10),
    expiry_date VARCHAR(10),
    issuing_auth VARCHAR(20),
    issue_place VARCHAR(20),
    passport_type VARCHAR(15),
    residential_address VARCHAR(50),
    residential_tel VARCHAR(30),
    residential_mobile VARCHAR(20),
    occupation VARCHAR(30),
    partner_occupation VARCHAR(30),
    nationality VARCHAR(30),
    former_nationality VARCHAR(30),
    identification VARCHAR(30),
    crime VARCHAR(3),
    sentenced VARCHAR(3),
    overstay VARCHAR(3),
    drug VARCHAR(3),
    prostitution VARCHAR(3),
    trafficking VARCHAR(3),
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
      ON DELETE CASCADE,
    PRIMARY KEY (user_id, employer_id)
) ENGINE=INNODB;;


DROP TABLE IF EXISTS supporter;
CREATE TABLE supporter 
(
    id INT AUTO_INCREMENT,   
    name VARCHAR(30),
    tel VARCHAR(30),
    address VARCHAR(50),
    birthday VARCHAR(50),
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
    type VARCHAR(10),
    created_at DATETIME,
    FOREIGN KEY(user_id) REFERENCES user(id)
      ON DELETE CASCADE,
    FOREIGN KEY(supporter_id) REFERENCES supporter(id)
      ON DELETE CASCADE,
    PRIMARY KEY (user_id, supporter_id, type)
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
    tel VARCHAR(30),
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
    PRIMARY KEY(user_id, travel_id, accommodation_id)
) ENGINE=INNODB;;


SET FOREIGN_KEY_CHECKS=1;

