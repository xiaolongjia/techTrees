#!C:\Python\Python

import array


'''
string container: string a "BNDWDAQWDC", string b "ABA", 
please write code to check if all characters in string b are contained in string a
let us asume length of a is n, length of b is m 
 time  complexity: O(n)
 space complexity: O(1)
'''

# Brute-force
# T(n) = O(n*m)
def strContainer (strA, strB):
    if len(strA) < len(strB):
        (strA, strB) = (strB, strA)

    for srcIdx in range(len(strB)):
        flag = False

        for dstIdx in range(len(strA)):
            if strA[dstIdx] == strB[srcIdx]:
                flag = True

        if flag == False:
            return False

    return True

# Permit to sort string a and b
# T(n) = O(n*logn) + O(m*logm) + O(n+m)

def strContainerSort (strA, strB):
    if len(strA) < len(strB):
        (strA, strB) = (strB, strA)

    strA.sort() # O(n*logn)
    strB.sort() # O(m*logm)
    print("sorted A is ", strA)
    print("sorted B is ", strB)

    '''
    newA = sorted(strA)
    newB = sorted(strB)
    '''

    idxA = 0
    idxB = 0
    while(idxB < len(strB)):
        while ((idxA < len(strA)) and (strA[idxA] < strB[idxB])):
            idxA += 1
        if (idxA >= len(strA)) or (strA[idxA] > strB[idxB]):
            return False
        idxB += 1
    return True




#myStrA = array.array("u", ["B", "N", "W", "D", "A", "Q", "W", "D", "C"])
#myStrB = array.array("u", ["A", "B", "A"])

#myStrA = array.array("u", list("BNDWDAQWDC"))
#myStrB = array.array("u", list("ABA"))

myStrA = list("BNDWDAQWDC")
myStrB = list("ABA")

#print(strContainer(myStrA, myStrB))
print(strContainerSort(myStrA, myStrB))



