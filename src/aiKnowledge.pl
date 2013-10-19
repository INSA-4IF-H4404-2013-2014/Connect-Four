
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

:- [aiSchemaMatching].
:- [aiSchemaProcessing].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% KNOWNLEDGE DATABASE
% the knowledge database don't have symetrics schemas. Only one of two symetrics
% are saved.

:- dynamic aiKnowledge/1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESET THE KNOWNLEDGE DATABASE
% reset the knownledge database for unit tests

aiInferenceResetDatabase :-
    retractall(aiKnowledge(_)) ->
    assert(aiKnowledge([
        [0, 0, 0],
        [1, 0, 1],
        [2, 0, 1],
        [3, 0, 1],
        [4, 0, 0]
    ])),
    !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN THE FIRST SHEMA
% N W W W M
:- aiInferenceResetDatabase.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LIST ALL KNOWN SCHEMAS
% aiKnowledgeAll(ShemaList).

aiKnowledgeAll(ShemaList) :-
    findall(X, aiKnowledge(X), ShemaList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE SCHEMA
% Save the schema

aiKnowledgeSaveSchema(Schema) :-
    aiSchemaHorizontalFlip(Schema, FlipedSchema),
    (aiKnowledge(Schema); aiKnowledge(FlipedSchema))
    -> (
        % the schema or its fliped version is already known
        true
    ); (
        assert(aiKnowledge(Schema)),
        writeTrace(aiLearning, 'aiKnowledge('),
        writeTrace(aiLearning, Schema),
        writeTrace(aiLearning, ')\n')
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN FROM A GRID
% this predicated extracte the associated schema, and saves it into the
% knowledge database.
% Fails only if iaSchemaExtraction/4 fails.
% <PlayerId> Player id of the winner.

aiKnowledgeLearn(Grid, KillerMoves, PlayerId) :-
    aiSchemaExtraction(Grid, KillerMoves, PlayerId, Schema)
    -> (
        aiKnowledgeSaveSchema(Schema)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET NEAREST KNOWN SCHEMA
% find the nearest schema in the database for the givem <Grid> and <PlayerId>
% aiKnowledgeNearestSchema(Grid, PlayerId, FoundSchema, PosX, PosY, MoveRemaining)

privateAiKnowledgeNearestSchema(Grid, PlayerId, [Schema], Schema, MoveRemaining) :-
    aiSchemaDistance(Grid, PlayerId, Schema, [_, _, MoveRemaining]).

privateAiKnowledgeNearestSchema(Grid, PlayerId, [Schema|SchemaList], RSchema, RMoveRemaining) :-
    aiSchemaDistance(Grid, PlayerId, Schema, [_, _, MoveRemaining]),
    privateAiKnowledgeNearestSchema(Grid, PlayerId, SchemaList, SubSchema, SubMoveRemaining),
    (
        (MoveRemaining < SubMoveRemaining) -> (
            RMoveRemaining = MoveRemaining,
            RSchema = Schema
        ); (
            RMoveRemaining = SubMoveRemaining,
            RSchema = SubSchema
        )
    ).

privateAiKnowledgeNearestSchemaFliped(Grid, PlayerId, [Schema], FlipedSchema, MoveRemaining) :-
    aiSchemaHorizontalFlip(Schema, FlipedSchema),
    aiSchemaDistance(Grid, PlayerId, FlipedSchema, [_, _, MoveRemaining]).

privateAiKnowledgeNearestSchemaFliped(Grid, PlayerId, [Schema|SchemaList], RSchema, RMoveRemaining) :-
    aiSchemaHorizontalFlip(Schema, FlipedSchema),
    aiSchemaDistance(Grid, PlayerId, FlipedSchema, [_, _, MoveRemaining]),
    privateAiKnowledgeNearestSchema(Grid, PlayerId, SchemaList, SubSchema, SubMoveRemaining),
    (
        (MoveRemaining < SubMoveRemaining) -> (
            RMoveRemaining = MoveRemaining,
            RSchema = FlipedSchema
        ); (
            RMoveRemaining = SubMoveRemaining,
            RSchema = SubSchema
        )
    ).

aiKnowledgeNearestSchema(Grid, PlayerId, Schema, MoveRemaining) :-
    aiKnowledgeAll(SchemaList) ->
    (
        privateAiKnowledgeNearestSchema(Grid, PlayerId, SchemaList, Schema0, MoveRemaining0),
        privateAiKnowledgeNearestSchemaFliped(Grid, PlayerId, SchemaList, Schema1, MoveRemaining1),
        (
            (MoveRemaining0 < MoveRemaining1) -> (
                MoveRemaining = MoveRemaining0,
                Schema = Schema0
            ); (
                MoveRemaining = MoveRemaining1,
                Schema = Schema1
            )
        )
    ).
