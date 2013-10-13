
%% TODO : delete write()
%% TODO : get real AIs and gameOver

:- [gameCore].
:- [gameOver].

%%%%%%%%%%%%
% Test datas
%%%%%%%%%%%%
iaTest1(_, 1).
iaTest2(_, 2).

%gameOver(Grid, Result) :- gameColumnHeight(Grid, Result, 4).
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

test(Result) :- gameNewGrid(Matrix), gamePlay(Matrix, 1, 1, NewMatrix), gameGridGet(NewMatrix, 1, 2, Result).

% Initialize a matrix full of 0 and start launch(Grid, Player1, Player2, Result, CurrentPlayer)
launch(Player1, Player2, Result) :- gameNewGrid(Grid), launch(Grid, _, Player1, Player2, Result, 1).

% Check for the first time if the game is over
launch(Grid, Lastcolumn, _, _, Result, _) :- gameOver(Grid, Lastcolumn, Result).

% Let the Player1 choose the column in which he wants to play
% Put the pawn in the right column
% Calls launch for Player2
launch(Grid, _, Player1, Player2, Result, 1) :-
	call(Player1, Grid, NumCol),
	gamePlay(Grid, NumCol, 1, ResGrid),
	launch(ResGrid, NumCol, Player1, Player2, Result, 2).

% Same as precedent call with Player2 playing
launch(Grid, _, Player1, Player2, Result, 2) :-
	call(Player2, Grid, NumCol),
	gamePlay(Grid, NumCol, 2, ResGrid),
	launch(ResGrid, NumCol, Player1, Player2, Result, 1).
