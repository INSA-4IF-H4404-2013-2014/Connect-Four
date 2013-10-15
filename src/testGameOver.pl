:- [testUtils].
:- [gameOver].
:- [gamePrint].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testPrivateFullGrid([
    [2,2,2,1,2,2],
    [2,2,2,2,1,2],
    [2,1,2,2,2,2],
    [2,2,2,2,2,2],
    [2,2,2,2,2,1],
    [2,2,2,2,2,2],
    [2,2,2,2,2,2]]).

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

testPrivateWonColumn1([
	[2,2,2],
	[1,1,1,1],
	[],
	[],
	[],
	[],
	[]
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

testPrivateWonDiagonal2([
	[],
	[1],
	[2,1,2],
	[2,2,1],
	[2,1,2,1],
	[1],
	[]
]).

testPrivateWonDiagonal3([
	[2,1,2,1],
	[1,2,1],
	[2,1],
	[1],
	[2,1],
	[1,2,1],
	[2,1,2,1]
]).

testPrivateWonLine1([
	[2,2,2,1],
	[1,2,2,1],
	[1,1,2,1],
	[2,2,1,1]
]).

testPrivateWonLine2([
	[2,1],
	[2,1],
	[2,1],
	[2,1],
	[2,1],
	[2,1],
	[2,1]
]).

privatePrintAllGameOverTestGrids :-
	testPrivateFullGrid(M),
	testPrivateAlmostFullGrid(M2),
	testPrivateDrawMatchGrid1(M3),
	testPrivateDrawMatchGrid2(M4),
	testPrivateWonPlayer(M5),
	testPrivateNotWon1(M6),
	testPrivateWonColumnNotWonOthers(M7),
	testPrivateWonColumn1(M8),
	testPrivateWonDiagonal1(M9),
	testPrivateWonDiagonal2(M10),
	testPrivateWonDiagonal3(M11),
	testPrivateWonLine1(M12),
	testPrivateWonLine2(M13),
	gamePrintGrid(M),write('\n'),
	gamePrintGrid(M2),write('\n'),
	gamePrintGrid(M3),write('\n'),
	gamePrintGrid(M4),write('\n'),
	gamePrintGrid(M5),write('\n'),
	gamePrintGrid(M6),write('\n'),
	gamePrintGrid(M7),write('\n'),
	gamePrintGrid(M8),write('\n'),
	gamePrintGrid(M9),write('\n'),
	gamePrintGrid(M10),write('\n'),
	gamePrintGrid(M11),write('\n'),
	gamePrintGrid(M12),write('\n'),
	gamePrintGrid(M13).

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
	testPrivateWonColumn1(M5),
	linesNumber(LN),
	not(privateGamePlayerWonStarCheckColumn(M, 2, LN, LN, 1)),
	privateGamePlayerWonStarCheckColumn(M2, 1, 5, 5, 1),
	not(privateGamePlayerWonStarCheckColumn(M3, 1, 3, 2)),
	not(privateGamePlayerWonStarCheckColumn(M4, 1, 3, 2)),
	not(privateGamePlayerWonStarCheckColumn(M4, 7, 3, 1)),
	not(privateGamePlayerWonStarCheckColumn(M4, 7, 3, 2)),
	not(privateGamePlayerWonStarCheckColumn(M4, 4, 4, 2)),
	privateGamePlayerWonStarCheckColumn(M4, 4, 4, 1),
	privateGamePlayerWonStarCheckColumn(M5, 2, 4, 1).

testPrivateGamePlayerWonStarCheckDiagonal :-
	testPrivateDrawMatchGrid1(M),
	testPrivateWonPlayer(M2),
	testPrivateNotWon1(M3),
	testPrivateWonColumnNotWonOthers(M4),
	testPrivateWonDiagonal1(M5),
	testPrivateWonDiagonal2(M6),
	testPrivateWonDiagonal3(M7),
	not(privateGamePlayerWonStarCheckDiagonal(M, 3, 3, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M, 3, 3, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M, 4, 4, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M, 4, 4, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M2, 3, 4, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M2, 3, 4, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M3, 4, 1, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M3, 4, 1, 2)),
	not(privateGamePlayerWonStarCheckDiagonal(M4, 4, 4, 1)),
	not(privateGamePlayerWonStarCheckDiagonal(M4, 4, 4, 2)),
	privateGamePlayerWonStarCheckDiagonal(M5, 3, 4, 1),
	privateGamePlayerWonStarCheckDiagonal(M5, 4, 3, 1),
	privateGamePlayerWonStarCheckDiagonal(M6, 4, 3, 1),
	privateGamePlayerWonStarCheckDiagonal(M6, 5, 4, 1),
	privateGamePlayerWonStarCheckDiagonal(M7, 1, 4, 1),
	privateGamePlayerWonStarCheckDiagonal(M7, 7, 4, 1).

testPrivateGamePlayerWonStarCheckLine :-
	testPrivateDrawMatchGrid1(M),
	testPrivateNotWon1(M3),
	testPrivateWonColumnNotWonOthers(M4),
	testPrivateWonLine1(M5),
	testPrivateWonLine2(M6),
	not(privateGamePlayerWonStarCheckLine(M, 7, 1, 1)),
	not(privateGamePlayerWonStarCheckLine(M, 7, 1, 2)),
	not(privateGamePlayerWonStarCheckLine(M, 5, 1, 1)),
	not(privateGamePlayerWonStarCheckLine(M, 5, 1, 2)),
	not(privateGamePlayerWonStarCheckLine(M3, 4, 1, 1)),
	not(privateGamePlayerWonStarCheckLine(M3, 4, 1, 2)),
	not(privateGamePlayerWonStarCheckLine(M4, 5, 3, 1)),
	not(privateGamePlayerWonStarCheckLine(M4, 5, 3, 2)),
	privateGamePlayerWonStarCheckLine(M5, 2, 4, 1),
	not(privateGamePlayerWonStarCheckLine(M5, 2, 4, 2)),
	privateGamePlayerWonStarCheckLine(M5, 1, 4, 1),
	privateGamePlayerWonStarCheckLine(M5, 3, 4, 1),
	privateGamePlayerWonStarCheckLine(M5, 4, 4, 1),
	privateGamePlayerWonStarCheckLine(M6, 1, 2, 1),
	privateGamePlayerWonStarCheckLine(M6, 7, 2, 1).

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

testGameOver :-
	test(testGameOverDrawMatch),
	testPrivateFullGrid(M),
	testPrivateAlmostFullGrid(M2),
	testPrivateWonColumn1(M3),
	gameOver(M, 1, 2),
	gameOver(M, 2, 2),
	gameOver(M, 3, 2),
	gameOver(M, 4, 2),
	gameOver(M2, 3, 1),
	not(gameOver(M2, 3, 2)),
	gameOver(M3, 2, 1).

testAllGameOver :-
    test(testGridIsFull),
	test(testPrivateGamePlayerWonStarCheckColumn),
	test(testPrivateGamePlayerWonStarCheckDiagonal),
	test(testPrivateGamePlayerWonStarCheckLine),
	test(testGameOver).
