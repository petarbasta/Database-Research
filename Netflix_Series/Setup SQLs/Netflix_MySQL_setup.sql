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
	accid SERIAL,
	PRIMARY KEY (accid)
);	

CREATE TABLE Payment (
	pid SERIAL,
	date DATE NOT NULL,
	amount FLOAT NOT NULL,
	accid BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(pid),
	FOREIGN KEY(accid) REFERENCES Account(accid) 
);

CREATE TABLE Region (
	regName VARCHAR(30) NOT NULL,
	PRIMARY KEY (regName)
);

CREATE TABLE Tag (
	tid SERIAL,
	tagName VARCHAR(30) NOT NULL,
	PRIMARY KEY (tid)
);

CREATE TABLE Media (
	mid SERIAL,
	title VARCHAR(30) NOT NULL,
	releaseYear INTEGER,
	isComplete BOOLEAN,
	PRIMARY KEY (mid)
);

CREATE TABLE AccountUser (
	userName VARCHAR(30) NOT NULL,
	accid BIGINT UNSIGNED NOT NULL,
	regName VARCHAR(30) NOT NULL,
	PRIMARY KEY (userName, accid),
	FOREIGN KEY (accid) REFERENCES Account(accid),
	FOREIGN KEY (regName) REFERENCES Region(regName)
);

CREATE TABLE Season ( 
	seasonNum INTEGER NOT NULL CHECK (seasonNum > 0),
	mid BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (seasonNum, mid),
	FOREIGN KEY (mid) REFERENCES Media(mid)
); 

CREATE TABLE Episode (
	epNum INTEGER NOT NULL CHECK (epNum > 0),
	seasonNum INTEGER NOT NULL,
	mid BIGINT UNSIGNED NOT NULL,
	epTitle VARCHAR(30) NOT NULL,
	PRIMARY KEY (epNum, seasonNum, mid),
	FOREIGN KEY (seasonNum, mid) REFERENCES Season(seasonNum, mid)
);

CREATE TABLE Rating ( 
	mid BIGINT UNSIGNED NOT NULL,
	userName VARCHAR(30) NOT NULL,
	accid BIGINT UNSIGNED NOT NULL,
	value INTEGER NOT NULL CHECK (value >= 1 AND value <= 5),
	PRIMARY KEY (mid, userName, accid),
	FOREIGN KEY (mid) REFERENCES Media(mid),
	FOREIGN KEY (userName, accid) REFERENCES AccountUser(userName, accid)
);

CREATE TABLE available_in (
	mid BIGINT UNSIGNED NOT NULL,
	regName VARCHAR(30) NOT NULL,
	PRIMARY KEY (mid, regName),
	FOREIGN KEY (mid) REFERENCES Media(mid),
	FOREIGN KEY (regName) REFERENCES Region(regName)
);

CREATE TABLE queues (
	userName VARCHAR(30) NOT NULL,
	accid BIGINT UNSIGNED NOT NULL,
	mid BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (userName, accid, mid),
	FOREIGN KEY (accid) REFERENCES Account(accid),
	FOREIGN KEY (mid) REFERENCES Media(mid)
);

CREATE TABLE describes ( 
	mid BIGINT UNSIGNED NOT NULL,
	tid BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (mid, tid),
	FOREIGN KEY (mid) REFERENCES Media(mid),
	FOREIGN KEY (tid) REFERENCES Tag(tid)
);
	
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
