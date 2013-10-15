:- [traceUtil].
:- [gameLauncher].
:- [iaUser].


testOneUser :- launch(iaTest1, iaUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).

testTwoUser :- launch(iaUser, iaUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).

testReVSRa :- launch(iaRandom, iaUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).
