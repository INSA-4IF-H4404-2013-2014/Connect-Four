:- [testUtils].
:- [statsPlayer].

testStatsPlayer :-
	statsPlayer(20,0).

testAllStatsPlayer :-
    test(testStatsPlayer).
