:- [gameCore].
:- [gameOver].

% Survival predicat
% Return true if one player can block the other
% Test if 3 enemy's pawns are aligned, and try to play
% Player is playing, we test if OtherPlayer can win next turn


gameOtherCanWin(Grid, Player, Column) :-
	gameOtherPlayer(Player, OtherPlayer),
	(gameIsValidePlay(Grid, Column) ->
	(	
		gamePlay(Grid, Column, OtherPlayer, GridResult),
		gameOver(GridResult, Column, OtherPlayer)
	)).

gameSurvive(_, _, [], 0).

gameSurvive(Grid, Player, ListColumns, Pos) :- 
	not(gameOtherCanWin(Grid, Player, Pos)),
	NextColumn is Pos - 1,
	gameSurvive(Grid, Player, ListColumns, NextColumn).

gameSurvive(Grid, Player, [Pos|ListColumns], Pos) :- 
	gameOtherCanWin(Grid, Player, Pos),
	NextColumn is Pos - 1,
	gameSurvive(Grid, Player, ListColumns, NextColumn).
	
gameSurvive(Grid, Player, ListColumns) :-
	columnsNumber(ColNum),
	gameSurvive(Grid, Player, ListColumns, ColNum) ->
	(
		length(ListColumns, Length),
		Length > 0
	).
