
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].
:- [testIaRandom].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS



testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllLauncher,
	testAllIaRandom.
