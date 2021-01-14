letters = [0 for i in range(26)]
word = input()
new = input()

for let in word:
    letters[ord(let) - 97] += 1

works = len(word) == len(new) #Make sure they're the same length first
for let in new: #Make sure no letter is used too often
    if let != "*":
        letters[ord(let) - 97] -= 1
        if letters[ord(let) - 97] < 0:
            works = False
            break
    

print(works and "A" or "N")
