
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRINT A GRID
% Print a grid
% gamePrintGrid(Grid)
gamePrintSymbols(1, 'x').
gamePrintSymbols(2, 'o').

gamePrintSymbols(0, PlayerId, R) :-
    gamePrintSymbols(PlayerId, R).
gamePrintSymbols(1, 1, '\e[36mx\e[0m').
gamePrintSymbols(1, 2, '\e[31mo\e[0m').

privateGamePrintGrid([], _).

privateGamePrintGrid([Column|Grid], LineId) :-
    (listFetch(Column, LineId, Result) ->
        uiColors(Colored),
        gamePrintSymbols(Colored, Result, S),
        write(S),
        write(' ') ;
        write('  ')
    ) ->
    privateGamePrintGrid(Grid, LineId).

gamePrintGrid(_, 0) :-
    write('| 1 2 3 4 5 6 7\n').

gamePrintGrid(Grid, LineId) :-
    write('| ') ->
    privateGamePrintGrid(Grid, LineId) ->
    write('\n') ->
    LineId1 is LineId - 1 ->
    gamePrintGrid(Grid, LineId1).

gamePrintGrid(Grid) :-
    linesNumber(LinesCount),
    gamePrintGrid(Grid, LinesCount), !.
