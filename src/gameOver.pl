:- [gameCore].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Returns whether the Grid is full or not %%%%%%%%%%%%%%%%%%%
gameGridIsFull([]).
gameGridIsFull([T|M]) :- length(T,N), linesNumber(LN), N == LN, gameGridIsFull(M).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Checks if there are 4 pawns of the same color in the 2 diagonals %%%%%%%%
privateGamePlayerWonStarCheckDiagonalRoutine(Matrix, ReferenceColumn, CurrentColumn, TopLine, CurrentLine, Player, Direction) :-
	numberOfAlignedPawnsToWin(AlignedPawnsToWin),
	Delta is abs(ReferenceColumn - CurrentColumn),
	Delta >= AlignedPawnsToWin ;
	gameGridGet(Matrix, CurrentColumn, CurrentLine, Player),
	CurrentColumn2 is (CurrentColumn + Direction),
	CurrentLine2 is (CurrentLine - 1),
	privateGamePlayerWonStarCheckDiagonalRoutine(Matrix, ReferenceColumn, CurrentColumn2, TopLine, CurrentLine2, Player, Direction).

privateGamePlayerWonStarCheckDiagonal(Matrix, LastPlayedColumn, CurrentColumn, TopLine, CurrentLine, Player, Direction) :-
	gameGridGet(Matrix, CurrentColumn, CurrentLine, Player),
	CurrentColumn2 is (CurrentColumn - Direction),
	CurrentLine2 is (CurrentLine + 1),
	(
		privateGamePlayerWonStarCheckDiagonal(Matrix, LastPlayedColumn, CurrentColumn2, TopLine, CurrentLine2, Player, Direction) ;
		privateGamePlayerWonStarCheckDiagonalRoutine(Matrix, CurrentColumn, CurrentColumn, CurrentLine, CurrentLine, Player, Direction)
	).

privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, TopLine, Player, 1) ;
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, TopLine, Player, -1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Checks if there are 4 pawns of the same color in the one line %%%%%%%%%%
privateGamePlayerWonStarCheckLineRoutine(Matrix, ReferenceColumn, CurrentColumn, TopLine, Player, Direction) :-
	numberOfAlignedPawnsToWin(AlignedPawnsToWin),
	Delta is abs(ReferenceColumn - CurrentColumn),
	Delta >= AlignedPawnsToWin ;
	gameGridGet(Matrix, CurrentColumn, TopLine, Player),
	CurrentColumn2 is (CurrentColumn + Direction),
	privateGamePlayerWonStarCheckLineRoutine(Matrix, ReferenceColumn, CurrentColumn2, TopLine, Player, Direction).

privateGamePlayerWonStarCheckLine(Matrix, LastPlayedColumn, CurrentColumn, TopLine, Player, Direction) :-
	gameGridGet(Matrix, CurrentColumn, TopLine, Player),
	CurrentColumn2 is (CurrentColumn - Direction),
	(
		privateGamePlayerWonStarCheckLine(Matrix, LastPlayedColumn, CurrentColumn2, TopLine, Player, Direction) ;
		privateGamePlayerWonStarCheckLineRoutine(Matrix, CurrentColumn, CurrentColumn, TopLine, Player, Direction)
	).

privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, Player, 1) ;
	privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, LastColumnPlayed, TopLine, Player, -1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Checks if there are 4 pawns of the same color in one column %%%%%%%%%%%
privateGamePlayerWonStarCheckColumnRoutine(Matrix, LastColumnPlayed, TopLine, CurrentLine, Player) :-
	numberOfAlignedPawnsToWin(AlignedPawnsToWin),
	Delta is abs(TopLine - CurrentLine),
	Delta >= AlignedPawnsToWin ;
	gameGridGet(Matrix, LastColumnPlayed, CurrentLine, Player),
	CurrentLine2 is (CurrentLine - 1),
	privateGamePlayerWonStarCheckColumnRoutine(Matrix, LastColumnPlayed, TopLine, CurrentLine2, Player).

privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckColumnRoutine(Matrix, LastColumnPlayed, TopLine, TopLine, Player);
	TopLine1 is TopLine + 1,
	gameGridGet(Matrix, LastColumnPlayed, TopLine1, Player),
	privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine1, Player).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Checks if a player won %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateGamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player) :-
	privateGamePlayerWonStarCheckDiagonal(Matrix, LastColumnPlayed, TopLine, Player) ;
	privateGamePlayerWonStarCheckLine(Matrix, LastColumnPlayed, TopLine, Player) ;
	privateGamePlayerWonStarCheckColumn(Matrix, LastColumnPlayed, TopLine, Player).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Checks if the game is over %%%%%%%%%%%%%%%%%%%%%%%%%%
% Returns true if game is over:
%	"Player" variable will get
%		- 0 for draw match,
%		- 1 if player1 won,
%		- 2 if player2 won.
% Returns false if game is not over yet.
% the "LastColumnPlayed" parameter is used to simplify the search
% the matrix should contains the lastColumnPlayed move
gameOver(Matrix, LastColumnPlayed, Player) :-
	gameColumnHeight(Matrix, LastColumnPlayed, TopLine),
	gameGridGet(Matrix, LastColumnPlayed, TopLine, Player),
	privateGamePlayerWon(Matrix, LastColumnPlayed, TopLine, Player).
gameOver(Matrix, LastColumnPlayed, 0) :- gameGridGet(Matrix, LastColumnPlayed, 1, _), gameGridIsFull(Matrix).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
