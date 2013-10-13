
%% TODO : delete write()
%% TODO : get real AIs and gameOver

:- [gameCore].
:- [gameOver].
:- [testUtil].

%%%%%%%%%%%%
% Launch predicate
%%%%%%%%%%%%

% =============================================
% launch(Player1, Player2, Result)
% ----------------------------------
% Player1 and Player2 are the two AIs names
% Result is the ID of the winner (0 if draw)
% =============================================

% =============================================
% privateLaunch(Grid, Player1, Player2, Result, NumCol, CurrentPlayer).
% ----------------------------------
% Player1 and Player2 are the two AIs names
% Result is the ID of the winner (0 if draw)
% Grid is the grid where to play
% NumCol is the last column played
% X is the player who has to play
% =============================================

% =============================================
% an IA has the form of ia( Grid, NumPlay, NumCol)
% where Grid is the current grid
% NumPlay is the number of the ia (player 1 or player 2)
% NumCol is the number of column where the ia want to play next
% =============================================

% Initialize a matrix full of 0 and start privateLaunch/6
launch(Player1, Player2, Result) :-
	gameNewGrid(Grid), 
	call(Player1, Grid, 1, NumCol),
	gamePlay(Grid, NumCol, 1, ResGrid),
	writeTrace(game, ' p1 : '),
	writeTrace(game, NumCol),
	writeTrace(game, '\n'),
	privateLaunch(ResGrid, Player1, Player2, Result, NumCol, 2),
	writeTrace(game, 'Res : '),
	writeTrace(game, Result),
	writeTrace(game, '\n').

% Check if the game is over before a new play
privateLaunch(Grid, _, _, Result, NumCol, _) :-	gameOver(Grid, NumCol, Result).

% Let the Player1 choose the column in which he wants to play
% Put the pawn in the right column
% Calls privateLaunch for Player2
privateLaunch(Grid, Player1, Player2, Result, _, 1) :-
	call(Player1, Grid, 1, NewNum),
	gameIsValidePlay(Grid, NewNum),
	gamePlay(Grid, NewNum, 1, ResGrid),
	writeTrace(game, ' p1 : '),
	writeTrace(game, NewNum),
	writeTrace(game, '\n'),
	privateLaunch(ResGrid, Player1, Player2, Result, NewNum, 2).

% Same as precedent call with Player2 playing
privateLaunch(Grid, Player1, Player2, Result, _, 2) :-
	call(Player2, Grid, 2, NewNum),
	gameIsValidePlay(Grid, NewNum),
	gamePlay(Grid, NewNum, 2, ResGrid),
	writeTrace(game, ' p2 : '),
	writeTrace(game, NewNum),
	writeTrace(game, '\n'),
	privateLaunch(ResGrid, Player1, Player2, Result, NewNum, 1).

