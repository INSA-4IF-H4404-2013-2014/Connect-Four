:- [testUtils].
:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testListFetch :-
    not(listFetch([], 1, _)),
    not(listFetch([a,b,c], 7, _)),
    listFetch([a,b,c], 1, a),
    listFetch([a,b,c], 3, c).

testGameGridGet :-
    gameNewGrid(R),
    gamePlay(R, 1, 17, R1),
    gamePlay(R1, 1, 23, R2),
    not(gameGridGet(R, 1, 1, _)),
    gameGridGet(R1, 1, 1, 17),
    not(gameGridGet(R1, 3, 3, _)),
    gameGridGet(R2, 1, 1, 17),
    gameGridGet(R2, 1, 2, 23),
    not(gameGridGet(R1, 3, 0, _)).

testGameRemainingPlays :-
    gameNewGrid(R0),
    gamePlay(R0, 1, 1, R1),
    gamePlay(R1, 1, 1, R2),
    gamePlay(R2, 1, 1, R3),
    gamePlay(R3, 1, 1, R4),
    gamePlay(R4, 1, 1, R5),
    gamePlay(R5, 1, 1, R6),
    gameRemainingPlays(R5, [1,2,3,4,5,6,7]),
    gameRemainingPlays(R6, [2,3,4,5,6,7]).

testGameColunmHeight :-
    gameNewGrid(R0),
    gamePlay(R0, 1, 1, R1),
    gameColumnHeight(R0, 2, 0),
    gameColumnHeight(R0, 1, 0),
    gameColumnHeight(R1, 1, 1),
    not(gameColumnHeight(R1, 1, 0)),
    not(gameColumnHeight(R1, 1, 2)),
    not(gameColumnHeight(R1, 17, 1)).

testGameIsValidePlay :-
    gameNewGrid(R0),
    gamePlay(R0, 1, 1, R1),
    gamePlay(R1, 1, 1, R2),
    gamePlay(R2, 1, 1, R3),
    gamePlay(R3, 1, 1, R4),
    gamePlay(R4, 1, 1, R5),
    gamePlay(R5, 1, 1, R6),
    gameIsValidePlay(R5, 1),
    gameIsValidePlay(R5, 2),
    not(gameIsValidePlay(R6, 1)),
    gameIsValidePlay(R6, 2).

testGameReverseGrid :-
    gameReverseGrid([[], [1], [2,1,2]], [[], [2], [1,2,1]]).

testGamePlaySequence :-
    gameNewGrid(G0),
    gamePlaySequence(G0, [1, 1, 1], 1, [[1, 1, 1],[],[],[],[],[],[]]).

testAllGameCore :-
    test(testListFetch),
    test(testGameGridGet),
    test(testGameRemainingPlays),
    test(testGameColunmHeight),
    test(testGameIsValidePlay),
    test(testGameReverseGrid),
    test(testGamePlaySequence).
