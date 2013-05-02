import random, string

uid = 0
tid = 0

def rand_str(N):
		return ''.join(random.choice(string.ascii_uppercase + string.digits) for x in range(N))

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
		global uid
		self.username = 'U' + rand_str(10)
		self.fullName = "FN" + rand_str(20)
		self.userID = uid
		uid += 1
		self.passwordHash = "PWH" + rand_str(50)
		self.email = "EM" + self.username[1:] + '@' + self.username[1:] + '.com'
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
		self.userID = random.randrange(uid)
		self.content = rand_str(random.randrange(140))

class Hashtag:
	tweetID = 0
	content = "#content"
	def randomize(self):
		global tid
		self.tweetID = random.randrange(tid)
		self.content = "#" + rand_str(15)
	
class Follows:
	follower = 0
	followee = 0
	def randomize(self):
		global uid
		self.follower = random.randrange(uid)
		self.followee = random.randrange(uid)
		while (self.follower == self.followee):
			self.followee = random.randrange(uid)

class RetweetsMentionsFavoritesCanSee:
	userID = 0
	tweetID = 0
	def randomize(self):
		global uid, tid
		self.userID = random.randrange(uid)
		self.tweetID = random.randrange(tid)

class Message:
	messageID = 0
	senderID = 0
	receiverID = 0
	content = "content"
	def randomize(self):
		global uid
		self.content = "content" + rand_str(100)
		self.senderID = random.randrange(uid)
		self.receiverID = random.randrange(uid)
		while (self.senderID == self.receiverID):
			self.senderID = random.randrange(uid)

f = open("users.txt", "w")

for i in range(0,10):
	u = User()
	u.randomize()
	f.write(u.username + '|' + str(u.userID) + '|' + u.fullName + '|' + u.passwordHash + '|' + u.email + \
			'|' + u.imageURL + '|' + u.facebookURL + '|' + u.tagline + '\n')

f = open("tweets.txt", "w")

for i in range(0,50):
	t = Tweet()
	t.randomize()
	f.write(str(t.tweetID) + '|' + str(t.userID) + '|' + t.content + '\n')

f = open("hashtags.txt", "w")

for i in range(0,10):
	h = Hashtag()
	h.randomize()
	f.write(str(h.tweetID) + '|' + h.content + '\n')

f = open("follows.txt", "w")

for i in range(0,15):
	fo = Follows()
	fo.randomize()
	f.write(str(fo.follower) + '|' + str(fo.followee) + '\n')

for filename in ["retweets.txt", "mentions.txt", "favorites.txt", "cansee.txt"]:
	f = open(filename, "w")
	for i in range(0,15):
		fo = RetweetsMentionsFavoritesCanSee()
		fo.randomize()
		f.write(str(fo.tweetID) + '|' + str(fo.userID) + '\n')

f = open("messages.txt", "w")

for i in range(0,15):
	fo = Message()
	fo.randomize()
	f.write(str(fo.senderID) + '|' + str(fo.receiverID) + '|' + fo.content + '\n')