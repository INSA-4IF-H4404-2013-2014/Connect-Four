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
		gamePrintGrid(GridResult),
		gameOver(GridResult, Column, OtherPlayer)
	)), !.

gameSurvive(Grid, Player, Column, 7) :- gameOtherCanWin(Grid, Player, 7), Column is 7.
gameSurvive(Grid, Player, Column, Pos) :- (gameOtherCanWin(Grid, Player, Pos), Column is Pos) ; (NextColumn is Pos +1, gameSurvive(Grid, Player, Column, NextColumn)).
gameSurvive(Grid, Player, Column) :- gameSurvive(Grid, Player, Column, 1), !.
