:- [testGridCases].
:- [testUtils].
:- [aiSchemaSmartMove].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST CASES

%privateIaInferenceCleverMove(_, _, [_,_,0], _, _, SubColumnId, MetaDistance, SubColumnId, MetaDistance).

testPrivateIaInferenceCleverMove0 :-
    gameNewGrid(G),
    privateIaInferenceCleverMove(G, 1, [0, 1, 0], 3, 2, 1, 2, 1, 2),
    not(privateIaInferenceCleverMove(G, 1, [0, 1, 0], 3, 2, 1, 2, 1, 4)),
    not(privateIaInferenceCleverMove(G, 2, [2, 3, 0], 3, 2, 1, 2, 3, 2)).

testPrivateIaInferenceCleverMove1 :-
    gameNewGrid(G),
    privateIaInferenceCleverMove(G, 1, [1, 0, 1], 1, 1, 1, 4, 2, 1),
    privateIaInferenceCleverMove(G, 1, [1, 0, 1], 1, 1, 4, 1, 4, 1).

testIsInferenceCleverMove :-
    gameNewGrid(G),
    testGridCaseEasySchema(S1),
    isInferenceCleverMove(G, 1, S1, 1, 1, 4, 1).

testAllAiSchemaSmartMove :-
    test(testPrivateIaInferenceCleverMove0),
    test(testPrivateIaInferenceCleverMove1),
    test(testIsInferenceCleverMove).
