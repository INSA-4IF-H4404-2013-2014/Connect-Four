:- [testUtils].
:- [statsPlayer].

testStatsPlayer :-
	statsPlayer(5, 0).

testAllStatsPlayer :-
    test(testStatsPlayer).
