
:- [testUtils].
:- [aiSmart].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiSmartChoose :-
    aiSmartChoose(1, 1, 3, 1, 1, 2, 1, 1, 2),
    aiSmartChoose(0, 1, 3, 1, 1, 2, 0, 1, 3),
    aiSmartChoose(1, 2, 3, 1, 1, 3, 1, 2, 3).

testAllAiSmart :-
    test(testAiSmartChoose).
