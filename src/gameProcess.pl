
:- [gameCore].
:- [gameOver].
:- [traceUtils].

%%%%%%%%%%%%
% GameProcess predicate
%%%%%%%%%%%%

% =============================================
% gameProcess(Player1, Player2, Result)
% ----------------------------------
% Player1 and Player2 are the two AIs names
% Result is the ID of the winner (0 if draw)
% =============================================

% =============================================
% privateGameProcess(Grid, Player1, Player2, Result, NumCol, CurrentPlayer).
% ----------------------------------
% Player1 and Player2 are the two AIs names
% Result is the ID of the winner (0 if draw)
% Grid is the grid where to play
% NumCol is the last column played
% X is the player who has to play
% =============================================

% =============================================
% a Player has the form of player( Grid, NumPlay, NumCol)
% where Grid is the current grid
% NumPlay is the number of the player (1 or 2)
% NumCol is the number of column where the player wants to play next
% =============================================

% Initialize a matrix full of 0 and start privateGameProcess/6
gameProcess(Player1, Player2, Result) :-
	gameNewGrid(Grid), 
	call(Player1, Grid, 1, NumCol),
	(NumCol==0; gameIsValidePlay(Grid, NumCol) ,
		gamePlay(Grid, NumCol, 1, ResGrid),
		writeTrace(game, Player1),
		writeTrace(game, ' has played '),
		writeTrace(game, NumCol),
		writeTrace(game, '\n'),
		gridTrace(game, ResGrid)),
	privateGameProcess(ResGrid, Player1, Player2, Result, NumCol, 2),
	writeTrace(game, 'Res : '),
	writeTrace(game, Result),
	writeTrace(game, '\n'), !.

% Check if someone has abandonned
privateGameProcess(_, _, _, Result, 0, Result).

% Check if the game is over before a new play
privateGameProcess(Grid, _, _, Result, NumCol, _) :-	gameOver(Grid, NumCol, Result), !.

% Let the Player1 choose the column in which he wants to play
% Put the pawn in the right column
% Calls privateGameProcess for Player2
privateGameProcess(Grid, Player1, Player2, Result, _, 1) :-
	call(Player1, Grid, 1, NewNum),
	(NewNum==0; gameIsValidePlay(Grid, NewNum),
		gamePlay(Grid, NewNum, 1, ResGrid),
		writeTrace(game, Player1),
		writeTrace(game, ' has played '),
		writeTrace(game, NewNum),
		writeTrace(game, '\n'),
		gridTrace(game, ResGrid)),
	privateGameProcess(ResGrid, Player1, Player2, Result, NewNum, 2).

% Same as precedent call with Player2 playing
privateGameProcess(Grid, Player1, Player2, Result, _, 2) :-
	call(Player2, Grid, 2, NewNum),
	(NewNum==0;gameIsValidePlay(Grid, NewNum),
		gamePlay(Grid, NewNum, 2, ResGrid),
		writeTrace(game, Player2),
		writeTrace(game, ' has played '),
		writeTrace(game, NewNum),
		writeTrace(game, '\n'),
		gridTrace(game, ResGrid)),
	privateGameProcess(ResGrid, Player1, Player2, Result, NewNum, 1).

