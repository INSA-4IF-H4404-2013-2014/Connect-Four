
:- [gameOver].


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POPULATE SCHEMA
% Insert al aligned pawn in the schema
% iaSchemaPopulate(Grid, KillerMoves, PlayerId, RSchema)

privateIaSchemaPopulateByY(_, _, Schema, Schema, _, 0).

privateIaSchemaPopulateByY(Grid, PlayerId, Schema, RSchema, X, Y) :-
    Y1 is Y - 1,
    (
        (
            gameGridGet(Grid, X, Y, PlayerId),
            gameIsAligned(Grid, X, Y, PlayerId)
        ) -> (
            iaSchemaInsertPawn(Schema, X, Y, NewSchema)
        ) ; (
            Schema = NewSchema
        )
    ),
    privateIaSchemaPopulateByY(Grid, PlayerId, NewSchema, RSchema, X, Y1).


privateIaSchemaPopulateByX(_, _, Schema, Schema, 0).

privateIaSchemaPopulateByX(Grid, PlayerId, Schema, RSchema, X) :-
    X1 is X - 1,
    linesNumber(LineCount),
    privateIaSchemaPopulateByY(Grid, PlayerId, Schema, NewSchema, X, LineCount),
    privateIaSchemaPopulateByX(Grid, PlayerId, NewSchema, RSchema, X1).


iaSchemaPopulate(Grid, KillerMoves, PlayerId, SortedSchema) :-
    (
        gamePlaySequence(Grid, KillerMoves, PlayerId, DominationGrid),
        iaSchemaCreate(Grid, KillerMoves, NewSchema)
    ) -> (
        columnsNumber(ColumnCount),
        privateIaSchemaPopulateByX(DominationGrid, PlayerId, NewSchema, RSchema, ColumnCount)
    ),
    sort(RSchema, SortedSchema), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET MINIMAL COORDINATE
% get the minimal coordinate

iaSchemaMinimalCoordinate([], _, 0).

iaSchemaMinimalCoordinate([Element|Schema], CoordId, Value) :-
    listFetch(Element, CoordId, ComparedValue),
    iaSchemaMinimalCoordinate(Schema, CoordId, RValue),
    (
        (ComparedValue < RValue ; RValue == 0) ->
        (Value = ComparedValue);
        (Value = RValue)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRUNE SCHEMA
% prune a schema from absolute coordinates to relative coordinates

privateIaSchemaPrune([], [], _, _).

privateIaSchemaPrune([[AbsX, AbsY, MatchType]|Schema], [[X, Y, MatchType]|RSchema], MinX, MinY) :-
    X is AbsX - MinX,
    Y is AbsY - MinY,
    privateIaSchemaPrune(Schema, RSchema, MinX, MinY).

iaSchemaPrune(Schema, RSchema) :-
    iaSchemaMinimalCoordinate(Schema, 1, MinX),
    iaSchemaMinimalCoordinate(Schema, 2, MinY),
    privateIaSchemaPrune(Schema, RSchema, MinX, MinY).
