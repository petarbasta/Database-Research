-- Entities
DROP TABLE Account CASCADE;
DROP TABLE Payment;
DROP TABLE Region CASCADE;
DROP TABLE Tag CASCADE; 
DROP TABLE Media CASCADE;

-- Weak Entities
DROP TABLE AccountUser CASCADE;
DROP TABLE Season CASCADE;
DROP TABLE Episode;
DROP TABLE Rating;

-- Relationships
DROP TABLE available_in;
DROP TABLE queues;
DROP TABLE describes;

CREATE TABLE Account (
	accid SERIAL
);	

CREATE TABLE Payment (
	pid SERIAL,
	date DATE NOT NULL,
	amount FLOAT NOT NULL,
	accid INTEGER NOT NULL,
	FOREIGN KEY(accid) REFERENCES Account(accid) 
);

CREATE TABLE Region (
	regName VARCHAR(30) NOT NULL,
	PRIMARY KEY (regName)
);

CREATE TABLE Tag (
	tid SERIAL,
	tagName VARCHAR(30) NOT NULL
);

CREATE TABLE Media (
	mid SERIAL,
	title VARCHAR(30) NOT NULL,
	releaseYear INTEGER,
	isComplete BOOLEAN
);

CREATE TABLE AccountUser (
	userName VARCHAR(30) NOT NULL,
	accid INTEGER NOT NULL,
	regName VARCHAR(30) NOT NULL,
	PRIMARY KEY (userName, accid),
	FOREIGN KEY (accid) REFERENCES Account(accid),
	FOREIGN KEY (regName) REFERENCES Region(regName)
);

CREATE TABLE Season ( 
	seasonNum INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	PRIMARY KEY (seasonNum, mid),
	FOREIGN KEY (mid) REFERENCES Media(mid)
); 

CREATE TABLE Episode (
	epNum INTEGER NOT NULL,
	seasonNum INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	epTitle VARCHAR(30) NOT NULL,
	PRIMARY KEY (epNum, seasonNum, mid),
	FOREIGN KEY (seasonNum, mid) REFERENCES Season(seasonNum, mid)
);

CREATE TABLE Rating ( 
	mid INTEGER NOT NULL,
	userName VARCHAR(30) NOT NULL,
	accid INTEGER NOT NULL,
	value INTEGER NOT NULL,
	PRIMARY KEY (mid, userName, accid),
	FOREIGN KEY (mid) REFERENCES Media(mid),
	FOREIGN KEY (userName, accid) REFERENCES AccountUser(userName, accid)
);

CREATE TABLE available_in (
	mid INTEGER NOT NULL,
	regName VARCHAR(30) NOT NULL,
	PRIMARY KEY (mid, regName),
	FOREIGN KEY (mid) REFERENCES Media(mid),
	FOREIGN KEY (regName) REFERENCES Region(regName)
);

CREATE TABLE queues (
	userName VARCHAR(30) NOT NULL,
	accid INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	PRIMARY KEY (userName, accid, mid),
	FOREIGN KEY (accid) REFERENCES Account(accid),
	FOREIGN KEY (mid) REFERENCES Media(mid)
);

CREATE TABLE describes ( 
	mid INTEGER NOT NULL,
	tid INTEGER NOT NULL,
	PRIMARY KEY (mid, tid),
	FOREIGN KEY (mid) REFERENCES Media(mid),
	FOREIGN KEY (tid) REFERENCES Tag(tid)
);

GRANT ALL ON Account TO basta;
GRANT ALL ON AccountUser TO basta;
GRANT ALL ON Payment TO basta;
GRANT ALL ON Region TO basta;
GRANT ALL ON Tag TO basta;
GRANT ALL ON Media TO basta;
GRANT ALL ON Season TO basta;
GRANT ALL ON Episode TO basta;
GRANT ALL ON Rating TO basta;
GRANT ALL ON available_in TO basta;
GRANT ALL ON queues TO basta;
GRANT ALL ON describes TO basta;

INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);
INSERT INTO Account VALUES (DEFAULT);

INSERT INTO Region VALUES ('Canada');
INSERT INTO Region VALUES ('USA');
INSERT INTO Region VALUES ('Germany');

INSERT INTO AccountUser VALUES ('User', 1, 'Canada');
INSERT INTO AccountUser VALUES ('User', 2, 'Canada');
INSERT INTO AccountUser VALUES ('User', 3, 'Canada');
INSERT INTO AccountUser VALUES ('User', 4, 'USA');
INSERT INTO AccountUser VALUES ('User', 5, 'USA');
INSERT INTO AccountUser VALUES ('User', 6, 'USA');
INSERT INTO AccountUser VALUES ('User', 7, 'Germany');
INSERT INTO AccountUser VALUES ('User', 8, 'Germany');
INSERT INTO AccountUser VALUES ('User', 9, 'Germany');
INSERT INTO AccountUser VALUES ('User', 10, 'Germany');

INSERT INTO Media VALUES (DEFAULT, 'Pokemon', NULL, NULL);
INSERT INTO Media VALUES (DEFAULT, 'Digimon', NULL, NULL);
INSERT INTO Media VALUES (DEFAULT, 'Jumanji', NULL, NULL);

INSERT INTO Tag VALUES (DEFAULT, 'The Rock');

INSERT INTO Season VALUES (1, 1);
INSERT INTO Season VALUES (2, 1);
INSERT INTO Season VALUES (3, 1);
INSERT INTO Season VALUES (4, 1);
INSERT INTO Season VALUES (5, 1);
INSERT INTO Season VALUES (6, 1);
INSERT INTO Season VALUES (7, 1);
INSERT INTO Season VALUES (8, 1);
INSERT INTO Season VALUES (9, 1);
INSERT INTO Season VALUES (10, 1);

INSERT INTO Episode VALUES (1, 1, 1, 'Episode');
INSERT INTO Episode VALUES (1, 2, 1, 'Episode');
INSERT INTO Episode VALUES (2, 2, 1, 'Episode');
INSERT INTO Episode VALUES (1, 3, 1, 'Episode');
INSERT INTO Episode VALUES (2, 3, 1, 'Episode');
INSERT INTO Episode VALUES (3, 3, 1, 'Episode');
INSERT INTO Episode VALUES (1, 4, 1, 'Episode');
INSERT INTO Episode VALUES (1, 5, 1, 'Episode');
INSERT INTO Episode VALUES (2, 5, 1, 'Episode');
INSERT INTO Episode VALUES (1, 6, 1, 'Episode');
INSERT INTO Episode VALUES (2, 6, 1, 'Episode');
INSERT INTO Episode VALUES (3, 6, 1, 'Episode');
INSERT INTO Episode VALUES (1, 7, 1, 'Episode');
INSERT INTO Episode VALUES (1, 8, 1, 'Episode');
INSERT INTO Episode VALUES (2, 8, 1, 'Episode');
INSERT INTO Episode VALUES (1, 9, 1, 'Episode');
INSERT INTO Episode VALUES (2, 9, 1, 'Episode');
INSERT INTO Episode VALUES (3, 9, 1, 'Episode');
INSERT INTO Episode VALUES (1, 10, 1, 'Episode');

INSERT INTO available_in VALUES (1, 'Canada');
INSERT INTO available_in VALUES (2, 'Canada');
INSERT INTO available_in VALUES (3, 'Canada');
INSERT INTO available_in VALUES (1, 'USA');
INSERT INTO available_in VALUES (2, 'USA');
INSERT INTO available_in VALUES (3, 'Germany');

INSERT INTO describes VALUES (3, 1);

INSERT INTO Rating VALUES (3, 'User', 1, 2);
INSERT INTO Rating VALUES (3, 'User', 2, 3);
INSERT INTO Rating VALUES (3, 'User', 3, 2);
INSERT INTO Rating VALUES (3, 'User', 4, 1);
INSERT INTO Rating VALUES (3, 'User', 5, 3);
