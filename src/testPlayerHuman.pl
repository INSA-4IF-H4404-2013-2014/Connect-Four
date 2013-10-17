:- [traceUtils].
:- [gameLauncher].
:- [playerUser].


testOneUser :- launch(playerTest1, playerUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).

testTwoUser :- launch(playerUser, playerUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).

testReVSRa :- launch(playerRandom, playerUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).
