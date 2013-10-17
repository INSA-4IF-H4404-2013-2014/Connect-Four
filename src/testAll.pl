
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameLauncher].
:- [testGameSmart].
:- [testPlayerRandom].
:- [testIaInferenceSchema].
:- [testIaSchemaProcessing].
:- [testIaInferenceCleverMove].
:- [testIaInferenceDatabase].
:- [testStatsPlayer].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameLauncher,
	testAllGameSmart,
	testAllPlayerRandom,
    testAllIaInferenceSchema,
    testAllIaSchemaProcessing,
    testAllIaInferenceCleverMove,
    testAllIaInferenceDatabase,
	testAllStatsPlayer.
