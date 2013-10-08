:- [gameGrid].

gridIsFull([]).
gridIsFull([T|M]) :- length(T,N), linesNumber(LN), N == LN, gridIsFull(M).

% Checks if the game is over
gameOver(1) :- playerWon(1).
gameOver(2) :- playerWon(2).
gameOver(0) :- columnsNumber(X), gridIsFull(X).

fullGrid([[1,1,1,2,1,1],[1,1,1,1,2,1],[1,2,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,2],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

almostFullGrid([[1,1,1,2,1,1],[1,1,1,1,2,1],[2,1,2,1,1,1],[1,1,1,1,1,1],[1,1,1,1,2],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

testGridIsFull :-
	fullGrid(X), gridIsFull(X),
	almostFullGrid(Y), not(gridIsFull(Y)).

test :-
	testGridIsFull.
