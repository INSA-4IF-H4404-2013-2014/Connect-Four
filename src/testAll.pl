
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS



testAll :-
    testAllGameCore,
    testAllGameOver,
    testAllLauncher.
