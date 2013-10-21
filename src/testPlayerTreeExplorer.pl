:- [playerTreeExplorer].
:- [playerRandom].
:- [gameCore].
:- [gameProcess].

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
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How calling this player
% gameProcess(playerTreeExplorer, playerRandom, Result).
	