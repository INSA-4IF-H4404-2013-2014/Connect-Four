
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
	
testGridIsFull :-
    testPrivateFullGrid(X),
    testPrivateAlmostFullGrid(Y),
    gameGridIsFull(X),
    not(gameGridIsFull(Y)),
    not(gameGridIsFull([[], [], [], [], [], [], []])).

testGameOver :- 
	testPrivateDrawMatchGrid1(M),
	gameOver(M, 1, 0),
	gameOver(M, 2, 0),
	gameOver(M, 3, 0),
	gameOver(M, 4, 0),
	gameOver(M, 5, 0),
	gameOver(M, 6, 0),
	gameOver(M, 7, 0),
	not(gameOver(M, 45, 0)).
	
testAllGameOver :-
    test(testGridIsFull),
	test(testGameOver).
