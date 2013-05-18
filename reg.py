# import re

# line = "(text 1###123)(text 2###345)";

# matchObj = re.match( r'\((.*)###([0-9]+)\)', line)

# if matchObj:
#    print matchObj.group(0)
#    # print "matchObj.group(1) : ", matchObj.group(1) PRODUCES ERROR
#    # print "matchObj.group(2) : ", matchObj.group(2)
# else:
#    print "No match!!"

def parseText(text):
	arr = []
	dic = {}
	optionnum, nvotes, i = 0, 0, 0
	while i < len(text):
		optionnumtext = ""
		option = ""
		numtext = ""
		if text[i] == '(':
			i += 1

			while text[i:i+3] != '###':
				option += text[i]
				i += 1
			i += 3

			while text[i] != ')':
				numtext += text[i]
				i += 1
			nvotes = int(numtext)

		arr.append(option)
		dic[option] = nvotes
		i += 1
	print arr, dic

parseText("(text 1###123)(text 2###345)")