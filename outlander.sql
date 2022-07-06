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
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS job_responsibility;
DROP TABLE IF EXISTS innoculation;
DROP TABLE IF EXISTS visa;


-- create the employee table 
CREATE TABLE employee (
    employee_id     INT         	NOT NULL        AUTO_INCREMENT,
    first_name   	VARCHAR(75)     NOT NULL,
    last_name      	VARCHAR(75)     NOT NULL,
    nick_name     	VARCHAR(75)     NOT NULL,
    job_title      	VARCHAR(75)     NOT NULL,
    start_date      DATE     		NOT NULL,
    end_date      	DATE     		NOT NULL,
    PRIMARY KEY(employee_id)
); 

-- create the job_responsibility table 
CREATE TABLE job_responsibility (
    job_responsibility_id 		INT         	NOT NULL        AUTO_INCREMENT,
    responsibility				VARCHAR(75)     NOT NULL,
    descripton			      	VARCHAR(100)    NOT NULL,
    PRIMARY KEY(job_responsibility_id)
); 

-- create the innoculation table 
CREATE TABLE innoculation (
    innoculation_id 		INT         	NOT NULL        AUTO_INCREMENT,
    innoculation_type		VARCHAR(75)     NOT NULL,
    date_administered		DATE		    NOT NULL,
    date_expires			DATE		    NOT NULL,
    PRIMARY KEY(innoculation_id)
); 

-- create the visa table 
CREATE TABLE visa (
    visa_id 				INT         	NOT NULL        AUTO_INCREMENT,
    travel_purpose			VARCHAR(75)     NOT NULL,
    country					VARCHAR(75)     NOT NULL,
    visa_number				VARCHAR(75)     NOT NULL,
    travel_requirements		VARCHAR(75)     NOT NULL,
    PRIMARY KEY(visa_id)
); 


/*

-- create the player table and set the foreign key
CREATE TABLE player (
    player_id   INT             NOT NULL        AUTO_INCREMENT,
    first_name  VARCHAR(75)     NOT NULL,
    last_name   VARCHAR(75)     NOT NULL,
    team_id     INT             NOT NULL,
    PRIMARY KEY(player_id),
    CONSTRAINT fk_team 
    FOREIGN KEY(team_id)
        REFERENCES team(team_id)
);


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