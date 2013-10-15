
:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST SCHEMA
% Schema structure :
% [
%   [<x>,<y>,<type>],
%   [<x>,<y>,<type>],
%   [<x>,<y>,<type>]
%   ...
% ],
%
% <x> : column id [0, ...]
% <y> : line id [0, ...]
% <type>:
%   - 0 : empty
%   - 1 : winner pawns


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET SCHEMA ELEMENT DISTANCE
% privateIaInferenceSchemaElementDistance(Grid, PlayerId, ColumnId, LineId, MatchType, AbstractDistance)

privateIaInferenceSchemaElementDistance(Grid, _, X, Y, 0, AbstractDistance) :-
    gameColumnHeight(Grid, X, ColumnHeight) ->
    (
        AbstractDistance is ((Y - ColumnHeight) - 1)
    ).

privateIaInferenceSchemaElementDistance(Grid, PlayerId, X, Y, 1, 0) :-
    gameGridGet(Grid, X, Y, PlayerId).

privateIaInferenceSchemaElementDistance(Grid, PlayerId, X, Y, 1, -1) :-
    gameGridGet(Grid, X, Y, OtherPlayerId) ->
    gameOtherPlayer(PlayerId, OtherPlayerId).

privateIaInferenceSchemaElementDistance(Grid, _, X, Y, 1, AbstractDistance) :-
    (AbstractDistance > 0),
    gameColumnHeight(Grid, X, ColumnHeight) ->
    (
        AbstractDistance is (Y - ColumnHeight)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST A SCHEMA ELEMENT
privateIaInferenceTestSchemaElement(Grid, PlayerId, ColumnId, LineId, MatchType) :-
    privateIaInferenceSchemaElementDistance(Grid, PlayerId, ColumnId, LineId, MatchType, X) ->
    X >= 0.
