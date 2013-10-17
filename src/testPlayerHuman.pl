:- [traceUtils].
:- [gameProcess].
:- [playerUser].


testOneUser :- gameProcess(playerTest1, playerUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).

testTwoUser :- gameProcess(playerUser, playerUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).

testReVSRa :- gameProcess(playerRandom, playerUser, R),
	writeTrace(game,"R ="),
	writeTrace(game, R).
