
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

testIaPrivateCaseGridIsWiningSchemaAbs([
    [2, 1, 1],
    [3, 2, 1],
    [4, 3, 1],
    [5, 3, 1],
    [5, 4, 0],
    [6, 3, 0],
    [7, 3, 1]
]).

testIaPrivateCaseGridIsWiningSchema([
    [0, 0, 1],
    [1, 1, 1],
    [2, 2, 1],
    [3, 2, 1],
    [3, 3, 0],
    [4, 2, 0],
    [5, 2, 1]
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
    testIaPrivateCaseGridIsWiningSchemaAbs(S0),
    iaSchemaPopulate(G0, [5,6], 1, S0).

testIaSchemaMinimalCoordinate :-
    iaSchemaMinimalCoordinate([[3, 5, 1], [4, 2, 0]], 1, 3),
    iaSchemaMinimalCoordinate([[3, 5, 1], [4, 2, 0]], 2, 2).

testIaSchemaPrune :-
    testIaPrivateCaseGridIsWiningSchemaAbs(S0),
    testIaPrivateCaseGridIsWiningSchema(S1),
    iaSchemaPrune(S0, S1),
    iaSchemaPrune(S1, S1),
    not(iaSchemaPrune(S0, S0)).

testIaSchemaExtraction :-
    testIaPrivateCaseGridIsWining(G0),
    testIaPrivateCaseGridIsWiningSchema(S1),
    iaSchemaExtraction(G0, [5,6], 1, S1).

testAllIaSchemaProcessing :-
    test(testIaSchemaCreate),
    test(testIaSchemaInsertPawn),
    test(testIaSchemaPopulate),
    test(testIaSchemaMinimalCoordinate),
    test(testIaSchemaPrune),
    test(testIaSchemaExtraction).
