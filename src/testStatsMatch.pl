:- [statsMatch].
:- [testUtils].
:- [playerRandom].
:- [aiPlayer].
:- [aiKnowledgeIO].
:- [aiKnowledgePopulate].

testStatsRandom :- statsMatch(playerRandom, playerRandom, 3).
testStatsRandomSmart :- statsMatch(playerRandomSmart, playerRandomSmart, 5).
testStatsBoth  :- statsMatch(playerRandom, playerRandomSmart, 10).

testAllStatsMatch :-
	test(testStatsRandom),
	test(testStatsRandomSmart),
	test(testStatsBoth).