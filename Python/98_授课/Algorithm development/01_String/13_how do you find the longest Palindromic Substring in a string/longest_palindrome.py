#!C:\Python\Python

def longestPalindrome(str):
    start = 0
    maxLength = 1
    length = len(str)

    for i in range(1, length):
        low  = i - 1
        high = i
        while (low >= 0 and high < length and str[low] == str[high]):
            if maxLength < high - low + 1:
                start = low
                maxLength = high - low + 1
            low -= 1
            high += 1

        low  = i - 1
        high = i + 1
        while (low >= 0 and high < length and str[low] == str[high]):
            if maxLength < high - low + 1:
                start = low
                maxLength = high - low + 1
            low -= 1
            high += 1
    print("Longest Palindromic is:", str[start:(start+maxLength)])
    return maxLength

myStr = "abcb"
print(longestPalindrome(myStr))

