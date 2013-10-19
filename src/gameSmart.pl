
:- [gameOver].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST IF CAN WIN BY PLAYING IN A COLUMN

gameCanWin(Grid, PlayerId, ColumnId) :-
    gameIsValidePlay(Grid, ColumnId) ->
    (
        gamePlay(Grid, ColumnId, PlayerId, GridResult),
        gameOver(GridResult, ColumnId, PlayerId)
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RETURN SURVIVAL MOVES TO DO IF NECESSARY
% Survival predicat
% Return true if one player can block the other
% Test if 3 enemy's pawns are aligned, and try to play
% Player is playing, we test if OtherPlayer can win next turn

gameWinningMoves(_, _, [], 0).

gameWinningMoves(Grid, PlayerId, ListColumns, Pos) :-
	not(gameCanWin(Grid, PlayerId, Pos)),
	NextColumn is Pos - 1,
	gameWinningMoves(Grid, PlayerId, ListColumns, NextColumn).

gameWinningMoves(Grid, PlayerId, [Pos|ListColumns], Pos) :-
	gameCanWin(Grid, PlayerId, Pos),
	NextColumn is Pos - 1,
	gameWinningMoves(Grid, PlayerId, ListColumns, NextColumn).
	
gameWinningMoves(Grid, PlayerId, ListColumns) :-
	columnsNumber(ColNum),
	gameWinningMoves(Grid, PlayerId, ListColumns, ColNum) ->
	(
		length(ListColumns, Length),
		Length > 0
	).


%%%%%%%%%%%%%%%%%%%%%%%%% RETURN A LIST OFS MOVE TO NOT LET THE OTHER PLAYER WIN

gameSurviveMoves(Grid, PlayerId, ListColumns) :-
    gameOtherPlayer(PlayerId, OtherPlayerId),
    gameWinningMoves(Grid, OtherPlayerId, ListColumns).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE AN OBVIOUS MOVE

gameObviousMove(Grid, PlayerId, ColumnId) :-
    gameWinningMoves(Grid, PlayerId, WinningMoves) ->
    (
        listFetch(WinningMoves, 1, ColumnId)
    ) ; (
        gameSurviveMoves(Grid, PlayerId, SurvieMoves) ->
        listFetch(SurvieMoves, 1, ColumnId)
    ), !.
