
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].
:- [testIaRandom].
:- [testIaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllLauncher,
	testAllIaRandom,
    testAllIaInferenceDatabase.
