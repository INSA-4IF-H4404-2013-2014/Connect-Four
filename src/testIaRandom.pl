:- [testUtil].
:- [iaRandom].
:- [gamePrint].

testIaRandomBasics :-
	testPrivateAlmostFullGrid(M),
	iaRandom(M, 1, ColumnWanted),
	%gamePrintGrid(M),
	writeTrace(iarandom, '[iaRandom] '),
	writeTrace(iarandom, 'I want to put a pawn in the column '),
	writeTrace(iarandom, ColumnWanted),
	writeTrace(iarandom, '.\n').


testAllIaRandom :-
    test(testIaRandomBasics).
