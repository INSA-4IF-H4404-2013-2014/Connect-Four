:- [gameSurvival].
:- [testUtil].
:- [gamePrint].

%Return false (can't happen)
testFullGrid([
[1, 1, 1, 2, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 1, 2, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 1, 2, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 1, 2, 2, 2]]).

%Return false
testEmptyGrid([
[],
[],
[],
[],
[],
[],
[]]).

%Return false
testGridNoOneWinNextTurn([
[1, 1, 1, 2, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 1, 2, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 2, 1, 2],
[2, 2, 1, 1],
[]]).

%Return 1
testGridPlayer2WinNextTurn([
[1],
[1],
[1, 2, 2, 2],
[],
[],
[],
[]]).

testSurvival :- 
	testFullGrid(M1),
	not(survive(M1, 1, _)),
	%testEmptyGrid(M2),
	%not(survive(M2, 1, _)).
	%testGridNoOneWinNextTurn(M3),
	%not(survive(M3, 1, _)).
	testGridPlayer2WinNextTurn(M4),
	survive(M4, 2, 4).

testAllSurvival :-
	test(testSurvival).
	
	
	
	
