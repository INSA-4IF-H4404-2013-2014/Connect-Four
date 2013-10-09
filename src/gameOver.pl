
:- [gameCore].

% Returns whether the Grid is full or not
gameGridIsFull([]).
gameGridIsFull([T|M]) :- length(T,N), linesNumber(LN), N == LN, gameGridIsFull(M).

% Check if there is 4 pawns of the same color in one diagonal
% privateWonDiagonal(P,M) :-

% Check if there is 4 pawns of the same color in one column
% privateWonColumn(P,M) :-

% Check if a player won (P is the player, M the grid)
gamePlayerWon(P,M) :- privateGameWonDiagonal(P,M).
gamePlayerWon(P,M) :- privateGameWonLine(P,M).
gamePlayerWon(P,M) :- privateGameWonColumn(P,M).


% Checks if the game is over
gameOver(1) :- gamePlayerWon(1).
gameOver(2) :- gamePlayerWon(2).
gameOver(0) :- columnsNumber(X), gameGridIsFull(X).
