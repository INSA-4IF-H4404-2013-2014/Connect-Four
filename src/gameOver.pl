
:- [gameCore].

% Returns whether the Grid is full or not
gameGridIsFull([]).
gameGridIsFull([T|M]) :- length(T,N), linesNumber(LN), N == LN, gameGridIsFull(M).

% Check if there is 4 pawns of the same color in one diagonal
privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, TopLine, CurrentLine, Player) :- fail.

% Check if there is 4 pawns of the same color in one line
privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, CurrentColumn, TopLine, Player) :- fail.

% Check if there is 4 pawns of the same color in one column
privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, CurrentLine, Player) :- fail.

% Check if a player won (P is the player, M the grid)
gamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :- privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, TopLine, TopLine, Player).
gamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :- privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, Player).
gamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :- privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, TopLine, Player).


% Checks if the game is over
gameOver(Matrix, LastColumPlayed, Player) :- 
	gameColumnHeight(Matrix, LastColumnPlayed, TopLine),
	gameGridGet(Matrix, LastColumPlayed, TopLine, Player),
	gamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player).
gameOver(Matrix, LastColumPlayed, 0) :- gameGridGet(Matrix, LastColumPlayed, 1, _), gameGridIsFull(Matrix).
