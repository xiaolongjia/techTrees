#!C:\Python\Python
#coding=utf-8

'''
Youngest Common Ancestor

You are given three inputs, all of which are instances of an AncestralTree class that 
have an ancestor property pointing to their youngest ancestor. The first input is the top
ancestor in an ancestral tree (i.e., the only instance that has no ancestor -- its 
ancestor property points to None / null), and the other two inputs are descendants in the 
ancestral tree. 

Write a function that returns the youngest common ancestor to the two descendants.

Note that a descendant is considered its own ancestor. So in the simple ancestral tree below,
the youngest common ancestor to nodes A and B is node A.
     A 
    /
   B 

Sample Input:
topAncestor: node A 
descendantOne: node E 
descendantTwo: node I 
       A
     /   \
    B     C
   / \   /  \
  D   E F    G 
 / \          
H   I

Sample Output: 
node B 
'''

class AncestralTree:
    def __init__(self, name):
        self.name = name
        self.ancestor = None

#solution 1
def getYoungestCommonAncestor(topAncestor, descendantOne, descendantTwo):
	depthOne = getDepths(topAncestor, descendantOne)
	depthTwo = getDepths(topAncestor, descendantTwo)
	if depthOne > depthTwo:
		return backtraceAncestor(descendantOne, descendantTwo, depthOne-depthTwo)
	else:
		return backtraceAncestor(descendantTwo, descendantOne, depthTwo-depthOne)

def backtraceAncestor(lowerNode, higherNode, diff):
	while diff > 0:
		lowerNode = lowerNode.ancestor 
		diff -= 1
	while lowerNode != higherNode:
		lowerNode = lowerNode.ancestor
		higherNode = higherNode.ancestor 
	return lowerNode
	
def getDepths(topAncestor, descendant):
	depth = 0
	while descendant != topAncestor:
		depth += 1
		descendant = descendant.ancestor
	return depth 

#solution 2
#def getYoungestCommonAncestor(topAncestor, descendantOne, descendantTwo):
#    oneAncestors= []
#    twoAncestors= []
#    getAncestors(descendantOne, oneAncestors)
#    getAncestors(descendantTwo, twoAncestors)
#    oneAncestors.reverse()
#    twoAncestors.reverse()
#    if len(oneAncestors) >= len(twoAncestors):
#        oneAncestors, twoAncestors = oneAncestors, twoAncestors  
#    else:
#        oneAncestors, twoAncestors = twoAncestors, oneAncestors
#    for i in range(len(oneAncestors)):
#        if i > len(twoAncestors) - 1:
#            return oneAncestors[i-1]
#        elif i == len(twoAncestors) - 1:
#            if twoAncestors[i] == oneAncestors[i]:
#                return oneAncestors[i]
#            else:
#                return oneAncestors[i-1]
#        else :
#            if oneAncestors[i] == twoAncestors[i]:
#                continue 
#            else:
#                return  oneAncestors[i-1]
#
#def getAncestors(node, array=[]):
#    if node is None:
#        return
#    array.append(node)
#    getAncestors(node.ancestor, array)

nodeA = AncestralTree("A")
nodeB = AncestralTree("B")
nodeC = AncestralTree("C")
nodeD = AncestralTree("D")
nodeE = AncestralTree("E")
nodeF = AncestralTree("F")
nodeG = AncestralTree("G")
nodeH = AncestralTree("H")
nodeI = AncestralTree("I")
nodeJ = AncestralTree("J")
nodeK = AncestralTree("K")
nodeL = AncestralTree("L")
nodeM = AncestralTree("M")
nodeN = AncestralTree("N")
nodeO = AncestralTree("O")
nodeP = AncestralTree("P")
nodeQ = AncestralTree("Q")
nodeR = AncestralTree("R")
nodeS = AncestralTree("S")
nodeT = AncestralTree("T")
nodeU = AncestralTree("U")
nodeV = AncestralTree("V")
nodeW = AncestralTree("W")
nodeX = AncestralTree("X")
nodeY = AncestralTree("Y")
nodeZ = AncestralTree("Z")
nodeB.ancestor = nodeA
nodeC.ancestor = nodeA
nodeD.ancestor = nodeA
nodeE.ancestor = nodeA
nodeF.ancestor = nodeA
nodeG.ancestor = nodeB
nodeH.ancestor = nodeB
nodeI.ancestor = nodeB
nodeJ.ancestor = nodeC
nodeK.ancestor = nodeD
nodeL.ancestor = nodeD
nodeM.ancestor = nodeF
nodeN.ancestor = nodeF
nodeO.ancestor = nodeH
nodeP.ancestor = nodeH
nodeQ.ancestor = nodeH
nodeR.ancestor = nodeH
nodeS.ancestor = nodeK
nodeT.ancestor = nodeP
nodeU.ancestor = nodeP
nodeV.ancestor = nodeR
nodeW.ancestor = nodeV
nodeX.ancestor = nodeV
nodeY.ancestor = nodeV
nodeZ.ancestor = nodeX
print(getYoungestCommonAncestor(nodeA, nodeT, nodeH).name)