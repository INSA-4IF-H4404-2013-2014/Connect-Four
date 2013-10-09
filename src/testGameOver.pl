
:- [testUtil].
:- [gameOver].


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

testGridIsFull :-
    testPrivateFullGrid(X),
    testPrivateAlmostFullGrid(Y),
    gameGridIsFull(X),
    not(gameGridIsFull(Y)),
    not(gameGridIsFull([[], [], [], [], [], [], []])).

testAllGameOver :-
    test(testGridIsFull).
