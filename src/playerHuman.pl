:- [gameCore].
:- [gamePrint].

%
% launch the playerHuman which ask a move to the user until this move is valid.
%


playerHuman(Grid, PlayerId, ColumnId) :-
    gamePrintGrid(Grid),
	gamePrintSymbols(PlayerId, Symb),
	write('---playeur--- ('),
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
                gamePlay(Grid, ColumnId, PlayerId, NewGrid),
                gamePrintGrid(NewGrid)
            )
        )
    ) -> (
        write('\n')
    );
    (
        write('\n'),
        write('---playeur--- invalide input\n'),
        write('    To play: press between 1 and 7\n'),
        write('    To abandon: press 0\n'),
        playerHuman(Grid, PlayerId, ColumnId)
    ), !.
