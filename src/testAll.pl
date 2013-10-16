
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testGameLauncher].
:- [testIaRandom].
:- [testIaInferenceSchema].
:- [testIaInferenceCleverMove].
:- [testIaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllGameLauncher,
	testAllIaRandom,
    testAllIaInferenceSchema,
    testAllIaInferenceCleverMove,
    testAllIaInferenceDatabase.
