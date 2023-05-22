#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
psql -p $PGPORT $DB_NAME < $DIR/../src/create_tables.sql
psql -p $PGPORT $DB_NAME < $DIR/../src/create_indexes.sql
psql -p $PGPORT $DB_NAME < $DIR/../src/load_data.sql


DROP TABLE Message;
DROP TABLE Connection;
DROP TABLE USR;


CREATE TABLE USR(
        userId varchar(30) UNIQUE NOT NULL,
        password varchar(30) NOT NULL,
        email text NOT NULL,
        name char(50),
        dateOfBirth date,
        Primary Key(userId));

CREATE TABLE Work_Ex(
        userId char(30) NOT NULL,
        company char(50) NOT NULL,
        role char(50) NOT NULL,
        location char(50),
        startDate date,
        endDate date,
        PRIMARY KEY(userId,company,role,startDate));

CREATE TABLE Edu_det(
        userId char(30) NOT NULL,
        instituitionName char(50) NOT NULL,
        major char(50) NOT NULL,
        degree char(50) NOT NULL,
        startdate date,
        enddate date,
        PRIMARY KEY(userId,major,degree));

CREATE TABLE Message(
        msgId integer UNIQUE NOT NULL,
        senderId char(30) NOT NULL,
        receiverId char(30) NOT NULL,
        contents char(500) NOT NULL,
        sendTime timestamp,
        deleteStatus integer,
        status char(30) NOT NULL,
        PRIMARY KEY(msgId));

CREATE TABLE Connection(
        userId char(30) NOT NULL,
        connectionId char(30) NOT NULL,
        status char(30) NOT NULL,
        PRIMARY KEY(userId,connectionId));



create index.sql
CREATE UNIQUE INDEX usr_index  on USR USING BTREE (userId) ;

CREATE UNIQUE INDEX Work_index on Work_Ex USING BTREE (userId,company,role,startDate);

CREATE UNIQUE INDEX Edu_index on Edu_det USING BTREE (userId,major, degree);

CREATE UNIQUE INDEX Message_index on Message USING BTREE (msgId);

CREATE UNIQUE INDEX Conn_index on Connection USING BTREE (userId,connectionId);

~                                                                                                                                          
~                                                                                                                                          
~                                                                                                                                          
~                                                                                                                                          


COPY USR(
        userId,
        password,
        email,
        name,
        dateOfBirth)
FROM 'USR.csv'
DELIMITER ',' CSV HEADER;

COPY Work_Ex(
        userID,
        company,
        role,
        location,
        startDate,
        endDate
)
FROM 'Work_Ex.csv'
DELIMITER ',' CSV HEADER;

COPY Edu_Det(
        userID,
        instituitionName,
        major,
        degree,
        startDate,
        endDate
)
FROM 'Edu_det.csv'
DELIMITER ',' CSV HEADER;

COPY Message(
        msgId,
        senderId,
        receiverId,
        contents,
        sendTime,
        deleteStatus,
        status)
FROM 'Message.csv'
DELIMITER ',' CSV HEADER;

COPY Connection(
        userId,
        connectionId,
        status)
                                                                                                                         1,1           Top
FROM 'COnnection.csv'
DELIMITER ',' CSV HEADER
~                                                                                       