
:- [gameCore].
:- [aiKnowledge].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EVALUATE THE SMARTEST MOVE TO DO

aiSmartNearestDistance(Grid, PlayerId, Distance) :-
    aiKnowledgeNearestSchema(Grid, PlayerId, _, _, _, Distance)
    -> (
        true
    ); (
        Distance = 0
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHOSE BEST MOVE BETWEEN TWO

aiSmartChoose(BestDistance0, WorstDistance0, ColumnId0,
              BestDistance1, WorstDistance1, _,
              BestDistance0, WorstDistance0, ColumnId0) :-
    (BestDistance0 < BestDistance1) ;
    (WorstDistance0 > WorstDistance1).


aiSmartChoose(BestDistance0, WorstDistance0, _,
              BestDistance1, WorstDistance1, ColumnId1,
              BestDistance1, WorstDistance1, ColumnId1) :-
    not(
        (BestDistance0 < BestDistance1) ;
        (WorstDistance0 > WorstDistance1)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EVALUATE THE SMARTEST MOVE TO DO

privateIaSmartMove(Grid, PlayerId, 0, RBestDistance, RWorstDistance, 0) :-
    gameOtherPlayer(PlayerId, OtherPlayerId),
    aiSmartNearestDistance(Grid, PlayerId, RBestDistance),
    aiSmartNearestDistance(Grid, OtherPlayerId, RWorstDistance).

privateIaSmartMove(Grid, PlayerId, ColumnId, RBestDistance, RWorstDistance, RColumnId) :-
    not(gameIsValidePlay(Grid, ColumnId, PlayerId)),
    ColumnId1 is ColumnId - 1,
    privateIaSmartMove(Grid, PlayerId, ColumnId1, RBestDistance, RWorstDistance, RColumnId).

privateIaSmartMove(Grid, PlayerId, ColumnId, RBestDistance, RWorstDistance, RColumnId) :-
    gameIsValidePlay(Grid, ColumnId, PlayerId),
    gameOtherPlayer(PlayerId, OtherPlayerId),
    gamePlay(Grid, ColumnId, PlayerId, TestGrid),
    aiSmartNearestDistance(TestGrid, PlayerId, NewBestDistance),
    aiSmartNearestDistance(TestGrid, OtherPlayerId, NewWorstDistance),
    ColumnId1 is ColumnId - 1,
    privateIaSmartMove(Grid, PlayerId, ColumnId1, BestDistance, WorstDistance, SmartColumnId),
    aiSmartChoose(BestDistance, WorstDistance, SmartColumnId, NewBestDistance, NewWorstDistance, ColumnId, RBestDistance, RWorstDistance, RColumnId).

aiSmartMove(Grid, PlayerId, ColumnId) :-
    columnsNumber(ColumnCount),
    privateIaSmartMove(Grid, PlayerId, ColumnCount, _, _, ColumnId),
    not(ColumnId == 0).
