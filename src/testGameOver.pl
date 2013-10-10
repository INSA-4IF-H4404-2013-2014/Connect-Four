
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
	
testGridIsFull :-
    testPrivateFullGrid(X),
    testPrivateAlmostFullGrid(Y),
    gameGridIsFull(X),
    not(gameGridIsFull(Y)),
    not(gameGridIsFull([[], [], [], [], [], [], []])).

testPrivateGamePlayerWonStarCheckColumn :-
	testPrivateDrawMatchGrid2(M),
	linesNumber(LN),
	not(privateGamePlayerWonStarCheckColumn(M, 2, LN, LN, 1)),
	testPrivateWonPlayer(M2),
	privateGamePlayerWonStarCheckColumn(M2, 1, 5, 5, 1).

testGameOver :-
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
	test(testGameOver).
