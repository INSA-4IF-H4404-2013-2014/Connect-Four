
:- [gameSmart].
:- [testUtils].

%Return false (can't happen)
testFullGrid([
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2]
]).

%Return false if 2 plays or 1 if 1 plays
testAlmostFullGrid([
    [1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 1, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2]
]).

%Return false
testEmptyGrid([
    [],
    [],
    [],
    [],
    [],
    [],
    []
]).

%Return false
testGridNoOneWinNextTurn([
    [1, 1, 1, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 2, 1, 2],
    [2, 2, 1, 1, 2],
    []
]).

%Return 1
testGridPlayer2WinNextTurn([
    [1],
    [1],
    [1, 2, 2, 2],
    [],
    [],
    [],
    []
]).

testGridPlayer1WinNextTurn([
    [],
    [1],
    [1,1,2],
    [2,2,1,2],
    [1,2,1],
    [1,2],
    [2,1,1]
]).

testGameCanWin :-
	testFullGrid(M1),
	not(gameCanWin(M1, 2, _)),
	testEmptyGrid(M2),
	not(gameCanWin(M2, 2, _)),
	testGridNoOneWinNextTurn(M3),
	not(gameCanWin(M3, 2, _)),
	testGridPlayer2WinNextTurn(M4),
	gameCanWin(M4, 1, 4).

testGameWinningMoves :-
	testFullGrid(M1),
	not(gameWinningMoves(M1, 2, _)),
	testEmptyGrid(M2),
	not(gameWinningMoves(M2, 2, _)),
	testGridNoOneWinNextTurn(M3),
	not(gameWinningMoves(M3, 2, _)),
	testGridPlayer2WinNextTurn(M4),
	gameWinningMoves(M4, 2, _),
	testGridPlayer1WinNextTurn(M5),
	gameWinningMoves(M5, 1, _),
	testAlmostFullGrid(M6),
	gameWinningMoves(M6, 2, _),
	not(gameWinningMoves(M6, 1, _)).

testAllGameSmart :-
	test(testGameCanWin),
	test(testGameWinningMoves).
