
:- [testUtils].
:- [aiSchemaProcessing].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiPrivateCaseGridIsWining([
    [],
    [1],
    [1,1,2],
    [2,2,1,2],
    [1,2,1],
    [1,2],
    [2,1,1]
]).

testAiPrivateCaseGridIsWiningSchemaAbs([
    [2, 1, 1],
    [3, 2, 1],
    [4, 3, 1],
    [5, 3, 1],
    [5, 4, 0],
    [6, 3, 0],
    [7, 3, 1]
]).

testAiPrivateCaseGridIsWiningSchema([
    [0, 0, 1],
    [1, 1, 1],
    [2, 2, 1],
    [3, 2, 1],
    [3, 3, 0],
    [4, 2, 0],
    [5, 2, 1]
]).

testAiPrivateCaseGridIsWiningSchemaFliped([
    [0, 2, 1],
    [1, 2, 0],
    [2, 2, 1],
    [2, 3, 0],
    [3, 2, 1],
    [4, 1, 1],
    [5, 0, 1]
]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiSchemaCreate :-
    testAiPrivateCaseGridIsWining(R),
    aiSchemaCreate(R, [5,6], [[5,4,0],[6,3,0]]).

testAiSchemaInsertPawn :-
    aiSchemaInsertPawn([], 3, 2, [[3, 2, 1]]),
    aiSchemaInsertPawn([[3, 2, 1]], 3, 2, [[3, 2, 1]]),
    aiSchemaInsertPawn([[3, 2, 0]], 3, 2, [[3, 2, 0]]),
    aiSchemaInsertPawn([[3, 2, 1]], 2, 2, [[2, 2, 1], [3, 2, 1]]),
    not(aiSchemaInsertPawn([[3, 2, 1]], 3, 2, [[3, 2, 1], [3, 2, 1]])).

testAiSchemaPopulate :-
    testAiPrivateCaseGridIsWining(G0),
    testAiPrivateCaseGridIsWiningSchemaAbs(S0),
    aiSchemaPopulate(G0, [5,6], 1, S0).

testAiSchemaMinimalCoordinate :-
    aiSchemaMinimalCoordinate([[3, 5, 1], [4, 2, 0]], 1, 3),
    aiSchemaMinimalCoordinate([[3, 5, 1], [4, 2, 0]], 2, 2).

testAiSchemaMaximalCoordinate :-
    aiSchemaMaximalCoordinate([[3, 5, 1], [4, 2, 0]], 1, 4),
    aiSchemaMaximalCoordinate([[3, 5, 1], [4, 2, 0]], 2, 5).

testAiSchemaPrune :-
    testAiPrivateCaseGridIsWiningSchemaAbs(S0),
    testAiPrivateCaseGridIsWiningSchema(S1),
    aiSchemaPrune(S0, S1),
    aiSchemaPrune(S1, S1),
    not(aiSchemaPrune(S0, S0)).

testAiSchemaHorizontalFlip :-
    testAiPrivateCaseGridIsWiningSchema(S0),
    testAiPrivateCaseGridIsWiningSchemaFliped(S1),
    aiSchemaHorizontalFlip(S0, S1),
    aiSchemaHorizontalFlip(S0, S2),
    aiSchemaHorizontalFlip(S2, S0).

testAiSchemaExtraction :-
    testAiPrivateCaseGridIsWining(G0),
    testAiPrivateCaseGridIsWiningSchema(S1),
    aiSchemaExtraction(G0, [5,6], 1, S1).

testAllAiSchemaProcessing :-
    test(testAiSchemaCreate),
    test(testAiSchemaInsertPawn),
    test(testAiSchemaPopulate),
    test(testAiSchemaMinimalCoordinate),
    test(testAiSchemaMaximalCoordinate),
    test(testAiSchemaPrune),
    test(testAiSchemaHorizontalFlip),
    test(testAiSchemaExtraction).
