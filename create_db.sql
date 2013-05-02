CREATE TABLE User (
	username 		VARCHAR(20) 	NOT NULL,
	userID 			INTEGER			NOT NULL,
	fullName 		VARCHAR(100),
	passwordHash 	VARCHAR(256) 	NOT NULL,
	email 			VARCHAR(256)	NOT NULL,
	imageURL 		VARCHAR(200),
	facebookURL		VARCHAR(200),
	tagline 		VARCHAR(140),
	memberSince 	TIMESTAMP		NOT NULL,
	PRIMARY KEY (userID)
);

CREATE TABLE Tweet (
	tweetID INTEGER 				NOT NULL,
	userID INTEGER	 				NOT NULL,
	content VARCHAR(140)			NOT NULL,
	TIMESTAMP			 			NOT NULL,
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
	TIMESTAMP						NOT NULL,
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
	messageID INTEGER				NOT NULL,
	senderID INTEGER 				NOT NULL,
	receiverID INTEGER	 			NOT NULL,
	content VARCHAR(140)			NOT NULL,
	TIMESTAMP			 			NOT NULL,
	PRIMARY KEY (messageID),
	FOREIGN KEY (senderID) REFERENCES User(userID)
	FOREIGN KEY (receiverID) REFERENCES User(userID)
);