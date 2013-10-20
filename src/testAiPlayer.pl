
:- [testUtils].
:- [aiKnowledgePopulate].
:- [playerRandom].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiPlayer :-
    aiKnowledgeReset,
    iaPopulateKnowledge(playerRandom, 10),
    aiKnowledgeReset.

testAllAiPlayer :-
    test(testAiPlayer).
