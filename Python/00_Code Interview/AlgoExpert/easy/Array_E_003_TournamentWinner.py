#!C:\Python38\Python
#coding=utf-8

'''
Tournament Winner 

There's an algorithms tournament taking place in which teams of programmers compete
against each other to solve algorithmic problems as fast as possible.
Teams compete in a round robin, where each team faces off against all other teams.
Only two teams compete against each other at a time, and for each competition, one team 
is designated the home team, while the other team is the away team. In each competition
there's always one winner and one loser; there are no ties. A team receives 3 points
if it wins and 0 points if it loses. The winner of the tournament is the team that 
receives the most amount of points. 

Given an array of pairs representing the teams that have competed against each other 
and an array containing the results of each competition, write a function that 
returns the winner of the tournament. The input arrays are named competitions 
and results, respectively. The competitions array has elements in the form of 
[homeTeam, awayTeam], where each team is a string of at most 30 characters representing 
the name of the team. The results array contains information about the winner of each 
corresponding competition in the competitions array. 

Specifically, results[i] denotes the winner of competitions[i], where a 1 in the results 
array means that the home team in the corresponding competition won and a 0 means 
that the away team won.

Sample input:

competitions = [
	["HTML", "c#"],
	["C#", "[PYTHON"],
	["PYTHON", "HTML"]
]

results = [0,0,1]

Sample output:

"PYTHON"
'''
competitions = [
	["HTML", "c#"],
	["C#", "[PYTHON"],
	["PYTHON", "HTML"]
]

results = [0,0,1]
print(tournamentWinner(competitions, results))

def tournamentWinner(competitions, results):
    # Write your code here.
	output = {}
	for i in range(len(competitions)):
		winner = competitions[i][1] if results[i] == 0 else competitions[i][0]
		if (winner in output.keys()) :
			output[winner] += 3
		else :
			output[winner] =3
	winner = ''
	maxScore= 0
	for (team, scores) in output.items():
		if (scores > maxScore):
			maxScore = scores
			winner = team
    return winner
	
