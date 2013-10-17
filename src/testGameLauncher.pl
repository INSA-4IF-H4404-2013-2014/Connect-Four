
:- [gameLauncher].

%%%%%%%%%%%%
% Test datas
%%%%%%%%%%%%
playerTest1(_, _, 1).
playerTest2(_, _, 2).
playerTest4(_, _, 4).
%%%%%%%%%%%%


testSimpleGame :- launch(playerTest1, playerTest2, 1).

testSimpleGameInv :- launch(playerTest2, playerTest1, 1).

testSamePlayerInfinite :- not(launch(playerTest4, playerTest4, _)).

testAllGameLauncher :-
	test(testSimpleGame),
	test(testSimpleGameInv),
	test(testSamePlayerInfinite).
