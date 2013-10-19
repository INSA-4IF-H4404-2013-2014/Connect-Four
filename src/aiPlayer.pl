
:- [gameSmart].
:- [playerRandom].
:- [aiSchemaMatching].
:- [aiSchemaSmartMove].
:- [aiKnowledge].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

aiPlayer(Grid, PlayerId, ColumnId) :-
    gameWinningMoves(Grid, PlayerId, ObviousMove)
    -> (
        [ColumnId|_] = ObviousMove
    );
    gameSurviveMoves(Grid, PlayerId, SurviveMoves)
    -> (
        (SurviveMoves > 1)
        -> (
            % we failed => we have to learn why
            aiKnowledgeLearn(Grid, SurviveMoves, PlayerId),
            SurviveMoves = [ColumnId|_]
        ); (
            SurviveMoves = [ColumnId]
        )
    );
    aiKnowledgeNearestSchema(Grid, PlayerId, Schema, PosX, PosY, _)
    -> (
        aiSchemaSmartMove(Grid, PlayerId, Schema, PosX, PosY, ColumnId, _)
    ); (
        playerRandom(Grid, PlayerId, ColumnId)
    ).
