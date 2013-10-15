
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].
:- [testIaRandom].
:- [testSurvival].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS



testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllLauncher,
	testAllIaRandom.
