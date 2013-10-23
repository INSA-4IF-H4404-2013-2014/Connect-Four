
:- [gameSmart].

%%%%%%%%%%%%% Lauches the Player Random and get its move decision %%%%%%%%%%%%%%
% Matrix is the game grid
% The second parameter is the player number
% ColumnIndexWanted is the column of the move chosen by the Player (return val)
playerRandom(Matrix, _, ColumnIndexWantedMove) :-
	gameRemainingPlays(Matrix, Indexes),
    privatePlayerRandom(Indexes, ColumnIndexWantedMove).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Lauches the Player Random Smart and get its move decision %%%%%%%%%%%
% Matrix is the game grid
% PlayerId is the player number
% ColumnId is the index of the column in which the AI wants to play
% Might dye by suicide

% Play if the player has or winning move or can counter the opponent in the appropriate column
playerRandomKamikaze(Matrix, PlayerId, ColumnId) :-
	gameObviousMove(Matrix, PlayerId, ColumnId) ->
        true;
        playerRandom(Matrix, PlayerId, ColumnId).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Lauches the Player Random Smart and get its move decision %%%%%%%%%%%
% Matrix is the game grid
% PlayerId is the player number
% ColumnId is the index of the column in which the AI wants to play

% Play if the player has or winning move or can counter the opponent in the appropriate column
playerRandomSmart(Matrix, PlayerId, ColumnId) :-
    gameObviousMove(Matrix, PlayerId, ColumnId) -> (
        true
    ); (
        gameRemainingPlays(Matrix, Remainings),
        gameSuicideMoves(Matrix, PlayerId, Suicides),
        subtract(Remainings, Suicides, ColumnIds),
        length(ColumnIds, Count),
        (
            Count > 0 -> (
                privatePlayerRandom(ColumnIds, ColumnId)
            ); (
                % we are going to die anyway.
                listFetch(Remainings, 1, ColumnId)
            )
        )
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE

privatePlayerRandom(ColumnIds, ColumnId) :-
    %Please don't touch this code. There is a bug on Ubuntu, only the form
    %"A is random(X)" works. Cannot use other forms of random.
    %http://comments.gmane.org/gmane.comp.ai.prolog.swi/15929
    length(ColumnIds, NumberOfPossibleMoves),
    MoveWantedTmp is random(NumberOfPossibleMoves),
    MoveWanted is (MoveWantedTmp + 1),
    listFetch(ColumnIds, MoveWanted, ColumnId).
