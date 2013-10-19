:- [testGridCases].
:- [testUtils].
:- [aiKnowledge].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiKnowledgeNearestSchema :-
    gameNewGrid(G0),
    gamePlay(G0, 1, 2, G1),
    gamePlay(G1, 4, 2, G2),
    aiKnowledgeNearestSchema(G0, 1, _, _, _, 3),
    aiKnowledgeNearestSchema(G1, 1, _, _, _, 3),
    aiKnowledgeNearestSchema(G2, 1, _, _, _, 6).

testAllAiKnowledge :-
    test(testAiKnowledgeNearestSchema).
