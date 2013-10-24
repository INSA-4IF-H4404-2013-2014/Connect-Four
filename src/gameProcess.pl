
:- [gameCore].
:- [gameOver].
:- [uiPlayer].
:- [traceUtils].
:- [gamePrint].


% ==============================================================================
% gameProcess(Player1, Player2, Result, FinishGrid)
% -------------------------------------------------
% <Player1> and <Player2> are the two AIs names
%     a <Player> has the form of player(Grid, PlayerId, ColumnId) where :
%         <Grid> is the current grid
%         <PlayerId> is the number of the player (1 or 2)
%         <ColumnId> is the number of column where the player wants to play next
% <Result> is the ID of the winner (0 if draw)
% <FinishGrid> is the grid at the end of the match
% ==============================================================================

gameProcess(Player1, Player2, Result, FinishGrid, LastColumnPlayed) :-
    gameNewGrid(Grid),
    (
        (
            ( (Player1 = uiPlayer) ; (Player2 = uiPlayer) ) ->
                privateGameProcess(Grid, 1, Player1, Player2, FinishGrid, 1, 0, LastColumnPlayed, Result)
        ) ;
        privateGameProcess(Grid, 1, Player1, Player2, FinishGrid, 0, 0, LastColumnPlayed, Result)
    ),
    !.



% ==============================================================================
% gameProcess(Player1, Player2, Result)
% -------------------------------------
% <Player1> and <Player2> are the two AIs names (See gameProcess/4)
% <Result> is the ID of the winner (0 if draw)
% ==============================================================================

gameProcess(Player1, Player2, Result, FinishGrid) :-
    gameProcess(Player1, Player2, Result, FinishGrid, _).

gameProcess(Player1, Player2, Result) :-
    gameProcess(Player1, Player2, Result, _, _).


% ====================================================================== PRIVATE
privateGameProcess(Grid, PlayerId, Player, OtherPlayer, FinishGrid, Print, LastColumnPlayed, FinalLastColumnPlayed, Result) :-
	(
		(Print == 1) ->
		(
			gamePrintGrid(Grid, LastColumnPlayed),
			write('\n')
		) ; true
	),
	(
		call(Player, Grid, PlayerId, ColumnId) ->
		(
			not(gameIsValidePlay(Grid, ColumnId)) -> ( % invalide play => abandon
				debugWrite(game, [Player, ' has returned an invalid column id\n']),
				FinishGrid = Grid,
				gameOtherPlayer(PlayerId, Result)
			);
			gamePlay(Grid, ColumnId, PlayerId, NewGrid),
			(
				(
					((Print == 1), not(Player = uiPlayer)) ->
						(
							uiColors(Colored),
							gamePrintSymbols(Colored, PlayerId, Symb),
							write('---player--- ('),
							write(Symb),
							write(') just played into column '),
							write(ColumnId),
							write('\n')
						)
					; true
				),
				gameOver(NewGrid, ColumnId, OverResult) -> (
					FinalLastColumnPlayed is ColumnId,
					FinishGrid = NewGrid,
					Result = OverResult
				);
				(
					gameOtherPlayer(PlayerId, OtherPlayerId),
					privateGameProcess(NewGrid, OtherPlayerId, OtherPlayer, Player, FinishGrid, Print, ColumnId, FinalLastColumnPlayed, Result)
				)
			)
		);
		( % Player has failed => abandon
			debugWrite(game, [Player, ' has failed']),
			FinishGrid = Grid,
			gameOtherPlayer(PlayerId, Result)
		)
	).
