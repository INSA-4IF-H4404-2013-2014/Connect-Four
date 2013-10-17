:- [testUtils].
:- [traceUtils].
:- [playerRandom].
:- [gamePrint].

testPlayerRandomGridAlmostFull([
    [1,1,1,2,1,1],
    [1,1,1,1,2,1],
    [2,1,2,1,1,1],
    [1,1,1,1,1,1],
    [1,1,1,1,2],
    [1,1,1,1,1,1],
    [1,1,1,1,1,1]]).

testPlayerRandomGrid2MovesPossible([
	[1,2,1,2,1,2],
	[2,1,2,1,2],
	[1,1,2,2,1,1],
	[2,2,1,1,2,2],
	[1],
	[2,1,1,1,2,2],
	[2,1,1,2,1,2]
]).


privateTestPlayerRandomUtil(Matrix) :-
	playerRandom(Matrix, 1, ColumnWanted),
	writeTrace(playerrandom, '[playerRandom]\n'),
	gridTrace(playerrandom, Matrix),
	writeTrace(playerrandom, '[playerRandom] '),
	writeTrace(playerrandom, 'I want to put a pawn in the column '),
	writeTrace(playerrandom, ColumnWanted),
	writeTrace(playerrandom, '.\n').

testPlayerRandomBasics :-
	testPlayerRandomGridAlmostFull(M),
	privateTestPlayerRandomUtil(M),
	testPlayerRandomGrid2MovesPossible(M2),
	privateTestPlayerRandomUtil(M2).


testAllPlayerRandom :-
    test(testPlayerRandomBasics).
