
:- [gameOver].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATE A SCHEMA FILLED WITH KILLER MOVES ONLY
% create a schema with only killers moves from a given <Grid> and killer moves
% aiSchemaCreate(Grid, KillerMoves, Schema).
aiSchemaCreate(_, [], []).
aiSchemaCreate(Grid, [X|KillerMoves], [[X,Y,0]|Schema]) :-
    aiSchemaCreate(Grid, KillerMoves, Schema),
    gameColumnHeight(Grid, X, ColumnHeight),
    Y is ColumnHeight + 1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INSERT A PAWN IN A SHEMA IF NOT ALREADY INSERTED

aiSchemaInsertPawn(Schema, X, Y, Schema) :-
    member([X, Y, _], Schema).

aiSchemaInsertPawn(Schema, X, Y, [[X, Y, 1]|Schema]) :-
    not(member([X, Y, _], Schema)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POPULATE SCHEMA
% Insert al aligned pawn in the schema
% aiSchemaPopulate(Grid, KillerMoves, PlayerId, RSchema)

privateAiSchemaPopulateByY(_, _, Schema, Schema, _, 0).

privateAiSchemaPopulateByY(Grid, PlayerId, Schema, RSchema, X, Y) :-
    Y1 is Y - 1,
    (
        (
            gameGridGet(Grid, X, Y, PlayerId),
            gameIsAligned(Grid, X, Y, PlayerId)
        ) -> (
            aiSchemaInsertPawn(Schema, X, Y, NewSchema)
        ) ; (
            Schema = NewSchema
        )
    ),
    privateAiSchemaPopulateByY(Grid, PlayerId, NewSchema, RSchema, X, Y1).


privateAiSchemaPopulateByX(_, _, Schema, Schema, 0).

privateAiSchemaPopulateByX(Grid, PlayerId, Schema, RSchema, X) :-
    X1 is X - 1,
    linesNumber(LineCount),
    privateAiSchemaPopulateByY(Grid, PlayerId, Schema, NewSchema, X, LineCount),
    privateAiSchemaPopulateByX(Grid, PlayerId, NewSchema, RSchema, X1).


aiSchemaPopulate(Grid, KillerMoves, PlayerId, SortedSchema) :-
    (
        gamePlaySequence(Grid, KillerMoves, PlayerId, DominationGrid),
        aiSchemaCreate(Grid, KillerMoves, NewSchema)
    ) -> (
        columnsNumber(ColumnCount),
        privateAiSchemaPopulateByX(DominationGrid, PlayerId, NewSchema, RSchema, ColumnCount)
    ),
    sort(RSchema, SortedSchema), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET MINIMAL COORDINATE
% get the minimal coordinate in a schema

aiSchemaMinimalCoordinate([], _, 0).

aiSchemaMinimalCoordinate([Element|Schema], CoordId, Value) :-
    listFetch(Element, CoordId, ComparedValue),
    aiSchemaMinimalCoordinate(Schema, CoordId, RValue),
    (
        (ComparedValue < RValue ; RValue == 0) ->
        (Value = ComparedValue);
        (Value = RValue)
    ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET MAXIMAL COORDINATE
% get the maximal coordinate in a schema

aiSchemaMaximalCoordinate([], _, 0).

aiSchemaMaximalCoordinate([Element|Schema], CoordId, Value) :-
    listFetch(Element, CoordId, ComparedValue),
    aiSchemaMaximalCoordinate(Schema, CoordId, RValue),
    (
        (ComparedValue > RValue) ->
        (Value = ComparedValue);
        (Value = RValue)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRUNE SCHEMA
% prune a schema from absolute coordinates to relative coordinates

privateAiSchemaPrune([], [], _, _).

privateAiSchemaPrune([[AbsX, AbsY, MatchType]|Schema], [[X, Y, MatchType]|RSchema], MinX, MinY) :-
    X is AbsX - MinX,
    Y is AbsY - MinY,
    privateAiSchemaPrune(Schema, RSchema, MinX, MinY).

aiSchemaPrune(Schema, RSchema) :-
    aiSchemaMinimalCoordinate(Schema, 1, MinX),
    aiSchemaMinimalCoordinate(Schema, 2, MinY),
    privateAiSchemaPrune(Schema, RSchema, MinX, MinY).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLIP HORIZONTALY A SCHEMA
% flip horizontaly a schema

privateAiSchemaHorizontalFlip([], [], _).

privateAiSchemaHorizontalFlip([[X, Y, MatchType]|Schema], [[NewX, Y, MatchType]|NewSchema], Width) :-
    NewX is Width - X,
    privateAiSchemaHorizontalFlip(Schema, NewSchema, Width).

aiSchemaHorizontalFlip(Schema, FlipedSchema) :-
    aiSchemaMaximalCoordinate(Schema, 1, Width),
    privateAiSchemaHorizontalFlip(Schema, RSchema, Width)
    -> sort(RSchema, FlipedSchema).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXTRACT SCHEMA FROM GRID
% extract a schema from a grid

aiSchemaExtraction(Grid, KillerMoves, PlayerId, Schema) :-
    aiSchemaPopulate(Grid, KillerMoves, PlayerId, AbsoluteSchema) ->
    aiSchemaPrune(AbsoluteSchema, Schema).
