:- [testUtils].
:- [traceUtils].
:- [iaRandom].
:- [gamePrint].

testIaRandomGridAlmostFull([
    [1,1,1,2,1,1],
    [1,1,1,1,2,1],
    [2,1,2,1,1,1],
    [1,1,1,1,1,1],
    [1,1,1,1,2],
    [1,1,1,1,1,1],
    [1,1,1,1,1,1]]).

testIaRandomGrid2MovesPossible([
	[1,2,1,2,1,2],
	[2,1,2,1,2],
	[1,1,2,2,1,1],
	[2,2,1,1,2,2],
	[1],
	[2,1,1,1,2,2],
	[2,1,1,2,1,2]
]).


privateTestIaRandomUtil(Matrix) :-
	iaRandom(Matrix, 1, ColumnWanted),
	writeTrace(iarandom, '[iaRandom]\n'),
	gridTrace(iarandom, Matrix),
	writeTrace(iarandom, '[iaRandom] '),
	writeTrace(iarandom, 'I want to put a pawn in the column '),
	writeTrace(iarandom, ColumnWanted),
	writeTrace(iarandom, '.\n').

testIaRandomBasics :-
	testIaRandomGridAlmostFull(M),
	privateTestIaRandomUtil(M),
	testIaRandomGrid2MovesPossible(M2),
	privateTestIaRandomUtil(M2).


testAllIaRandom :-
    test(testIaRandomBasics).
