/*
    Title: Outlander Init Script
    Authors: 	Chris Beatty
				Brian Gossett
				Larissa Passamani Lima
				Christeen Safar
				Michele Speidel

    Date: 5 July 2022
*/

-- drop test user if exists 
DROP USER IF EXISTS 'outlander_user'@'localhost';


-- create outlander_user and grant them all privileges to the outland_adventure database 
CREATE USER 'outlander_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adventure';

-- grant all privileges to the outland_adventure database to user outlander_user on localhost 
GRANT ALL PRIVILEGES ON outland_adventures.* TO'outlander_user'@'localhost';


-- drop tables if they are present
DROP TABLE IF EXISTS employee_job;
DROP TABLE IF EXISTS employee_inoculation;
DROP TABLE IF EXISTS employee_visa;
DROP TABLE IF EXISTS customer_inoculation;
DROP TABLE IF EXISTS customer_visa;
DROP TABLE IF EXISTS destination_inoculation;
DROP TABLE IF EXISTS destination_visa;
DROP TABLE IF EXISTS employee_order;
DROP TABLE IF EXISTS customer_order;
DROP TABLE IF EXISTS trip_item;
DROP TABLE IF EXISTS trip_excursion;
DROP TABLE IF EXISTS employee_trip;
DROP TABLE IF EXISTS customer_trip;
DROP TABLE IF EXISTS job_responsibility;
DROP TABLE IF EXISTS visa;
DROP TABLE IF EXISTS inoculation;
DROP TABLE IF EXISTS excursion;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS destination;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;


-- create the employee table 
CREATE TABLE employee (
    employee_id     INT         	NOT NULL        AUTO_INCREMENT,
    first_name   	VARCHAR(75)     NOT NULL,
    last_name      	VARCHAR(75)     NOT NULL,
    nick_name     	VARCHAR(75),
    job_title      	VARCHAR(75)     NOT NULL,
    begin_date      DATE     		NOT NULL,
    end_date      	DATE,
    PRIMARY KEY(employee_id)
); 

-- create the job_responsibility table 
CREATE TABLE job_responsibility (
    job_responsibility_id 		INT         	NOT NULL        AUTO_INCREMENT,
    responsibility				VARCHAR(75)     NOT NULL,
    descripton			      	VARCHAR(100)    NOT NULL,
    PRIMARY KEY(job_responsibility_id)
); 

-- create the employee_job table 
CREATE TABLE employee_job (
    employee_job_id             INT         	NOT NULL        AUTO_INCREMENT,
    employee_id                 INT         	NOT NULL,
    job_responsibility_id 		INT         	NOT NULL,
    PRIMARY KEY(employee_job_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(job_responsibility_id)
        REFERENCES job_responsibility(job_responsibility_id)
); 

-- create the inoculationtable 
CREATE TABLE inoculation (
    inoculation_id      	INT         	NOT NULL        AUTO_INCREMENT,
    inoculation_type		VARCHAR(75)     NOT NULL,
    PRIMARY KEY(inoculation_id)
);  

-- create the visa table 
CREATE TABLE visa (
    visa_id 			    INT         	NOT NULL        AUTO_INCREMENT,
    country					VARCHAR(75)     NOT NULL,
    travel_purpose			VARCHAR(75)     NOT NULL,
    travel_requirements		VARCHAR(75)     NOT NULL,
    PRIMARY KEY(visa_id)
); 

-- create the employee_inoculation table 
CREATE TABLE employee_inoculation (
    employee_inoculation_id 	INT         	NOT NULL        AUTO_INCREMENT,
    employee_id                 INT         	NOT NULL,
    inoculation_id      	    INT         	NOT NULL,
    date_administered		    DATE		    NOT NULL,
    date_expires			    DATE,
    PRIMARY KEY(employee_inoculation_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(inoculation_id)
        REFERENCES inoculation(inoculation_id)
); 

-- create the employee_visa table 
CREATE TABLE employee_visa (
    employee_visa_id 			INT         	NOT NULL        AUTO_INCREMENT,
    employee_id                 INT         	NOT NULL,
    visa_id 		    	    INT         	NOT NULL,
    visa_number				    VARCHAR(75)     NOT NULL,
    PRIMARY KEY(employee_visa_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(visa_id)
        REFERENCES visa(visa_id)
); 

-- create the customer table 
CREATE TABLE customer (
    customer_id         INT         	NOT NULL        AUTO_INCREMENT,
    first_name   	    VARCHAR(75)     NOT NULL,
    last_name       	VARCHAR(75)     NOT NULL,
    card_number         INT             NOT NULL,
    emergency_contact   VARCHAR(20)     NOT NULL,
    PRIMARY KEY(customer_id)
); 

-- create the customer_inoculation table 
CREATE TABLE customer_inoculation (
    customer_inoculation_id 	INT         	NOT NULL        AUTO_INCREMENT,
    customer_id                 INT         	NOT NULL,
    inoculation_id      	    INT         	NOT NULL,
    date_administered		    DATE		    NOT NULL,
    date_expires			    DATE,
    PRIMARY KEY(customer_inoculation_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(inoculation_id)
        REFERENCES inoculation(inoculation_id)
); 

-- create the customer_visa table 
CREATE TABLE customer_visa (
    customer_visa_id 			INT         	NOT NULL        AUTO_INCREMENT,
    customer_id                 INT         	NOT NULL,
    visa_id 		    	    INT         	NOT NULL,
    visa_number				    VARCHAR(75)     NOT NULL,
    PRIMARY KEY(customer_visa_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(visa_id)
        REFERENCES visa(visa_id)
); 


-- create the item table 
CREATE TABLE item (
    item_id 		        INT             NOT NULL        AUTO_INCREMENT,
    date_aquired		    DATE            NOT NULL,
    date_expires		    DATE,
    item_type	      	    VARCHAR(75)     NOT NULL,
    last_maintenance		DATE            NOT NULL,
    is_available    		BOOLEAN         NOT NULL,
    PRIMARY KEY(item_id)
); 

-- create the employee_order table 
CREATE TABLE employee_order (
    employee_order_id 		INT             NOT NULL        AUTO_INCREMENT,
    employee_id		        INT             NOT NULL,
    item_id		            INT             NOT NULL,
    out_date                DATE            NOT NULL,
    in_date                 DATE,
    PRIMARY KEY(employee_order_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(item_id)
        REFERENCES item(item_id)
); 

-- create the customer_order table 
CREATE TABLE customer_order (
    customer_order_id 		INT             NOT NULL        AUTO_INCREMENT,
    customer_id		        INT             NOT NULL,
    item_id		            INT             NOT NULL,
    out_date                DATE            NOT NULL,
    in_date                 DATE,
    is_rental               BOOLEAN         NOT NULL,
    PRIMARY KEY(customer_order_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(item_id)
        REFERENCES item(item_id)
);  

-- create the destination table 
CREATE TABLE destination (
    destination_id 		INT             NOT NULL        AUTO_INCREMENT,
    region  		    VARCHAR(50)     NOT NULL,
    airfare_fee		    VARCHAR(50)     NOT NULL,
    PRIMARY KEY(destination_id)
);    

-- create the destination_inoculation table 
CREATE TABLE destination_inoculation (
    destination_inoculation_id 	INT         	NOT NULL        AUTO_INCREMENT,
    destination_id                  INT         	NOT NULL,
    inoculation_id      	        INT         	NOT NULL,
    PRIMARY KEY(destination_inoculation_id),
    FOREIGN KEY(destination_id)
        REFERENCES destination(destination_id),
    FOREIGN KEY(inoculation_id)
        REFERENCES inoculation(inoculation_id)
); 

-- create the destination_visa table 
CREATE TABLE destination_visa (
    destination_visa_id 			INT         	NOT NULL        AUTO_INCREMENT,
    destination_id                  INT         	NOT NULL,
    visa_id 		    	        INT         	NOT NULL,
    PRIMARY KEY(destination_visa_id),
    FOREIGN KEY(destination_id)
        REFERENCES destination(destination_id),
    FOREIGN KEY(visa_id)
        REFERENCES visa(visa_id)
);

-- create the trip table 
CREATE TABLE trip (
    trip_id 		    INT         NOT NULL        AUTO_INCREMENT,
    destination_id 		INT         NOT NULL,
    begin_date          DATE        NOT NULL,
    end_date            DATE        NOT NULL,
    PRIMARY KEY(trip_id),
    FOREIGN KEY(destination_id)
        REFERENCES destination(destination_id)
);  

-- create the excursion table 
CREATE TABLE excursion (
    excursion_id            INT             NOT NULL        AUTO_INCREMENT,
    excursion_description   VARCHAR(100)    NOT NULL,
    PRIMARY KEY(excursion_id)
); 

-- create the trip_excursion table 
CREATE TABLE trip_excursion (
    trip_excursion_id       INT         	NOT NULL        AUTO_INCREMENT,
    trip_id                 INT         	NOT NULL,
    excursion_id            INT         	NOT NULL,
    begin_date_time         DATETIME        NOT NULL,
    end_date_time           DATETIME        NOT NULL,
    PRIMARY KEY(trip_excursion_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id),
    FOREIGN KEY(excursion_id)
        REFERENCES excursion(excursion_id)
); 

-- create the trip_item table 
CREATE TABLE trip_item (
    trip_item_id       INT         	NOT NULL        AUTO_INCREMENT,
    trip_id                 INT         	NOT NULL,
    item_id            INT         	NOT NULL,
    PRIMARY KEY(trip_item_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id),
    FOREIGN KEY(item_id)
        REFERENCES item(item_id)
); 

-- create the employee_trip table 
CREATE TABLE employee_trip (
    employee_trip_id        INT         	NOT NULL        AUTO_INCREMENT,
    employee_id             INT         	NOT NULL,
    trip_id                 INT         	NOT NULL,
    PRIMARY KEY(employee_trip_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id)
);  

-- create the customer_trip table 
CREATE TABLE customer_trip (
    customer_trip_id        INT         	NOT NULL        AUTO_INCREMENT,
    customer_id             INT         	NOT NULL,
    trip_id                 INT         	NOT NULL,
    PRIMARY KEY(customer_trip_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id)
); 


/*

-- insert team records
INSERT INTO team(team_name, mascot)
    VALUES('Team Gandalf', 'White Wizards');

INSERT INTO team(team_name, mascot)
    VALUES('Team Sauron', 'Orcs');


-- insert player records 
INSERT INTO player(first_name, last_name, team_id) 
    VALUES('Thorin', 'Oakenshield', (SELECT team_id FROM team WHERE team_name = 'Team Gandalf'));

INSERT INTO player(first_name, last_name, team_id)
    VALUES('Bilbo', 'Baggins', (SELECT team_id FROM team WHERE team_name = 'Team Gandalf'));

INSERT INTO player(first_name, last_name, team_id)
    VALUES('Frodo', 'Baggins', (SELECT team_id FROM team WHERE team_name = 'Team Gandalf'));

INSERT INTO player(first_name, last_name, team_id) 
    VALUES('Saruman', 'The White', (SELECT team_id FROM team WHERE team_name = 'Team Sauron'));

INSERT INTO player(first_name, last_name, team_id)
    VALUES('Angmar', 'Witch-king', (SELECT team_id FROM team WHERE team_name = 'Team Sauron'));

INSERT INTO player(first_name, last_name, team_id)
    VALUES('Azog', 'The Defiler', (SELECT team_id FROM team WHERE team_name = 'Team Sauron'));
	
	*/