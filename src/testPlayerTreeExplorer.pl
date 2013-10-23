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
testEvaluateColumn(Column, Value) :- 
		gameNewGrid(Grid),
		gamePlay(Grid, 1, 1, ResGrid),
		gamePlay(ResGrid, 1, 2, ResGrid2),
		gamePlay(ResGrid2, 1, 1, ResGrid3),
		gamePrintGrid(ResGrid3),
		evaluateColumn(ResGrid3, Column, 1, Value).
		
testEvaluateLine(Column, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 2, ResGrid2),
	gamePlay(ResGrid2, 6, 1, ResGrid3),
	gamePlay(ResGrid3, 5, 1, ResGrid4),
	gamePlay(ResGrid4, 3, 1, ResGrid5),
	gamePrintGrid(ResGrid5),
	evaluateLine(ResGrid5, Column, 1, Value).
	
testEvaluateDiago1(Column, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 4, 2, ResGrid10),
	gamePlay(ResGrid10, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePrintGrid(ResGrid15),
	evaluateDiago1(ResGrid15, Column, 1, Value).
	
testEvaluateDiago2(Column, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 4, 2, ResGrid10),
	gamePlay(ResGrid10, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePlay(ResGrid15, 2, 2, ResGrid16),
	gamePrintGrid(ResGrid16),
	evaluateDiago2(ResGrid16, Column, 1, Value).
	
	
testEvaluateCurrentPlayer(Column, PlayerId, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePlay(ResGrid15, 2, 2, ResGrid16),
	gamePlay(ResGrid16, 7, 1, ResGrid17),
	gamePrintGrid(ResGrid17),
	evaluateCurrentPlayer(ResGrid17, Column, PlayerId, Value).
	
	
testEvaluateOtherPlayer(Column, PlayerId, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 4, 2, ResGrid10),
	gamePlay(ResGrid10, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePlay(ResGrid15, 2, 2, ResGrid16),
	gamePlay(ResGrid16, 7, 1, ResGrid17),
	gamePrintGrid(ResGrid17),
	evaluateOtherPlayer(ResGrid17, Column, PlayerId, Value).


testDistanceLine(Column, PlayerId, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePlay(ResGrid15, 2, 2, ResGrid16),
	gamePrintGrid(ResGrid16),	
	distanceLine(ResGrid16, Column, PlayerId, Value).
	
testDistanceColumn(Column, PlayerId, Value) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePlay(ResGrid15, 2, 2, ResGrid16),
	gamePrintGrid(ResGrid16),	
	distanceColumn(ResGrid16, Column, PlayerId, Value).
	
testDistanceDiago(Column, PlayerId, V1, V2) :-
	gameNewGrid(Grid),
	gamePlay(Grid, 1, 1, ResGrid),
	gamePlay(ResGrid, 2, 1, ResGrid2),
	gamePlay(ResGrid2, 2, 2, ResGrid3),
	gamePlay(ResGrid3, 3, 1, ResGrid5),
	gamePlay(ResGrid5, 3, 1, ResGrid6),
	gamePlay(ResGrid6, 3, 1, ResGrid7),
	gamePlay(ResGrid7, 4, 2, ResGrid8),
	gamePlay(ResGrid8, 4, 2, ResGrid9),
	gamePlay(ResGrid9, 5, 1, ResGrid11),
	gamePlay(ResGrid11, 5, 1, ResGrid12),
	gamePlay(ResGrid12, 5, 1, ResGrid13),
	gamePlay(ResGrid13, 5, 1, ResGrid14),
	gamePlay(ResGrid14, 5, 1, ResGrid15),
	gamePlay(ResGrid15, 2, 2, ResGrid16),
	gamePlay(ResGrid16, 7, 1, ResGrid17), 
	gamePrintGrid(ResGrid17),	
	distanceDiago1(ResGrid17, Column, PlayerId, V1),
	distanceDiago2(ResGrid17, Column, PlayerId, V2).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How to call this player
% gameProcess(playerTreeExplorer, playerRandom, Result).
% gameProcess(playerTreeExplorer, playerHuman, Result).
	