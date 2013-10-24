
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameProcess].
:- [testGameSmart].
:- [testPlayerRandom].
:- [testAiSchemaMatching].
:- [testAiSchemaProcessing].
:- [testAiKnowledge].
:- [testAiKnowledgeIO].
:- [testAiSmart].
:- [testAiPlayer].
:- [testStatsPlayer].
:- [testStatsMatch].
:- [testPlayerTreeExplorer].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameProcess,
	testAllGameSmart,
	testAllPlayerRandom,
    testAllAiSchemaMatching,
    testAllAiSchemaProcessing,
    testAllAiKnowledge,
    testAllAiKnowledgeIO,
    testAllAiSmart,
    testAllAiPlayer,
	testAllStatsPlayer,
	testAllStatsMatch.
