
:- [testUtils].
:- [iaSchemaProcessing].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testIaPrivateCaseGridIsWining([
    [],
    [1],
    [1,1,2],
    [2,2,1,2],
    [1,2,1],
    [1,2],
    [2,1,1]
]).

testIaPrivateCaseGridIsWiningSchema([
    [2, 1, 1],
    [3, 2, 1],
    [4, 3, 1],
    [5, 3, 1],
    [5, 4, 0],
    [6, 3, 0],
    [7, 3, 1]
]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testIaSchemaCreate :-
    testIaPrivateCaseGridIsWining(R),
    iaSchemaCreate(R, [5,6], [[5,4,0],[6,3,0]]).

testIaSchemaInsertPawn :-
    iaSchemaInsertPawn([], 3, 2, [[3, 2, 1]]),
    iaSchemaInsertPawn([[3, 2, 1]], 3, 2, [[3, 2, 1]]),
    iaSchemaInsertPawn([[3, 2, 0]], 3, 2, [[3, 2, 0]]),
    iaSchemaInsertPawn([[3, 2, 1]], 2, 2, [[2, 2, 1], [3, 2, 1]]),
    not(iaSchemaInsertPawn([[3, 2, 1]], 3, 2, [[3, 2, 1], [3, 2, 1]])).

testIaSchemaPopulate :-
    testIaPrivateCaseGridIsWining(G0),
    testIaPrivateCaseGridIsWiningSchema(S0),
    iaSchemaPopulate(G0, [5,6], 1, S0).

testAllIaSchemaProcessing :-
    test(testIaSchemaCreate),
    test(testIaSchemaInsertPawn),
    test(testIaSchemaPopulate).
