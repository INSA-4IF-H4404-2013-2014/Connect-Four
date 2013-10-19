
:- [gameSmart].
:- [playerRandom].
:- [aiKnowledge].
:- [aiSmart].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

aiPlayer(Grid, PlayerId, ColumnId) :-
    gameWinningMoves(Grid, PlayerId, ObviousMove)
    -> (
        [ColumnId|_] = ObviousMove
    );
    gameSurviveMoves(Grid, PlayerId, SurviveMoves)
    -> (
        (
            length(SurviveMoves, SurviveMoveCount),
            SurviveMoveCount > 1
        ) -> (
            % we failed => we have to learn why
            gameOtherPlayer(PlayerId, OtherPlayerId),
            aiKnowledgeLearn(Grid, SurviveMoves, OtherPlayerId),
            SurviveMoves = [ColumnId|_]
        ); (
            SurviveMoves = [ColumnId]
        )
    );
    aiSmartMove(Grid, PlayerId, ColumnId)
    -> (
        true
    ); (
        playerRandom(Grid, PlayerId, ColumnId)
    ).
