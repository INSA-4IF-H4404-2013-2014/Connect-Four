
:- [aiSchemaMatching].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EVALUATE DISTANCE OF ONE SCHEMA ELEMENT
% privateIaInferenceCleverMove(Grid, PlayerId, ColumnId, LineId, MatchType, MovesDistance)

privateIaInferenceCleverMove(_, _, [_,_,0], _, _, SubColumnId, MetaDistance, SubColumnId, MetaDistance).

privateIaInferenceCleverMove(Grid, PlayerId, [RX, RY, 1], PosX, PosY, SubColumnId, SubMetaDistance, ColumnId, MetaDistance) :-
    X is PosX + RX,
    Y is PosY + RY,
    privateAiSchemaElementDistance(Grid, PlayerId, X, Y, 1, CurentDistance) ->
    ((
        CurentDistance > 0,
        (CurentDistance < SubMetaDistance ; SubColumnId == 0)
    ) -> (
        MetaDistance = CurentDistance,
        ColumnId = X
    ) ; (
        SubColumnId = ColumnId,
        SubMetaDistance = MetaDistance
    )).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THE CLEVEREST MOVE TO DO WITH A SCHEMA
isInferenceCleverMove(_, _, [], _, _, 0, 0).

isInferenceCleverMove(Grid, PlayerId, [Element|Schema], PosX, PosY, ColumnId, MetaDistance) :-
    isInferenceCleverMove(Grid, PlayerId, Schema, PosX, PosY, SubColumnId, SubMetaDistance),
    privateIaInferenceCleverMove(Grid, PlayerId, Element, PosX, PosY, SubColumnId, SubMetaDistance, ColumnId, MetaDistance).
