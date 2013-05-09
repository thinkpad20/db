import random, string

populateDB = open("populate_db.sql", "w")
ptext = "LOAD DATA\n" + "LOCAL INFILE \"%s\"\n" + \
		"REPLACE INTO TABLE %s\n" + "FIELDS TERMINATED BY '|'\n" \
		"(%s);\n\n"

uid = 1
tid = 1
mid = 1
NUM_CITIES = 500
NUM_LOCATIONS = 200
NUM_USERS = 2000
NUM_TWEETS = 10000
NUM_HASHTAGS = 1000
NUM_MISC = 100
NUM_FOLLOWS = 1500
NUM_MESSAGES = 1000
usernames = {}

def rand_str(N, spaces = False):
	global words
	l = 0
	output = ""
	while l < N:
		output += random.choice(words)
		if spaces:
			output += " "
		l = len(output)
	if spaces:
		output = output[:-1] + "."
	return output

words = []

for letter in string.uppercase:
	wordslist = [line.strip() for line in open("words/%s Words.csv" % letter)]
	words = words + wordslist
# for i in range(10):
# 	print words[i]

states = [line.strip() for line in open("words/states.txt")]
cities = [random.choice(words).title() for i in range(NUM_CITIES)]
locations = [("Somewhere", "Illinois")]


class User:
	username = "U"
	userID = 0
	fullName = "FN"
	passwordHash = "PWH"
	email = "EM"
	imageURL = "iURL"
	facebookURL = "fbURL"
	tagline = "tgln"
	def randomize(self):
		global uid, locations, usernames

		# generate unique user name
		username = rand_str(10)
		while username in usernames:
			username = rand_str(10)
		self.username = username
		usernames[self.username] = True

		self.fullName = "FN" + rand_str(20)
		self.userID = uid
		uid += 1
		self.city, self.state = random.choice(locations)
		self.passwordHash = "PWH" + rand_str(50)
		self.email = self.username + '@' + self.username + '.com'
		self.imageURL = "http://www.iURL.com/" + rand_str(10)
		self.facebookURL = "http://www.facebook.com/" + self.username
		self.tagline = "tgln" + rand_str(100)

class Tweet:
	tweetID = 0
	userID = 0
	content = "content"
	def randomize(self):
		global uid, tid
		self.tweetID = tid
		tid += 1
		self.userID = random.randrange(1, uid)
		self.content = rand_str(random.randrange(140), True)

class Hashtag:
	tweetID = 0
	content = "#content"
	def randomize(self):
		global tid
		self.tweetID = random.randrange(2, tid)
		self.content = "#" + rand_str(15)
	
class Follows:
	follower = 0
	followee = 0
	def randomize(self):
		global uid
		self.follower = random.randrange(1, uid)
		self.followee = random.randrange(1, uid)
		while (self.follower == self.followee):
			self.followee = random.randrange(1, uid)

class RetweetsMentionsFavoritesCanSee:
	userID = 0
	tweetID = 0
	def randomize(self):
		global uid, tid
		self.userID = random.randrange(1, uid)
		self.tweetID = random.randrange(2, tid)

class Message:
	messageID = 0
	senderID = 0
	receiverID = 0
	content = "content"
	def randomize(self):
		global uid, mid
		self.messageID = mid
		mid += 1
		self.content = rand_str(100, True)
		self.senderID = random.randrange(1, uid)
		self.receiverID = random.randrange(1, uid)
		while (self.senderID == self.receiverID):
			self.senderID = random.randrange(1, uid)

class Location:
	def __init__(self):
		self.state = ""
		self.city = ""
	def randomize(self):
		self.state = random.choice(states)
		self.city = random.choice(cities)		




def generateData():
	global locations
	f = open("locations.dat", "w")
	for i in range(0,NUM_LOCATIONS):
		fo = Location()
		fo.randomize()
		f.write(fo.city + '|' + fo.state + '\n')
		locations += [(fo.city, fo.state)]
	populateDB.write(ptext % ("locations.dat", "Location", "city, state"))

	##################
	# USERS
	#####################

	f = open("users.dat", "w")

	for i in range(0,NUM_USERS):
		u = User()
		u.randomize()
		f.write(u.username + '|' + u.fullName + '|' + u.passwordHash + '|' + u.email + \
				'|' + u.imageURL + '|' + u.facebookURL + '|' + u.tagline + '|' + u.city + '|' + u.state + '\n')

	populateDB.write(ptext % ("users.dat", "User", "username, fullName, " +
									"passwordHash, email, imageURL, facebookURL, tagline, city, state"))

	##################
	# TWEETS
	#####################

	f = open("tweets.dat", "w")

	for i in range(0,NUM_TWEETS):
		t = Tweet()
		t.randomize()
		f.write(str(t.userID) + '|' + t.content + '\n')

	populateDB.write(ptext % ("tweets.dat", "Tweet", "userID, content"))

	##################
	# HASHTAGS
	#####################

	f = open("hashtags.dat", "w")

	for i in range(0,NUM_HASHTAGS):
		h = Hashtag()
		h.randomize()
		f.write(str(h.tweetID) + '|' + h.content + '\n')

	populateDB.write(ptext % ("hashtags.dat", "HashTag", "tweetID, content"))

	##################
	# FOLLOWS
	#####################

	f = open("follows.dat", "w")

	for i in range(0,NUM_FOLLOWS):
		fo = Follows()
		fo.randomize()
		f.write(str(fo.follower) + '|' + str(fo.followee) + '\n')

	populateDB.write(ptext % ("follows.dat", "Follows", "follower, followee"))

	##################
	# Retweets, etc
	#####################

	schema = {"retweets.dat":"Retweets", "mentions.dat":"Mentions", "favorites.dat":"Favorites", "cansee.dat":"CanSee"}

	for filename in ["retweets.dat", "mentions.dat", "favorites.dat", "cansee.dat"]:
		f = open(filename, "w")
		for i in range(0,NUM_MISC):
			fo = RetweetsMentionsFavoritesCanSee()
			fo.randomize()
			f.write(str(fo.tweetID) + '|' + str(fo.userID) + '\n')
		populateDB.write(ptext % (filename, schema[filename], "tweetID, userID"))

	##################
	# Messages
	#####################

	f = open("messages.dat", "w")
	for i in range(0,NUM_MESSAGES):
		fo = Message()
		fo.randomize()
		f.write(str(fo.senderID) + '|' + str(fo.receiverID) + '|' + fo.content + '\n')
	populateDB.write(ptext % ("messages.dat", "Message", "senderID, receiverID, content"))

generateData()





