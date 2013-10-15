
:- [testGridCases].
:- [testUtil].
:- [iaInferenceSchema].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testPrivateIaInferenceSchemaElementDistance0 :-
    testCaseGridPlayer1Win1(G1),
    privateIaInferenceSchemaElementDistance(G1, _, 1, 1, 0, 0),
    privateIaInferenceSchemaElementDistance(G1, _, 2, 2, 0, 0),
    privateIaInferenceSchemaElementDistance(G1, _, 2, 3, 0, 1),
    privateIaInferenceSchemaElementDistance(G1, _, 7, 2, 0, -2),
    privateIaInferenceSchemaElementDistance(G1, _, 7, 3, 0, -1).

testPrivateIaInferenceSchemaElementDistance1 :-
    testCaseGridPlayer1Win1(G1),
    privateIaInferenceSchemaElementDistance(G1, 1, 2, 1, 1, 0),
    privateIaInferenceSchemaElementDistance(G1, 2, 2, 1, 1, -1),
    privateIaInferenceSchemaElementDistance(G1, 1, 2, 2, 1, 1).

testPrivateIaInferenceSchemaDistance :-
    gameNewGrid(G1),
    testGridCaseEasy(G2),
    testGridCaseEasySchema(S1),
    privateIaInferenceSchemaDistance(G1, 1, 1, 1, S1, 3),
    privateIaInferenceSchemaDistance(G1, 1, 3, 1, S1, 3),
    privateIaInferenceSchemaDistance(G1, 1, 2, 2, S1, 8),
    privateIaInferenceSchemaDistance(G2, 1, 2, 1, S1, 0),
    not(privateIaInferenceSchemaDistance(G1, 1, 4, 1, S1, _)),
    not(privateIaInferenceSchemaDistance(G1, 1, 5, 1, S1, _)),
    not(privateIaInferenceSchemaDistance(G1, 1, 6, 1, S1, _)),
    not(privateIaInferenceSchemaDistance(G1, 1, 7, 1, S1, _)).

testPrivateIaInferenceSchemaDistance :-
    testGridCaseEasy(G1),
    testGridCaseEasySchema(S1),
    iaInferenceSchemaDistance(G1, 1, S1, _).

testAllIaInferenceSchema :-
    test(testPrivateIaInferenceSchemaElementDistance0),
    test(testPrivateIaInferenceSchemaElementDistance1),
    test(testPrivateIaInferenceSchemaDistance).
