
:- [testUtil].
:- [gameOver].
:- [gamePrint].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testPrivateFullGrid([
    [1,1,1,2,1,1],
    [1,1,1,1,2,1],
    [1,2,1,1,1,1],
    [1,1,1,1,1,1],
    [1,1,1,1,1,2],
    [1,1,1,1,1,1],
    [1,1,1,1,1,1]]).

testPrivateAlmostFullGrid([
    [1,1,1,2,1,1],
    [1,1,1,1,2,1],
    [2,1,2,1,1,1],
    [1,1,1,1,1,1],
    [1,1,1,1,2],
    [1,1,1,1,1,1],
    [1,1,1,1,1,1]]).
	
testPrivateDrawMatchGrid1([
	[2,1,2,2,1,1],
	[1,2,1,1,2,1],
	[2,1,2,2,2,1],
	[1,2,1,1,1,2],
	[2,1,1,2,1,1],
	[2,1,2,1,2,2],
	[2,1,2,2,1,2]
]).

testPrivateDrawMatchGrid2([
	[2,2,2,1,1,1],
	[1,1,1,2,2,2],
	[2,2,2,1,1,1],
	[1,1,1,2,2,2],
	[2,2,2,1,1,1],
	[1,1,1,2,2,2],
	[2,2,2,1,1,1]
]).

testPrivateWonPlayer([
	[2,1,1,1,1],
	[2,1,1,2,2],
	[2,2,2,1,1],
	[1,1,1,2,2,2],
	[2,2,2,1,1],
	[1,1,1,2,2,2],
	[2,2,2,1,1,1]
]).

%This can be reused for all directions
testPrivateNotWon1([
	[2,2,2],
	[1,2,1],
	[1,1],
	[1],
	[2,1],
	[2,2,1],
	[]
]).

%This can be reused for all directions
testPrivateWonColumnNotWonOthers([
	[2,2,2],
	[1,1,2],
	[2,2,1],
	[1,1,1,1],
	[2,2,1],
	[1,1,2],
	[2,2,2]
]).

testPrivateWonDiagonal1([
	[],
	[1],
	[2,1,2,1],
	[2,2,1],
	[2,1,2],
	[1],
	[]
]).

privatePrintAllGameOverTestGrids :-
	testPrivateFullGrid(M),
	testPrivateAlmostFullGrid(M2),
	testPrivateDrawMatchGrid1(M3),
	testPrivateDrawMatchGrid2(M4),
	testPrivateWonPlayer(M5),
	testPrivateNotWon1(M6),
	testPrivateWonColumnNotWonOthers(M7),
	testPrivateWonDiagonal1(M8),
	gamePrintGrid(M),write('\n'),
	gamePrintGrid(M2),write('\n'),
	gamePrintGrid(M3),write('\n'),
	gamePrintGrid(M4),write('\n'),
	gamePrintGrid(M5),write('\n'),
	gamePrintGrid(M6),write('\n'),
	gamePrintGrid(M7),write('\n'),
	gamePrintGrid(M8).

testGridIsFull :-
    testPrivateFullGrid(X),
    testPrivateAlmostFullGrid(Y),
	testPrivateWonColumnNotWonOthers(Z),
    gameGridIsFull(X),
    not(gameGridIsFull(Y)),
    not(gameGridIsFull([[], [], [], [], [], [], []])),
	not(gameGridIsFull(Z)).

testPrivateGamePlayerWonStarCheckColumn :-
	testPrivateDrawMatchGrid2(M),
	testPrivateWonPlayer(M2),
	testPrivateNotWon1(M3),
	testPrivateWonColumnNotWonOthers(M4),
	linesNumber(LN),
	not(privateGamePlayerWonStarCheckColumn(M, 2, LN, LN, 1)),
	privateGamePlayerWonStarCheckColumn(M2, 1, 5, 5, 1),
	not(privateGamePlayerWonStarCheckColumn(M3, 1, 3, 3, 2)),
	not(privateGamePlayerWonStarCheckColumn(M4, 1, 3, 3, 2)),
	not(privateGamePlayerWonStarCheckColumn(M4, 7, 3, 3, 1)),
	not(privateGamePlayerWonStarCheckColumn(M4, 7, 3, 3, 2)),
	not(privateGamePlayerWonStarCheckColumn(M4, 4, 4, 4, 2)),
	privateGamePlayerWonStarCheckColumn(M4, 4, 4, 4, 1).

testPrivateGamePlayerWonStarCheckDiagonal :-
	testPrivateDrawMatchGrid1(M),
	testPrivateWonPlayer(M2),
	testPrivateNotWon1(M3),
	testPrivateWonColumnNotWonOthers(M4),
	testPrivateWonDiagonal1(M5),
	not(privateGamePlayerWonStarCheckDiagonal(M, 3, 3, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M, 3, 3, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M, 4, 4, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M, 4, 4, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M2, 3, 4, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M2, 3, 4, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M3, 4, 1, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M3, 4, 1, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M4, 4, 4, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M4, 4, 4, 2)),
	privateGamePlayerWonStarCheckDiagonal(M5, 3, 4, 1).

testGameOverDrawMatch :-
	testPrivateDrawMatchGrid2(M),
	gameOver(M, 1, 0),
	gameOver(M, 2, 0),
	gameOver(M, 3, 0),
	gameOver(M, 4, 0),
	gameOver(M, 5, 0),
	gameOver(M, 6, 0),
	gameOver(M, 7, 0),
	not(gameOver(M, 45, 0)),
	testPrivateDrawMatchGrid1(M2),
	gameOver(M2, 5, 0).
	
testAllGameOver :-
    test(testGridIsFull),
	test(testPrivateGamePlayerWonStarCheckColumn),
	test(testPrivateGamePlayerWonStarCheckDiagonal),
	test(testGameOverDrawMatch).
