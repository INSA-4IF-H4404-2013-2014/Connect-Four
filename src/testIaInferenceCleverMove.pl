:- [testGridCases].
:- [testUtils].
:- [iaInferenceCleverMove].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST CASES

testIsInferenceCleverMove :-
    gameNewGrid(G),
    testGridCaseEasySchema(S1),
    isInferenceCleverMove(G, 1, S1, 1, 1, 4, 1).

testAllIaInferenceCleverMove :-
    test(testIsInferenceCleverMove).
