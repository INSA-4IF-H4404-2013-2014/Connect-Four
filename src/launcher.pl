
%% TODO : delete write()
%% TODO : get real AIs and gameOver

:- [gameCore].

%%%%%%%%%%%%
% Test datas
%%%%%%%%%%%%
iaTest1(_, 1).
iaTest2(_, 2).

gameOver(Grid, Result) :- gameGridGet(Grid, Result, 4, Result).
%%%%%%%%%%%%

%%%%%%%%%%%%
% Launch predicate
%%%%%%%%%%%%

% =============================================
% launch(Player1, Player2, Result)
% ----------------------------------
% Player1 and Player2 are the two AIs names
% Result is the ID of the winner (0 if draw)
% =============================================

% Initialize a matrix full of 0 and start launch(Grid, Player1, Player2, Result, CurrentPlayer)
launch(Player1, Player2, Result) :- write('Debut'), gameNewGrid(Grid), launch(Grid, Player1, Player2, Result, 1).

% Check for the first time if the game is over
launch(Grid, _, _, Result, _) :- write('Game over ?'), gameOver(Grid, Result).

% Let the Player1 choose the column in which he wants to play
% Put the pawn in the right column
% Calls launch for Player2
launch(Grid, Player1, Player2, Result, 1) :- 
	write('1'),
	call(Player1, Grid, NumCol),
	gamePlay(Grid, NumCol, 1, ResGrid),
	launch(ResGrid, Player1, Player2, Result, 2).

% Same as precedent call with Player2 playing
launch(Grid, Player1, Player2, Result, 2) :- 
	write('2'),
	call(Player2, Grid, NumCol),
	gamePlay(Grid, NumCol, 2, ResGrid),
	launch(ResGrid, Player1, Player2, Result, 1).
