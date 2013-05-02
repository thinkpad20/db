SELECT *
	FROM User
	ORDER BY userID;

SELECT content
	FROM Tweet
	WHERE userID > 5
	ORDER BY tweetID;

SELECT *
	FROM Follows
	WHERE followee < follower
	ORDER BY followee;

SELECT content
	FROM HashTag
	WHERE userID = 