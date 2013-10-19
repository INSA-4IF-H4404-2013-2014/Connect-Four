:- [testGridCases].
:- [testUtils].
:- [aiSchemaSmartMove].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST CASES

%privateAiSchemaSmartMove(_, _, [_,_,0], _, _, SubColumnId, MetaDistance, SubColumnId, MetaDistance).

testPrivateAiSchemaSmartMove0 :-
    gameNewGrid(G),
    privateAiSchemaSmartMove(G, 1, [0, 1, 0], 3, 2, 1, 2, 1, 2),
    not(privateAiSchemaSmartMove(G, 1, [0, 1, 0], 3, 2, 1, 2, 1, 4)),
    not(privateAiSchemaSmartMove(G, 2, [2, 3, 0], 3, 2, 1, 2, 3, 2)).

testPrivateAiSchemaSmartMove1 :-
    gameNewGrid(G),
    privateAiSchemaSmartMove(G, 1, [1, 0, 1], 1, 1, 1, 4, 2, 1),
    privateAiSchemaSmartMove(G, 1, [1, 0, 1], 1, 1, 4, 1, 4, 1).

testAiInferenceCleverMove :-
    gameNewGrid(G),
    testGridCaseEasySchema(S1),
    aiSchemaSmartMove(G, 1, S1, 1, 1, 4, 1).

testAllAiSchemaSmartMove :-
    test(testPrivateAiSchemaSmartMove0),
    test(testPrivateAiSchemaSmartMove1),
    test(testAiInferenceCleverMove).
