
:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATE A SCHEMA FILLED WITH KILLER MOVES ONLY
% create a schema with only killers moves from a given <Grid> and killer moves
% iaSchemaCreate(Grid, KillerMoves, Schema).
iaSchemaCreate(_, [], []).
iaSchemaCreate(Grid, [X|KillerMoves], [[X,Y,0]|Schema]) :-
    iaSchemaCreate(Grid, KillerMoves, Schema),
    gameColumnHeight(Grid, X, ColumnHeight),
    Y is ColumnHeight + 1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INSERT A PAWN IN A SHEMA IF NOT ALREADY INSERTED

iaSchemaInsertPawn(Schema, X, Y, Schema) :-
    member([X, Y, _], Schema).

iaSchemaInsertPawn(Schema, X, Y, [[X, Y, 1]|Schema]) :-
    not(member([X, Y, _], Schema)).
