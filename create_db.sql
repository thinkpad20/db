CREATE TABLE User (
	username 		VARCHAR(50) 	NOT NULL UNIQUE,
	userID 			INTEGER			NOT NULL AUTO_INCREMENT,
	fullName 		VARCHAR(100),
	passwordHash 	VARCHAR(256) 	NOT NULL,
	email 			VARCHAR(256)	NOT NULL,
	imageURL 		VARCHAR(200),
	facebookURL		VARCHAR(200),
	tagline 		VARCHAR(140),
	city 			VARCHAR(100),
	state			VARCHAR(50),
	sex				VARCHAR(10),
	age				INTEGER,
	memberSince 	TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (userID)	
);

CREATE TABLE Tweet (
	tweetID INTEGER 				NOT NULL AUTO_INCREMENT,
	userID INTEGER	 				NOT NULL,
	content VARCHAR(140)			NOT NULL,
	dateTime TIMESTAMP			 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (tweetID),
	FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE HashTag (
	tweetID INTEGER 				NOT NULL,
	content VARCHAR(140) 			NOT NULL,
	PRIMARY KEY (content),
	FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID)
);

CREATE TABLE Follows (
	follower INTEGER 				NOT NULL,
	followee INTEGER 				NOT NULL,
	PRIMARY KEY (follower, followee),
	FOREIGN KEY (follower) REFERENCES User(userID),
	FOREIGN KEY (followee) REFERENCES User(userID)
);

CREATE TABLE Retweets (
	tweetID INTEGER 				NOT NULL,
	userID INTEGER 					NOT NULL,
	dateTime TIMESTAMP				NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (userID, tweetID),
	FOREIGN KEY (userID) REFERENCES User(userID),
	FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID)
);

CREATE TABLE Mentions (
	tweetID INTEGER 				NOT NULL,
	userID INTEGER 					NOT NULL,
	PRIMARY KEY (tweetID, userID),
	FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID),
	FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE Favorites (
	tweetID INTEGER 				NOT NULL,
	userID INTEGER 					NOT NULL,
	PRIMARY KEY (tweetID, userID),
	FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID),
	FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE CanSee (
	tweetID INTEGER				 	NOT NULL,
	userID INTEGER 					NOT NULL,
	PRIMARY KEY (tweetID, userID),
	FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID),
	FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE Message (
	messageID INTEGER				NOT NULL AUTO_INCREMENT,
	senderID INTEGER 				NOT NULL,
	receiverID INTEGER	 			NOT NULL,
	content VARCHAR(140)			NOT NULL,
	dateTime TIMESTAMP			 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (messageID),
	FOREIGN KEY (senderID) REFERENCES User(userID),
	FOREIGN KEY (receiverID) REFERENCES User(userID)
);

CREATE TABLE Location (
	city VARCHAR(100)				NOT NULL,
	state VARCHAR(50)				NOT NULL,
	PRIMARY KEY (city, state)
);

CREATE TABLE Poll (
	pollID INTEGER NOT NULL AUTO_INCREMENT,
	tweetID INTEGER NOT NULL,
	pollOptionText VARCHAR(300),
	PRIMARY KEY (pollID),
	FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID)
);