
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameLauncher].
:- [testPlayerRandom].
:- [testIaInferenceSchema].
:- [testIaSchemaProcessing].
:- [testIaInferenceCleverMove].
:- [testIaInferenceDatabase].
:- [testStatsPlayer].
:- [testSurvival].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameLauncher,
	testAllPlayerRandom,
    testAllIaInferenceSchema,
    testAllIaSchemaProcessing,
    testAllIaInferenceCleverMove,
    testAllIaInferenceDatabase,
	testAllStatsPlayer,
	testAllSurvival.
