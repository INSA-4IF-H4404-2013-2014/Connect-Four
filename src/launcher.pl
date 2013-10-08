:- [gameGrid].

iaTest1(_, 1).
iaTest2(_, 2).

gameOver(Grid, Result) :- gameGridGet(Grid, Result, 4, Result).


launch(Player1, Player2, Result) :- write('Debut'), gameNewGrid(Grid), launch(Grid, Player1, Player2, Result, 1).

% Launch the game with Player1 and Player2 as predicate names.
% Result is the ID of the winning player or 0 if no player wins.

% Check for the first time if the game is over
launch(Grid, Player1, Player2, Result, _) :- write('Game over ?'), gameOver(Grid, Result).

% Let the Player1 play, check if the game is over, if not, let the Player2 play and makes a new call to launch
launch(Grid, Player1, Player2, Result, 1) :- 
	write('1'),
	call(Player1(Grid), NumCol),
	gamePlay(Grid, NumCol, 1, ResGrid),
	launch(ResGrid, Player1, Player2, Result, 2).
	
launch(Grid, Player1, Player2, Result, 2) :- 
	write('2'),
	call(Player2(Grid), NumCol),
	gamePlay(Grid, NumCol, 2, ResGrid),
	launch(ResGrid, Player1, Player2, Result, 1).
