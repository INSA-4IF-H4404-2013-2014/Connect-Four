
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].
:- [testIaRandom].
:- [testIaInferenceSchema].
:- [testIaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllLauncher,
	testAllIaRandom,
    testAllIaInferenceSchema,
    testAllIaInferenceDatabase.
