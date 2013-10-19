
:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST SCHEMA
% Schema structure :
% [
%   [<x>,<y>,<matchType>],
%   [<x>,<y>,<matchType>],
%   [<x>,<y>,<matchType>]
%   ...
% ],
%
% <x> : column id [0, ...]
% <y> : line id [0, ...]
% <matchType>:
%   - 0 : empty
%   - 1 : winner pawns


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET SCHEMA ELEMENT DISTANCE
% privateAiSchemaElementDistance(Grid, PlayerId, ColumnId, LineId, MatchType, MovesDistance)

privateAiSchemaElementDistance(Grid, _, X, Y, 0, MovesDistance) :-
    gameColumnHeight(Grid, X, ColumnHeight) ->
    (
        MovesDistance is ((Y - ColumnHeight) - 1)
    ).

privateAiSchemaElementDistance(Grid, PlayerId, X, Y, 1, 0) :-
    gameGridGet(Grid, X, Y, PlayerId).

privateAiSchemaElementDistance(Grid, PlayerId, X, Y, 1, -1) :-
    gameGridGet(Grid, X, Y, OtherPlayerId) ->
    gameOtherPlayer(PlayerId, OtherPlayerId).

privateAiSchemaElementDistance(Grid, _, X, Y, 1, MovesDistance) :-
    gameColumnHeight(Grid, X, ColumnHeight) ->
    (
        MovesDistance is (Y - ColumnHeight),
        (MovesDistance > 0)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET A SCHEMA META DISTANCE WITH GIVEN POS
% Get the moves between a schema and values
% AiSchemaDistance(Grid, PlayerId, Schema, MovesDistance).

privateAiSchemaDistance(_, _, _, _, [], 0).

privateAiSchemaDistance(Grid, PlayerId, OffsetX, OffsetY, [Element|SubSchema], MovesDistance) :-
    (
        listFetch(Element, 1, ElementX),
        listFetch(Element, 2, ElementY),
        listFetch(Element, 3, ElementMatchType),
        X is OffsetX + ElementX,
        Y is OffsetY + ElementY
    ) -> (
        (
            privateAiSchemaElementDistance(Grid, PlayerId, X, Y, ElementMatchType, ElementDistance),
            ElementDistance >= 0
        ) -> (
            privateAiSchemaDistance(Grid, PlayerId, OffsetX, OffsetY, SubSchema, SubSchemaDistance),
            MovesDistance is SubSchemaDistance + ElementDistance
        ) ; (
            fail
        )
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET THE NEAREST SCHEMA POSITION

privateAiSchemaNearestPos(X, R, R) :- listFetch(X, 3, Distance), Distance < 0.
privateAiSchemaNearestPos(R, Y, R) :- listFetch(Y, 3, Distance), Distance < 0.
privateAiSchemaNearestPos(X, Y, R) :-
    listFetch(X, 3, Distance0),
    listFetch(Y, 3, Distance1),
    Distance0 >= 0, Distance1 >= 0,
    ((Distance0 < Distance1) -> (R = X) ; (R = Y)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET A SCHEMA META DISTANCE
% Get the moves between a schema and values
% AiSchemaDistance(Grid, PlayerId, Schema, MovesDistance).

privateAiSchemaDistanceByY(_, _, _, 0, _, [0, 0, -1]).
privateAiSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY, Schema, MovesDistance) :-
    privateAiSchemaDistance(Grid, PlayerId, OffsetX, OffsetY, Schema, CurDistance)
    -> (
        OffsetY1 is OffsetY - 1,
        privateAiSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY1, Schema, SubsDistance) ->
        privateAiSchemaNearestPos([OffsetX, OffsetY, CurDistance], SubsDistance, MovesDistance)
    );(
        OffsetY1 is OffsetY - 1,
        privateAiSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY1, Schema, MovesDistance)
    ), !.

privateAiSchemaDistanceByX(_, _, 0, _, [0, 0, -1]).
privateAiSchemaDistanceByX(Grid, PlayerId, OffsetX, Schema, MovesDistance) :-
    (
        linesNumber(OffsetY),
        privateAiSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY, Schema, CurDistance)
    ) -> (
        OffsetX1 is OffsetX - 1,
        privateAiSchemaDistanceByX(Grid, PlayerId, OffsetX1, Schema, SubsDistance) ->
        privateAiSchemaNearestPos(CurDistance, SubsDistance, MovesDistance)
    );(
        OffsetX1 is OffsetX - 1,
        privateAiSchemaDistanceByX(Grid, PlayerId, OffsetX1, Schema, MovesDistance)
    ), !.

aiSchemaDistance(Grid, PlayerId, Schema, Infos) :-
    columnsNumber(OffsetX),
    privateAiSchemaDistanceByX(Grid, PlayerId, OffsetX, Schema, Infos),
    listFetch(Infos, 3, MovesDistance),
    MovesDistance >= 0.
