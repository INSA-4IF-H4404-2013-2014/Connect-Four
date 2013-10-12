:- [gameCore].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Returns whether the Grid is full or not %%%%%%%%%%%%%%%%%%%
gameGridIsFull([]).
gameGridIsFull([T|M]) :- length(T,N), linesNumber(LN), N == LN, gameGridIsFull(M).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Check if there is 4 pawns of the same color in the 4 sub-diagonals %%%%%%
privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn, TopLine, CurrentLine, Player, ColumnDirection, LineDirection) :-
	Delta is abs(LastColumnPlayed - CurrentColumn),
	Delta >= 4 ;
	gameGridGet(Matrix, CurrentColumn, CurrentLine, Player),
	CurrentColumn2 is (CurrentColumn + ColumnDirection),
	CurrentLine2 is (CurrentLine + LineDirection),
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn2, TopLine, CurrentLine2, Player, ColumnDirection, LineDirection).

privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn, TopLine, CurrentLine, Player) :-
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn, TopLine, CurrentLine, Player, -1, -1) ;
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn, TopLine, CurrentLine, Player, 1, 1) ;
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn, TopLine, CurrentLine, Player, -1, 1) ;
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, CurrentColumn, TopLine, CurrentLine, Player, 1, -1).

privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, TopLine, Player).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Check if there is 4 pawns of the same color in one line %%%%%%%%%%%%
%privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, CurrentColumn, TopLine, Player) :- fail.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Check if there is 4 pawns of the same color in one column %%%%%%%%%%%
privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, CurrentLine, Player) :-
	Delta is (TopLine - CurrentLine),
	Delta >= 4 ;
	gameGridGet(Matrix, LastColumnPlayed, CurrentLine, Player),
	CurrentLine2 is (CurrentLine - 1),
	privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, CurrentLine2, Player).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Check if a player won %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateGamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, TopLine, Player).
%privateGamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :-
	%privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, Player).
privateGamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, TopLine, Player).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Checks if the game is over %%%%%%%%%%%%%%%%%%%%%%%%%%
gameOver(Matrix, LastColumPlayed, Player) :- 
	gameColumnHeight(Matrix, LastColumnPlayed, TopLine),
	gameGridGet(Matrix, LastColumPlayed, TopLine, Player),
	privateGamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player).
gameOver(Matrix, LastColumPlayed, 0) :- gameGridGet(Matrix, LastColumPlayed, 1, _), gameGridIsFull(Matrix).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
