% Launch the game with Player1 and Player2 as predicate names.
% Result is the ID of the winning player or 0 if no player wins.

% Check for the first time if the game is over
launch(Player1, Player2, Result) :- gameOver(Result).

% Let the Player1 play, check if the game is over, if not, let the Player2 play and makes a new call to launch
launch(Player1, Player2, Result) :- 
	call(Player1), not(gameOver(Result)), call(Player2), launch(Player1, Player2, Result).
	
% Get the Result of the game once Player1 finished the game (otherwise, we would just get a false statement)
launch(Player1, Player2, Result) :- gameOver(Result).