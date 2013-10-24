
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRINT A GRID
% Print a grid
% gamePrintGrid(Grid)
gamePrintSymbols(1, 'x').
gamePrintSymbols(2, 'o').

gamePrintSymbols(0, PlayerId, R) :-
    gamePrintSymbols(PlayerId, R).
gamePrintSymbols(1, 1, '\e[36mx\e[0m').
gamePrintSymbols(1, 2, '\e[31mo\e[0m').

privateGamePrintGrid([], _, 0, _).

privateGamePrintGrid([Column|Grid], LineId, ColumnId, LastColumnPlayed) :-
    (listFetch(Column, LineId, Result) ->
        uiColors(Colored),
        gamePrintSymbols(Colored, Result, S),
		(
			(
				not(LastColumnPlayed == 0),
				columnsNumber(ColumnsNumber),
				TrueColumnId is (-1 * ColumnId + ColumnsNumber + 1),
				TrueColumnId == LastColumnPlayed,
				length(Column, ColumnHeight),
				LineId == ColumnHeight
			) ->
				upcase_atom(S, S2) ;
				(S2 = S)
		),
        write(S2),
        write(' ') ;
        write('  ')
    ) ->
	ColumnId1 is ColumnId - 1 ->
    privateGamePrintGrid(Grid, LineId, ColumnId1, LastColumnPlayed).

gamePrintGrid(_, 0, _) :-
    write('| 1 2 3 4 5 6 7\n').

gamePrintGrid(Grid, LineId, LastColumnPlayed) :-
    write('| ') ->
    columnsNumber(ColumnsCount),
    privateGamePrintGrid(Grid, LineId, ColumnsCount, LastColumnPlayed) ->
    write('\n') ->
    LineId1 is LineId - 1 ->
    gamePrintGrid(Grid, LineId1, LastColumnPlayed).

gamePrintGrid(Grid, LastColumnPlayed) :-
    linesNumber(LinesCount),
    gamePrintGrid(Grid, LinesCount, LastColumnPlayed), !.

gamePrintGrid(Grid) :-
	gamePrintGrid(Grid, 0).
