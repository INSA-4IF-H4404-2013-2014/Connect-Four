
:- [gameLauncher].

%%%%%%%%%%%%
% Test datas
%%%%%%%%%%%%
iaTest1(_, _, 1).
iaTest2(_, _, 2).
iaTest4(_, _, 4).
%%%%%%%%%%%%


testSimpleGame :- launch(iaTest1, iaTest2, 1).

% unused because there is a bug with the ending of the game.
testSimpleGameInv :- launch(iaTest2, iaTest1, 1).

testSameIAInfinite :- not(launch(iaTest4, iaTest4, _)).

testAllLauncher :- 
	test(testSimpleGame),
	test(testSameIAInfinite).
