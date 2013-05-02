LOAD DATA
LOCAL INFILE "~/Documents/users.txt"
REPLACE INTO TABLE User
FIELDS TERMINATED BY '|'
(username, userID, fullName, passwordHash, email, imageURL, facebookURL, tagline)

LOAD DATA
LOCAL INFILE "~/Documents/tweets.txt"
REPLACE INTO TABLE Tweet
FIELDS TERMINATED BY '|'
(tweetID, userID, content)

LOAD DATA
LOCAL INFILE "~/Documents/hashtags.txt"
REPLACE INTO TABLE Hashtag
FIELDS TERMINATED BY '|'
(tweetID, content)

LOAD DATA
LOCAL INFILE "~/Documents/follows.txt"
REPLACE INTO TABLE Follows
FIELDS TERMINATED BY '|'
(follower, followee)

LOAD DATA
LOCAL INFILE "~/Documents/retweets.txt"
REPLACE INTO TABLE Retweets
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "~/Documents/mentions.txt"
REPLACE INTO TABLE Mentions
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "~/Documents/favorites.txt"
REPLACE INTO TABLE Favorites
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "~/Documents/cansee.txt"
REPLACE INTO TABLE CanSee
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "~/Documents/messages.txt"
REPLACE INTO TABLE Message
FIELDS TERMINATED BY '|'
(messageID, senderID, receiverID, content)

