
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

:- [aiSchemaMatching].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% KNOWNLEDGE DATABASE

:- dynamic iaInferenceDB/1.
% findall(X, iaInferenceDB(X), L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESET THE KNOWNLEDGE DATABASE
% reset the knownledge database for unit tests

iaInferenceResetDatabase :-
    retractall(iaInferenceDB(_)) ->
    assert(iaInferenceDB([
        [0, 0, 0],
        [1, 0, 1],
        [2, 0, 1],
        [3, 0, 1],
        [4, 0, 0]
    ])),
    !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN THE FIRST SHEMA
% N W W W M
:- iaInferenceResetDatabase.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CONSULT KNWONLEDGE DATABASE
% find the nearest schema in the database for the givem <Grid> and <PlayerId>
% iaInferenceConsultDatabase(Grid, PlayerId, FoundSchema, PosX, PosY, MoveRemaining)

iaInferenceConsultDatabase(Grid, PlayerId, Schema, PosX, PosY, MoveRemaining) :-
    iaInferenceDB(Schema) ->
    (
        aiSchemaDistance(Grid, PlayerId, Schema, [PosX, PosY, MoveRemaining])
    ).
