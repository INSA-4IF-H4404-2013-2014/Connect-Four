:- [gameSurvival].
:- [testUtils].
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

%Return false if 2 plays or 1 if 1 plays
testAlmostFullGrid([
[1, 1, 2, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 1, 2, 1, 2],
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
[1, 1, 1, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 1, 2, 2],
[2, 2, 2, 1, 1, 1],
[1, 1, 2, 1, 2],
[2, 2, 1, 1, 2],
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

testGridPlayer1WinNextTurn([
    [],
    [1],
    [1,1,2],
    [2,2,1,2],
    [1,2,1],
    [1,2],
    [2,1,1]
]).

testOtherCanWin :-
	testFullGrid(M1),
	not(gameOtherCanWin(M1, 1, _)),
	testEmptyGrid(M2),
	not(gameOtherCanWin(M2, 1, _)),
	testGridNoOneWinNextTurn(M3),
	not(gameOtherCanWin(M3, 1, _)),
	testGridPlayer2WinNextTurn(M4),
	gameOtherCanWin(M4, 2, 4).

testSurvival :- 
	testFullGrid(M1),
	not(gameSurvive(M1, 1, _)),
	testEmptyGrid(M2),
	not(gameSurvive(M2, 1, _)),
	testGridNoOneWinNextTurn(M3),
	not(gameSurvive(M3, 1, _)),
	testGridPlayer2WinNextTurn(M4),
	gameSurvive(M4, 1, _),
	testGridPlayer1WinNextTurn(M5),
	gameSurvive(M5, 2, _),
	testAlmostFullGrid(M6),
	gameSurvive(M6, 1, _),
	not(gameSurvive(M6, 2, _)).
	
testAllSurvival :-
	test(testOtherCanWin),
	test(testSurvival).
	
	
	
	
