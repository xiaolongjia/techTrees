
with open('pyfile_test.txt', 'a') as file:
	file.write('\n this is a test file \n')

with open('pyfile_test.txt') as file:  
	for line in file:
		line = line.rstrip('\n')
		print(line)
		 