:- [testGridCases].
:- [testUtils].
:- [aiSchemaMatching].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST CASES

testPrivateIaInferenceWonPlayer([
    [2,1,1,1,1],
    [2,1,1,2,2],
    [2,2,2,1,1],
    [1,1,1,2,2,2],
    [2,2,2,1,1],
    [1,1,1,2,2,2],
    [2,2,2,1,1,1]
]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testPrivateAiSchemaElementDistance0 :-
    testCaseGridPlayer1Win1(G1),
    privateAiSchemaElementDistance(G1, _, 1, 1, 0, 0),
    privateAiSchemaElementDistance(G1, _, 2, 2, 0, 0),
    privateAiSchemaElementDistance(G1, _, 2, 3, 0, 1),
    privateAiSchemaElementDistance(G1, _, 7, 2, 0, -2),
    privateAiSchemaElementDistance(G1, _, 7, 3, 0, -1).

testPrivateAiSchemaElementDistance1 :-
    testCaseGridPlayer1Win1(G1),
    privateAiSchemaElementDistance(G1, 1, 2, 1, 1, 0),
    privateAiSchemaElementDistance(G1, 2, 2, 1, 1, -1),
    privateAiSchemaElementDistance(G1, 1, 2, 2, 1, 1).

testPrivateAiSchemaDistance :-
    gameNewGrid(G1),
    testGridCaseEasy(G2),
    testGridCaseEasySchema(S1),
    privateAiSchemaDistance(G1, 1, 1, 1, S1, 3),
    privateAiSchemaDistance(G1, 1, 3, 1, S1, 3),
    privateAiSchemaDistance(G1, 1, 2, 2, S1, 8),
    privateAiSchemaDistance(G2, 1, 2, 1, S1, 0),
    not(privateAiSchemaDistance(G1, 1, 4, 1, S1, _)),
    not(privateAiSchemaDistance(G1, 1, 5, 1, S1, _)),
    not(privateAiSchemaDistance(G1, 1, 6, 1, S1, _)),
    not(privateAiSchemaDistance(G1, 1, 7, 1, S1, _)).

testPrivateAiSchemaNearestPos :-
    privateAiSchemaNearestPos([1,0,3], [2,0,2], [2,0,2]),
    privateAiSchemaNearestPos([1,0,-1], [2,0,2], [2,0,2]),
    privateAiSchemaNearestPos([1,0,3], [2,0,-1], [1,0,3]).

testAiSchemaDistance :-
    testGridCaseEasy(G1),
    gamePlay(G1, 2, 2, G2),
    testPrivateIaInferenceWonPlayer(G3),
    testGridCaseEasySchema(S1),
    aiSchemaDistance(G1, 1, S1, [2, 1, 0]),
    aiSchemaDistance(G2, 1, S1, [1, 2, 4]),
    not(aiSchemaDistance(G3, 1, S1, _)).

testAllAiSchemaMatching :-
    test(testPrivateAiSchemaElementDistance0),
    test(testPrivateAiSchemaElementDistance1),
    test(testPrivateAiSchemaDistance),
    test(testAiSchemaDistance).
