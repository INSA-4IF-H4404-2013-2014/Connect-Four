
:- [testUtils].
:- [aiKnowledgePopulate].
:- [playerRandom].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiPlayer :-
    aiInferenceResetDatabase,
    iaPopulateKnowledge(playerRandom, 10),
    aiInferenceResetDatabase.

testAllAiPlayer :-
    test(testAiPlayer).
