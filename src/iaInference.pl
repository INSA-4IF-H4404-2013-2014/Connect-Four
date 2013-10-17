
:- [playerRandom].
:- [iaInferenceSchema].
:- [iaInferenceCleverMove].
:- [iaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

iaInference(Grid, PlayerId, ColumnId) :-
    iaInferenceConsultDatabase(Grid, PlayerId, Schema, PosX, PosY, _)
    ->
    (
        isInferenceCleverMove(Grid, PlayerId, Schema, PosX, PosY, ColumnId, _)
    ); (
        playerRandom(Grid, PlayerId, ColumnId)
    ).
