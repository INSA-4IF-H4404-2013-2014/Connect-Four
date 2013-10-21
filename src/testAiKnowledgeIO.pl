:- [testGridCases].
:- [testUtils].
:- [aiKnowledge].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testAiKnowledgeLoad :-
    aiKnowledgeLoad('testAiKnowledgeLoad.ai', [[[1,2,3],[4,5,6]],[[7,8,9]]]).

testAiKnowledgeStore :-
    aiKnowledgeStore('testAiKnowledgeStore.ai.gitlocal', [[[1,2,3],[4,5,6]],[[7,8,9]]]),
    aiKnowledgeLoad('testAiKnowledgeStore.ai.gitlocal', [[[1,2,3],[4,5,6]],[[7,8,9]]]).

testAllAiKnowledgeIO :-
    test(testAiKnowledgeLoad),
    test(testAiKnowledgeStore).
