
:- [gameProcess].

%%%%%%%%%%%%
% Test datas
%%%%%%%%%%%%s
playerTest1(_, _, 1).
playerTest2(_, _, 2).
playerTest4(_, _, 4).
%%%%%%%%%%%%


testSimpleGame :- gameProcess(playerTest1, playerTest2, 1).

testSimpleGameInv :- gameProcess(playerTest2, playerTest1, 1).

testSamePlayerInfinite :- not(gameProcess(playerTest4, playerTest4, _)).

testAllGameProcess :-
	test(testSimpleGame),
	test(testSimpleGameInv),
	test(testSamePlayerInfinite).
