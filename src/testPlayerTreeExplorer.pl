:- [playerTreeExplorer].
:- [playerRandom].
:- [gameCore].
:- [gameProcess].
:- [playerTreeExplorer].
:- [main].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Annexe functions

testRemoveXValues :- 
	removeXValues([], R),
	removeXValues([1, 2, 3, 4], R),
	removeXValues([x], R),
	removeXValues([x, 1, 2, 3, x, 4, x], R).

testGetMax :- 
	not(getMax([], Max)),
	getMax([1], Max),
	getMax([1,3,5,10,2], Max).
	
testGetMin :-
	not(getMin([], Min)),
	getMin([1], Min),
	getMin([1,3,5,0,10,2], Min).
	
testIndexOf :- 
	not(indexOf([], 2, Idx)),
	indexOf([1], 1, Idx),
	indexOf([x,1,2,x,3,4,x], 4, Idx),
	indexOf([x,1,2,4,x,3,4,x], 4, Idx).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evaluate function	
% Mini-test for evaluateColumn
testEvaluate(Value) :- 
		gameNewGrid(Grid),
		gamePlay(Grid, 1, 1, ResGrid),
		gamePlay(ResGrid, 1, 1, ResGrid2),
		gamePlay(ResGrid2, 1, 2, ResGrid3),
		evaluateColumn(ResGrid3, 1, 1, Value).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How to call this player
% gameProcess(playerTreeExplorer, playerRandom, Result).
	