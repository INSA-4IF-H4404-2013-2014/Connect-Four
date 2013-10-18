
:- [gameSmart].
:- [playerRandom].
:- [aiSchemaMatching].
:- [aiSchemaSmartMove].
:- [aiKnowledge].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

iaInference(Grid, PlayerId, ColumnId) :-
    gameWinningMoves(Grid, PlayerId, ObviousMove)
    -> (
        [ColumnId|_] = ObviousMove
    );
    gameSurviveMoves(Grid, PlayerId, SurviveMoves)
    -> (
        (SurviveMoves > 1)
        -> (
            % we failed => we have to understand why
            listFetch(SurviveMoves, 1, ColumnId)
        ); (
            listFetch(SurviveMoves, 1, ColumnId)
        )
    );
    iaInferenceConsultDatabase(Grid, PlayerId, Schema, PosX, PosY, _)
    -> (
        aiSchemaSmartMove(Grid, PlayerId, Schema, PosX, PosY, ColumnId, _)
    ); (
        playerRandom(Grid, PlayerId, ColumnId)
    ).
