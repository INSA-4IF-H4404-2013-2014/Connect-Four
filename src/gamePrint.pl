
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRINT A GRID
% Print a grid
% gamePrintGrid(Grid)
gamePrintSymbols(1,x).
gamePrintSymbols(2,o).

privateGamePrintGrid([], _).

privateGamePrintGrid([Column|Grid], LineId) :-
    (listFetch(Column, LineId, Result) ->
        gamePrintSymbols(Result, S), write(S), write(' ') ;
        write('  ')
    ) ->
    privateGamePrintGrid(Grid, LineId).

gamePrintGrid(_, 0).

gamePrintGrid(Grid, LineId) :-
    write('| ') ->
    privateGamePrintGrid(Grid, LineId) ->
    write('\n') ->
    LineId1 is LineId - 1 ->
    gamePrintGrid(Grid, LineId1).

gamePrintGrid(Grid) :-
    linesNumber(LinesCount),
    gamePrintGrid(Grid, LinesCount), !.
