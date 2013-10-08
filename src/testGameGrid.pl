
?- consult(gameGrid).


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
    gameGridGet(R2, 1, 2, 23).
