:- [gameCore].
:- [gameSmart].

%%%%%%%%%%%%% Lauches the Player Random and get its move decision %%%%%%%%%%%%%%
% Matrix is the game grid
% The second parameter is the player number
% ColumnIndexWanted is the column of the move chosen by the Player (return val)
playerRandom(Matrix, _, ColumnIndexWantedMove) :-
	gameRemainingPlays(Matrix, Indexes),
	length(Indexes, NumberOfPossibleMoves),
	%Please don't touch this code. There is a bug on Ubuntu, only the form
	%"A is random(X)" works. Cannot use other forms of random.
	%http://comments.gmane.org/gmane.comp.ai.prolog.swi/15929
	MoveWantedTmp is random(NumberOfPossibleMoves),
	MoveWanted is (MoveWantedTmp + 1),
	listFetch(Indexes, MoveWanted, ColumnIndexWantedMove).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% Lauches the Player Random Smart and get its move decision %%%%%%%%%%%%%%
% Matrix is the game grid
% PlayerId is the player number
% ColumnId is the index of the column in which the AI wants to play

% Play if the player has or winning move or can counter the opponent in the appropriate column
playerRandomSmart(Matrix, PlayerId, ColumnId) :-
	gameObviousMove(Matrix, PlayerId, ColumnId).

% If no winning or counter move is available, play a random move
playerRandomSmart(Matrix, PlayerId, ColumnId) :-
	playerRandom(Matrix, PlayerId, ColumnId).