USE SAILORS;
CREATE TABLE SAILORS
(
SID INT,
SNAME VARCHAR(25),
RATING INT,
AGE INT
);
INSERT INTO SAILORS(SID,SNAME,RATING,AGE)VALUES
(22,'DUSTIN',7,45),
(29,'BRUTAS',1,33),
(31,'LUBBER',8,55),
(32,'ANDY',8,25),
(58,'RUSTY',10,35),
(64,'HORATIO',7,35),
(71,'ZORBA',10,16),
(74,'HORATIO',9,35),
(85,'ART',3,26),
(95,'BOB',3,64);
SELECT * FROM SAILORS;
CREATE TABLE BOATS
(
BID INT,
BNAME VARCHAR(25),
COLOR VARCHAR(25)
);
INSERT INTO BOATS(BID,BNAME,COLOR)VALUES
(101,'INTERLAKE','BLUE'),
(102,'INTERLAKE','RED'),
(103,'CLIPPER','GREEN'),
(104,'MARINE','RED');
CREATE TABLE RESERVES
(
SID INT,
BID INT,
DAYS DATE
);
INSERT INTO RESERVES(SID,BID,DAYS)VALUES
(22,101,'1998-10-10'),
(22,102,'1998-10-10'),
(22,103,'1998-08-10'),
(22,104,'1998-07-10'),
(31,102,'1998-10-11'),
(31,103,'1998-06-11'),
(31,104,'1998-12-11'),
(64,101,'1998-05-09'),
(64,102,'1998-08-09'),
(74,103,'1998-08-09');
SELECT * FROM RESERVES;

SELECT SNAME,AGE FROM SAILORS;

SELECT * FROM SAILORS,RESERVES WHERE SAILORS.SID=RESERVES.SID AND BID=101;

SELECT SNAME FROM SAILORS WHERE RATING>7;

SELECT SNAME FROM SAILORS,RESERVES WHERE SAILORS.SID=RESERVES.SID AND BID=103;

SELECT DISTINCT SNAME FROM SAILORS,BOATS,RESERVES WHERE COLOR='RED' AND SAILORS.SID=RESERVES.SID AND BOATS.BID=RESERVES.BID;

SELECT DISTINCT SNAME FROM SAILORS,BOATS,RESERVES 
WHERE (COLOR="RED" OR COLOR="GREEN") AND SAILORS.SID=RESERVES.SID AND BOATS.BID=RESERVES.BID;

SELECT DISTINCT COLOR FROM BOATS,SAILORS,RESERVES
WHERE SNAME="LUBBER" AND SAILORS.SID=RESERVES.SID AND BOATS.BID=RESERVES.BID;

SELECT DISTINCT SNAME FROM SAILORS,BOATS,RESERVES 
WHERE COLOR="RED" AND SAILORS.SID=RESERVES.SID AND BOATS.BID=RESERVES.BID AND EXISTS
(SELECT DISTINCT SNAME FROM SAILORS,BOATS,RESERVES 
WHERE COLOR="GREEN" AND SAILORS.SID=RESERVES.SID AND BOATS.BID=RESERVES.BID);

SELECT DISTINCT SNAME FROM SAILORS,BOATS,RESERVES 
WHERE SAILORS.SID=RESERVES.SID AND BOATS.BID=RESERVES.BID;

SELECT SNAME, RESERVES.SID FROM SAILORS,RESERVES WHERE SAILORS.SID=RESERVES.SID 
GROUP BY DAYS,RESERVES.SID,SNAME HAVING COUNT(DAYS)>1;

SELECT SNAME,AGE FROM SAILORS WHERE AGE =(SELECT MIN(AGE) FROM SAILORS);

SELECT SNAME,RATING FROM SAILORS WHERE RATING > (SELECT MAX(RATING) FROM SAILORS WHERE SNAME="HORATIO");

SELECT SID,SNAME  FROM SAILORS  WHERE NOT EXISTS ( SELECT BID FROM BOATS 
 WHERE NOT EXISTS ( SELECT RESERVES.BID FROM RESERVES  WHERE RESERVES.SID = SAILORS.SID  AND RESERVES.BID=BOATS.BID));
 
SELECT COUNT(DISTINCT SNAME) AS SNAME FROM SAILORS ;

SELECT AVG(AGE) AS AVERAGE_AGE FROM SAILORS;

SELECT RATING , AVG(AGE) AS AVERAGE_AGE FROM SAILORS 
GROUP BY RATING;

SELECT RATING, AVG(AGE) AS AVERAGE_AGE FROM SAILORS
GROUP BY RATING HAVING COUNT(*) > 1;
DROP TABLE RESERVES;