#!C:\Python\Python

def datatype_counter(str):
    vowels = 0
    consonant = 0
    digit = 0
    specialChar = 0
    for i in range(len(str)):
        myChar = str[i]
        if ((myChar >= 'a' and myChar <= 'z') or
                (myChar >= 'A' and myChar <= 'Z')):
            myChar = myChar.lower()
            if myChar in ['a', 'e', 'o', 'i', 'u']:
                vowels += 1
            else:
                consonant += 1
        elif (myChar >= '0' and myChar <= '9'):
            digit += 1
        else:
            specialChar += 1
    print("Vowels:", vowels) 
    print("Consonant:", consonant)  
    print("Digit:", digit)  
    print("Special Character:", specialChar)  

mystr = "geeks for geeks121"
datatype_counter(mystr)


