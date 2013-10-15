
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

testPrivateIaInferenceTestSchemaElement :-
    testCaseGridPlayer1Win1(G1),
    privateIaInferenceTestSchemaElement(G1, _, 1, 1, 0),
    not(privateIaInferenceTestSchemaElement(G1, _, 7, 2, 0)),
    privateIaInferenceTestSchemaElement(G1, 1, 2, 1, 1),
    not(privateIaInferenceTestSchemaElement(G1, 2, 2, 1, 1)).

testAllIaInferenceSchema :-
    test(testPrivateIaInferenceSchemaElementDistance0),
    test(testPrivateIaInferenceSchemaElementDistance1).
