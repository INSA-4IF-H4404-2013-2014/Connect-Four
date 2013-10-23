:- [gameCore].
:- [gamePrint].

%
% launch the uiPlayer which ask a move to the user until this move is valid.
%


uiPlayer(Grid, PlayerId, ColumnId) :-
    uiColors(Colored),
	gamePrintSymbols(Colored, PlayerId, Symb),
	write('---player--- ('),
	write(Symb),
	write(') which column ? '),
	get_single_char(C),
	ColumnId is C - 48,
    (
        integer(ColumnId),
        (
            (ColumnId == 0);
            gameIsValidePlay(Grid, ColumnId) ->
            (
                write(' -> '),
                write(ColumnId),
                write('\n'),
                gamePlay(Grid, ColumnId, PlayerId, _)
            )
        )
    ) -> (
        write('\n')
    );
    (
        write('\n'),
        write('---player--- invalid input\n'),
        write('    To play, press between 1 and 7\n'),
        write('    To abandon: press 0\n'),
        uiPlayer(Grid, PlayerId, ColumnId)
    ), !.
