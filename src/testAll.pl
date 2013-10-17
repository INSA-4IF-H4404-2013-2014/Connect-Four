
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameLauncher].
:- [testPlayerRandom].
:- [testIaInferenceSchema].
:- [testIaInferenceCleverMove].
:- [testIaInferenceDatabase].
:- [testStatsPlayer].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameLauncher,
	testAllPlayerRandom,
    testAllIaInferenceSchema,
    testAllIaInferenceCleverMove,
    testAllIaInferenceDatabase,
	testAllStatsPlayer.
