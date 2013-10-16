
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].
:- [testIaRandom].
:- [testIaInferenceSchema].
:- [testIaInferenceCleverMove].
:- [testIaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllLauncher,
	testAllIaRandom,
    testAllIaInferenceSchema,
    testAllIaInferenceCleverMove,
    testAllIaInferenceDatabase.
