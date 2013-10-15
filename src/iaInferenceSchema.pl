
:- [gameCore].

privateBigger([X],X).
privateBigger([X|Xs],X):- privateBigger(Xs,Y), X >=Y.
privateBigger([X|Xs],N):- privateBigger(Xs,N), N > X.


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
% privateIaInferenceSchemaElementDistance(Grid, PlayerId, ColumnId, LineId, MatchType, MovesDistance)

privateIaInferenceSchemaElementDistance(Grid, _, X, Y, 0, MovesDistance) :-
    gameColumnHeight(Grid, X, ColumnHeight) ->
    (
        MovesDistance is ((Y - ColumnHeight) - 1)
    ).

privateIaInferenceSchemaElementDistance(Grid, PlayerId, X, Y, 1, 0) :-
    gameGridGet(Grid, X, Y, PlayerId).

privateIaInferenceSchemaElementDistance(Grid, PlayerId, X, Y, 1, -1) :-
    gameGridGet(Grid, X, Y, OtherPlayerId) ->
    gameOtherPlayer(PlayerId, OtherPlayerId).

privateIaInferenceSchemaElementDistance(Grid, _, X, Y, 1, MovesDistance) :-
    gameColumnHeight(Grid, X, ColumnHeight) ->
    (
        MovesDistance is (Y - ColumnHeight),
        (MovesDistance > 0)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET A SCHEMA META DISTANCE WITH GIVEN POS
% Get the moves between a schema and values
% iaInferenceSchemaDistance(Grid, PlayerId, Schema, MovesDistance).

privateIaInferenceSchemaDistance(_, _, _, _, [], 0).

privateIaInferenceSchemaDistance(Grid, PlayerId, OffsetX, OffsetY, [Element|SubSchema], MovesDistance) :-
    (
        listFetch(Element, 1, ElementX),
        listFetch(Element, 2, ElementY),
        listFetch(Element, 3, ElementMatchType),
        X is OffsetX + ElementX,
        Y is OffsetY + ElementY
    ) -> (
        (
            privateIaInferenceSchemaElementDistance(Grid, PlayerId, X, Y, ElementMatchType, ElementDistance),
            ElementDistance >= 0
        ) -> (
            privateIaInferenceSchemaDistance(Grid, PlayerId, OffsetX, OffsetY, SubSchema, SubSchemaDistance),
            MovesDistance is SubSchemaDistance + ElementDistance
        ) ; (
            fail
        )
    ).

privateIaInferenceMinDistance(X, Y, R) :-
    listFetch(X, 3, Distance0),
    listFetch(Y, 3, Distance1),
    ((Distance0 > Distance1, Distance1 >= 0) -> (R = Y) ; (R = X)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET A SCHEMA META DISTANCE
% Get the moves between a schema and values
% iaInferenceSchemaDistance(Grid, PlayerId, Schema, MovesDistance).

privateIaInferenceSchemaDistanceByY(_, _, _, 0, _, [0, 0, -1]).
privateIaInferenceSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY, Schema, MovesDistance) :-
    privateIaInferenceSchemaDistance(Grid, PlayerId, OffsetX, OffsetY, Schema, CurDistance)
    -> (
        OffsetY1 is OffsetY - 1,
        privateIaInferenceSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY1, Schema, SubsDistance) ->
        privateIaInferenceMinDistance([OffsetX, OffsetY, CurDistance], SubsDistance, MovesDistance)
    );(
        OffsetY1 is OffsetY - 1,
        privateIaInferenceSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY1, Schema, MovesDistance)
    ), !.

privateIaInferenceSchemaDistanceByX(_, _, 0, _, [0, 0, -1]).
privateIaInferenceSchemaDistanceByX(Grid, PlayerId, OffsetX, Schema, MovesDistance) :-
    (
        linesNumber(OffsetY),
        privateIaInferenceSchemaDistanceByY(Grid, PlayerId, OffsetX, OffsetY, Schema, CurDistance)
    ) -> (
        OffsetX1 is OffsetX - 1,
        privateIaInferenceSchemaDistanceByX(Grid, PlayerId, OffsetX1, Schema, SubsDistance) ->
        privateIaInferenceMinDistance(CurDistance, SubsDistance, MovesDistance)
    );(
        OffsetX1 is OffsetX - 1,
        privateIaInferenceSchemaDistanceByX(Grid, PlayerId, OffsetX1, Schema, MovesDistance)
    ), !.

iaInferenceSchemaDistance(Grid, PlayerId, Schema, Infos) :-
    columnsNumber(OffsetX),
    privateIaInferenceSchemaDistanceByX(Grid, PlayerId, OffsetX, Schema, Infos),
    listFetch(Infos, 3, MovesDistance),
    MovesDistance >= 0.
