% Launch the game with Player1 and Player2 as predicate names.
% Result is the ID of the winning player or 0 if no player wins.

launch(Player1, Player2, Result) :- 
	\gameOver(Result), call(Player1), \gameOver(Result), call(Player2), launch(Player1, Player2, Result).
