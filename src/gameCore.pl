
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CONSTANTS
% Constants
% Game grid

columnsNumber(7).
linesNumber(6).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FETCH AN ELEMENT
% listFetch(list,index,element) <=> element = list[index]

listFetch([X|_], 1, X).
listFetch([_|List], Pos, Result) :-
    Pos1 is Pos - 1,
    listFetch(List, Pos1, Result).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATE AN EMPTY GRID
% Create a new empty matrix
% gameNewGrid(GridResult).

gameNewGrid(0,[]).

gameNewGrid(Col, [[]|Matrix]) :-
    Col1 is Col-1,
    gameNewGrid(Col1, Matrix).

gameNewGrid(Matrix) :-
    columnsNumber(L),
    gameNewGrid(L, Matrix), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INSERT A PAWN IN THE GRID
% Insert a pawn in the grid at the specified column
% gamePlay(Grid, ColumnNumber, PlayerId, GridResult).

gamePlay([Column|Grid], ColumnId, PlayerId, [ColumnR|Grid], ColumnId) :-
    append(Column, [PlayerId], ColumnR).

gamePlay([X|Grid], Column, PlayerId, [X|Result], Pos) :-
	not(Pos = Column),
    Pos1 is Pos + 1,
    gamePlay(Grid, Column, PlayerId, Result, Pos1).

gamePlay(Grid, Column, PlayerId, Result) :-
    gamePlay(Grid, Column, PlayerId, Result, 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET PAWN IN THE GRID
% Returns the value of a Pawn at the specified line and column
% gameGridGet(Grid, ColumnId, LineId, ResultContent).

gameGridGet(Grid, ColumnId, LineId, Result) :-
    listFetch(Grid, ColumnId, Column) -> listFetch(Column, LineId, Result).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GET REMAINING PLAYS
% Return the list of non-full columns' indexes
% gameRemainingPlays(Grid, ColumnList).
gameRemainingPlays([], [], _).

gameRemainingPlays([Column|Grid], Indexes, ColumnId) :-
    length(Column, ColumnHeight),
    linesNumber(ColumnHeight),
    ColumnId1 is ColumnId + 1,
    gameRemainingPlays(Grid, Indexes, ColumnId1).

gameRemainingPlays([Column|Grid], [ColumnId|Indexes], ColumnId) :-
    length(Column, ColumnHeight),
    not(linesNumber(ColumnHeight)),
    ColumnId1 is ColumnId + 1,
    gameRemainingPlays(Grid, Indexes, ColumnId1).

gameRemainingPlays(Grid, Indexes) :-
    gameRemainingPlays(Grid, Indexes, 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST IS A VALIDE PLAY
% Success if the column is not already full
% gameIsValidePlay(Grid, ColumnId).
gameIsValidePlay(Grid, ColumnId) :-
    listFetch(Grid, ColumnId, Column) ->
        length(Column, ColumnHeight),
        not(linesNumber(ColumnHeight)).
