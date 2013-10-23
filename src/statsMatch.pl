:- [gameProcess].

statsMatch(_, _, 0).

statsMatch(Player1, Player2, NumberCall) :- 
	gameProcess(Player1, Player2, Result),
	write(Result),
	write('\n'),
	NumberCall2 is NumberCall - 1,  
	statsMatch(Player1, Player2, NumberCall2).
