:- [testUtil].
:- [iaTreeExplorer].
:- [gamePrint].

testIaTreeExplorerGridAlmostFull([
    [1,1,1,2,1,1],
    [1,1,1,1,2,1],
    [2,1,2,1,1,1],
    [1,1,1,1,1,1],
    [1,1,1,1,2],
    [1,1,1,1,1,1],
    [1,1,1,1,1,1]]).

testIaTreeExplorerGrid2MovesPossible([
	[1,2,1,2,1,2],
	[2,1,2,1,2],
	[1,1,2,2,1,1],
	[2,2,1,1,2,2],
	[1],
	[2,1,1,1,2,2],
	[2,1,1,2,1,2]
]).


privateTestIaTreeExplorerUtil(Matrix) :-
	iaTreeExplorer(Matrix, 1, ColumnWanted),
	writeTrace(iarandom, '[iaTreeExplorer]\n'),
	gridTrace(iarandom, Matrix),
	writeTrace(iarandom, '[iaTreeExplorer] '),
	writeTrace(iarandom, 'I want to put a pawn in the column '),
	writeTrace(iarandom, ColumnWanted),
	writeTrace(iarandom, '.\n').

testIaTreeExplorerBasics :-
	testIaTreeExplorerGridAlmostFull(M),
	privateTestIaTreeExplorerUtil(M),
	testIaTreeExplorerGrid2MovesPossible(M2),
	privateTestIaTreeExplorerUtil(M2).


testAllIaTreeExplorer :-
    test(testIaTreeExplorerBasics).
