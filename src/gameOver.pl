:- [gameGrid].

% Returns whether the Grid is full or not
gridIsFull([]).
gridIsFull([T|M]) :- length(T,N), linesNumber(LN), N == LN, gridIsFull(M).

% Check if there is 4 pawns of the same color in one diagonal
% privateWonDiagonal(P,M) :-

% Check if there is 4 pawns of the same color in one column
% privateWonColumn(P,M) :-

% Check if a player won (P is the player, M the grid)
playerWon(P,M) :- privateWonDiagonal(P,M).
playerWon(P,M) :- privateWonLine(P,M).
playerWon(P,M) :- privateWonColumn(P,M).


% Checks if the game is over
gameOver(1) :- playerWon(1).
gameOver(2) :- playerWon(2).
gameOver(0) :- columnsNumber(X), gridIsFull(X).







% UNIT TESTS
fullGrid([[1,1,1,2,1,1],[1,1,1,1,2,1],[1,2,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,2],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

almostFullGrid([[1,1,1,2,1,1],[1,1,1,1,2,1],[2,1,2,1,1,1],[1,1,1,1,1,1],[1,1,1,1,2],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

testGridIsFull :-
	fullGrid(X), gridIsFull(X),
	almostFullGrid(Y), not(gridIsFull(Y)),
	not(gridIsFull([[], [], [], [], [], [], []])).

test :-
	testGridIsFull.
