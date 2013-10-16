:- [gamePrint].

%
% launch the iaUser which ask a move to the user until this move is valid.
%


iaUser(Grid, Num , Char) :-
    gamePrintGrid(Grid),
	gamePrintSymbols(Num, Symb),
	write('\n ---interface--- p'),
	write(Num),
	write(' ( '),
	write(Symb),
	write(' ) which column ? '),
	get_single_char(C),
	Char is C-48,
	write(' -> '),
	write(Char),
	write(' \n'),
	integer(Char),	
	(Char==0; gameIsValidePlay(Grid, Char)), !.


iaUser(Grid, Num , C) :-
	write('\n ---interface--- choice not valid'),
	iaUser(Grid, Num , C) .
