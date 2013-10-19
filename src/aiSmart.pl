
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
              BestDistance1, WorstDistance1, ColumnId1,
              RBestDistance, RWorstDistance, RColumnId) :-

    (ColumnId1 == 0) -> (
        RBestDistance = BestDistance0,
        RWorstDistance = WorstDistance0,
        RColumnId = ColumnId0
    );

    ((WorstDistance1 < BestDistance1), not(WorstDistance0 < BestDistance0)) -> (
        % we take over the other player with solution 0
        RBestDistance = BestDistance0,
        RWorstDistance = WorstDistance0,
        RColumnId = ColumnId0
    );
    (not(WorstDistance1 < BestDistance1), (WorstDistance0 < BestDistance0)) -> (
        % we do not let the other player to take over us with solution 0
        RBestDistance = BestDistance1,
        RWorstDistance = WorstDistance1,
        RColumnId = ColumnId1
    );

    % Compare with a mark firstly
    (Mark is (BestDistance1 - BestDistance0 + WorstDistance0 - WorstDistance1)) ->
    (
        (Mark > 0) -> ( % using 0 is better
            RBestDistance = BestDistance0,
            RWorstDistance = WorstDistance0,
            RColumnId = ColumnId0
        );
        (Mark < 0) -> ( % using 0 is worst -> we keep 1
            RBestDistance = BestDistance1,
            RWorstDistance = WorstDistance1,
            RColumnId = ColumnId1
        );

        % Compare how can win before
        (BestDistance0 < BestDistance1) -> ( % we can win before with 0
            RBestDistance = BestDistance0,
            RWorstDistance = WorstDistance0,
            RColumnId = ColumnId0
        );
        (BestDistance1 < BestDistance0) -> ( % we can win before with 1
            RBestDistance = BestDistance1,
            RWorstDistance = WorstDistance1,
            RColumnId = ColumnId1
        );

        % BestDistance0 == BestDistance1
        % => WorstDistance0 == WorstDistance1
        % => we keep the previous move
        (
            RBestDistance = BestDistance1,
            RWorstDistance = WorstDistance1,
            RColumnId = ColumnId1
        )
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EVALUATE THE SMARTEST MOVE TO DO

privateIaSmartMove(_, _, 0, 0, 0, 0).

privateIaSmartMove(Grid, PlayerId, ColumnId, RBestDistance, RWorstDistance, RColumnId) :-
    not(ColumnId = 0),
    not(gameIsValidePlay(Grid, ColumnId)) ->
    (
        ColumnId1 is ColumnId - 1,
        privateIaSmartMove(Grid, PlayerId, ColumnId1, RBestDistance, RWorstDistance, RColumnId)
    ).

privateIaSmartMove(Grid, PlayerId, ColumnId, RBestDistance, RWorstDistance, RColumnId) :-
    not(ColumnId = 0),
    gameIsValidePlay(Grid, ColumnId) ->
    (
        gameOtherPlayer(PlayerId, OtherPlayerId),
        gamePlay(Grid, ColumnId, PlayerId, TestGrid),

        aiSmartNearestDistance(TestGrid, PlayerId, NewBestDistance),
        aiSmartNearestDistance(TestGrid, OtherPlayerId, NewWorstDistance),

        ColumnId1 is ColumnId - 1,
        privateIaSmartMove(Grid, PlayerId, ColumnId1, SubBestDistance, SubWorstDistance, SubColumnId),

        aiSmartChoose(NewBestDistance, NewWorstDistance, ColumnId, SubBestDistance, SubWorstDistance, SubColumnId, RBestDistance, RWorstDistance, RColumnId)
    ).

aiSmartMove(Grid, PlayerId, ColumnId) :-
    columnsNumber(ColumnCount),
    privateIaSmartMove(Grid, PlayerId, ColumnCount, _, _, ColumnId),
    not(ColumnId == 0).
