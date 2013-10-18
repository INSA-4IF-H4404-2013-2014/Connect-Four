
:- [aiSchemaMatching].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EVALUATE DISTANCE OF ONE SCHEMA ELEMENT
% privateAiSchemaSmartMove(Grid, PlayerId, ColumnId, LineId, MatchType, MovesDistance)

privateAiSchemaSmartMove(_, _, [_,_,0], _, _, SubColumnId, MetaDistance, SubColumnId, MetaDistance).

privateAiSchemaSmartMove(Grid, PlayerId, [RX, RY, 1], PosX, PosY, SubColumnId, SubMetaDistance, ColumnId, MetaDistance) :-
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
iaSchemaSmartMove(_, _, [], _, _, 0, 0).

iaSchemaSmartMove(Grid, PlayerId, [Element|Schema], PosX, PosY, ColumnId, MetaDistance) :-
    iaSchemaSmartMove(Grid, PlayerId, Schema, PosX, PosY, SubColumnId, SubMetaDistance),
    privateAiSchemaSmartMove(Grid, PlayerId, Element, PosX, PosY, SubColumnId, SubMetaDistance, ColumnId, MetaDistance).
