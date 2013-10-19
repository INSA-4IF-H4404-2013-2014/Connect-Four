
:- [gameCore].
:- [gameOver].
:- [traceUtils].


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

gameProcess(Player1, Player2, Result, FinishGrid) :-
	gameNewGrid(Grid), 
	privateGameProcess(Grid, 1, Player1, Player2, FinishGrid, Result),
    !.


% ==============================================================================
% gameProcess(Player1, Player2, Result)
% -------------------------------------
% <Player1> and <Player2> are the two AIs names (See gameProcess/4)
% <Result> is the ID of the winner (0 if draw)
% ==============================================================================

gameProcess(Player1, Player2, Result) :-
    gameProcess(Player1, Player2, Result, _).


% ====================================================================== PRIVATE

privateGameProcess(Grid, PlayerId, Player, OtherPlayer, FinishGrid, Result) :-
    call(Player, Grid, PlayerId, ColumnId) ->
    (
        not(gameIsValidePlay(Grid, ColumnId)) -> ( % invalide play => abandon
            debugWrite(game, [Player, ' has returned an invalide column id\n']),
            FinishGrid = Grid,
            gameOtherPlayer(PlayerId, Result)
        );
        gamePlay(Grid, ColumnId, PlayerId, NewGrid),
        (
            debugWrite(game, [Player, ' has played column ', ColumnId, '\n']),
            gameOver(NewGrid, ColumnId, OverResult) -> (
                FinishGrid = Grid,
                Result = OverResult
            );
            (
                gameOtherPlayer(PlayerId, OtherPlayerId),
                privateGameProcess(NewGrid, OtherPlayerId, OtherPlayer, Player, FinishGrid, Result)
            )
        )
    );
    ( % Player has failed => abandon
        debugWrite(game, [Player, ' has failed']),
        FinishGrid = Grid,
        gameOtherPlayer(PlayerId, Result)
    ).
