
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameProcess].
:- [testGameSmart].
:- [testPlayerRandom].
:- [testAiSchemaMatching].
:- [testAiSchemaProcessing].
:- [testAiSchemaSmartMove].
:- [testAiKnowledge].
:- [testStatsPlayer].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameProcess,
	testAllGameSmart,
	testAllPlayerRandom,
    testAllAiSchemaMatching,
    testAllAiSchemaProcessing,
    testAllAiSchemaSmartMove,
    testAllAiKnowledge,
	testAllStatsPlayer.
