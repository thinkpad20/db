LOAD DATA
LOCAL INFILE "users.txt"
REPLACE INTO TABLE User
FIELDS TERMINATED BY '|'
(username, userID, fullName, passwordHash, email, imageURL, facebookURL, tagline)

LOAD DATA
LOCAL INFILE "tweets.txt"
REPLACE INTO TABLE Tweet
FIELDS TERMINATED BY '|'
(tweetID, userID, content)

LOAD DATA
LOCAL INFILE "hashtags.txt"
REPLACE INTO TABLE Hashtag
FIELDS TERMINATED BY '|'
(tweetID, content)

LOAD DATA
LOCAL INFILE "follows.txt"
REPLACE INTO TABLE Follows
FIELDS TERMINATED BY '|'
(follower, followee)

LOAD DATA
LOCAL INFILE "retweets.txt"
REPLACE INTO TABLE Retweets
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "mentions.txt"
REPLACE INTO TABLE Mentions
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "favorites.txt"
REPLACE INTO TABLE Favorites
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "cansee.txt"
REPLACE INTO TABLE CanSee
FIELDS TERMINATED BY '|'
(tweetID, userID)

LOAD DATA
LOCAL INFILE "messages.txt"
REPLACE INTO TABLE Message
FIELDS TERMINATED BY '|'
(messageID, senderID, receiverID, content)

