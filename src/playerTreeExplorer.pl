:- [gameCore].

%%%%%%%%%%%%% Lauches the Tree Explorer Player and get its move decision %%%%%%%%%%%%%%%
% Matrix is the game grid
% The second parameter is the player number
% ColumnIndexWanted is the column of the move chosen by the Player (return value)
%playerTreeExplorer(Grid, Id, NumCol).

maxDepth(4).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If the current column play allow us to win the game, we return the column number
%=> Replace _ by 1 in order to stop only if we can immediatly win (else use the two Plays law)
% If we are not at the depth 1, we have to check if the other player has won, then backtrack
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, Id, NumCol, _, _, Plays, Id) :-
		gameOver(Grid, NumCol, Id),
		length(Plays, L),
		listFetch(Plays, L, LastPlay),
		NumCol is LastPlay.
		
privatePlayerTreeExplorer(Grid, _, NumCol, _, _, _, IdToPlay) :-
		gameOver(Grid, NumCol, IdToPlay), fail.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If the maximal depth has been reached, we play random => IMPROVEMENT : Play where
%the maximal aligned pawn number is the highest
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, Id, NumCol, _, maxDepth, _, _) :-
		playerRandom(Grid, Id, NumCol).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next improvement : if two Plays on the same level allow us to win, that's the only play we choose !
%(instead of accepting the first winning play)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, Id, NumCol, _, Depth, Plays, IdToPlay) :-
		length(Plays, L),
		listFetch(Plays, L, columnsNumber + 1),
		Depth1 is Depth + 1, privatePlayerTreeExplorer(Grid, Id, NumCol, 1, Depth1, Plays, IdToPlay).
		
privatePlayerTreeExplorer(Grid, Id, NumCol, NextCol, Depth, Plays, IdToPlay) :-
		gamePlay(Grid, NextCol, IdToPlay, Result),
		((Id == IdToPlay, append(Plays, [NextCol], Plays2)) ; (Id \= IdToPlay)), 
		NextCol1 is NextCol + 1,
		privatePlayerTreeExplorer(Result, Id, NumCol, NextCol1, Depth, Plays2, IdToPlay).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Player call
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
playerTreeExplorer(Grid, Id, NumCol) :-
		privatePlayerTreeExplorer(Grid, Id, NumCol, 1, 1, [], Id).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% launch(playerTreeExplorer, playerTest1, R).
