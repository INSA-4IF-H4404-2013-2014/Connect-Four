:- [gamePrint].
:- [traceUtil].

%
% launch the iaUser which ask a move to the user until this move is valid.
%


iaUser(Grid, Num , Char) :- gridTrace(graphInt, Grid),
	gamePrintSymbols(Num, Symb),
	
	writeTrace(txtInt, '\n ---interface--- p'),
	writeTrace(txtInt, Num),
	writeTrace(txtInt, ' ( '),
	writeTrace(txtInt, Symb),
	writeTrace(txtInt, ' ) which column ? '),
	get_single_char(C),
	Char is C-48,
	writeTrace(txtInt, ' -> '),
	writeTrace(txtInt, Char),
	writeTrace(txtInt, ' \n'),
	integer(Char),	
	(Char==0; gameIsValidePlay(Grid, Char)), !.


iaUser(Grid, Num , C) :- 
	writeTrace(txtInt, '\n ---interface--- choice not valid'),
	iaUser(Grid, Num , C) .
	




