
:- [main].
:- [testGameCore].
:- [testGameOver].
:- [testLauncher].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUNCH ALL UNIT TESTS

testAll :-
    testUtilBegin,
    testAllGameCore,
    testAllGameOver,
    testAllLauncher.
