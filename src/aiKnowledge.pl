
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
        writeTrace(game, Schema)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN FROM A GRID
% this predicated extracte the associated schema, and saves it into the
% knowledge database.
% Fails only if iaSchemaExtraction/4 fails.

aiKnowledgeLearn(Grid, KillerMoves, PlayerId) :-
    aiSchemaExtraction(Grid, KillerMoves, PlayerId, Schema)
    -> (
        aiKnowledgeSaveSchema(Schema)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET NEAREST KNOWN SCHEMA
% find the nearest schema in the database for the givem <Grid> and <PlayerId>
% aiKnowledgeNearestSchema(Grid, PlayerId, FoundSchema, PosX, PosY, MoveRemaining)

aiKnowledgeNearestSchema(Grid, PlayerId, Schema, PosX, PosY, MoveRemaining) :-
    aiKnowledge(Schema) ->
    (
        aiSchemaDistance(Grid, PlayerId, Schema, [PosX, PosY, MoveRemaining])
    ).
