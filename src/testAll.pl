
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameProcess].
:- [testPlayerRandom].
:- [testIaInferenceSchema].
:- [testIaSchemaProcessing].
:- [testIaInferenceCleverMove].
:- [testIaInferenceDatabase].
:- [testStatsPlayer].
:- [testGameSurvival].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameProcess,
	testAllGameSurvival,
	testAllPlayerRandom,
    testAllIaInferenceSchema,
    testAllIaSchemaProcessing,
    testAllIaInferenceCleverMove,
    testAllIaInferenceDatabase,
	testAllStatsPlayer.
