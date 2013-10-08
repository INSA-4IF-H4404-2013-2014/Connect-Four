:- [gameGrid].

% Checks if the grid is full
% Just call gridIsFull from outside.
privateGridIsFull(7) :- gameGrid(7, 6, _). 
privateGridIsFull(Number) :- gameGrid(Number, 6, _), Next is Number + 1, privateGridIsFull(Next).
gridIsFull :- privateGridIsFull(1).

% Checks if the game is over
gameOver(1) :- playerWon(1).
gameOver(2) :- playerWon(2).
gameOver(0) :- columnsNumber(X), gridIsFull(X).



testGridIsFull :-
	not(gridIsFull),
	assert(gameGrid(1,6,1)),
	assert(gameGrid(2,6,1)),
	assert(gameGrid(3,6,1)),
	assert(gameGrid(4,6,1)),
	assert(gameGrid(5,6,1)),
	assert(gameGrid(6,6,1)),
	assert(gameGrid(7,6,1)),
	gridIsFull,
	retract(gameGrid(1,6,1)),
	not(gridIsFull),
	assert(gameGrid(1,6,1)),
	gridIsFull,
	retract(gameGrid(4,6,2)),
	not(gridIsFull).

test :-
	testGridIsFull.
