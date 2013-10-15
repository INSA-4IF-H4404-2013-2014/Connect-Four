:- [gameCore].

%%%%%%%%%%%%%%% Lauches the IA Tree Explorer and get its move decision %%%%%%%%%%%%%%%%
% Matrix is the game grid
% The second parameter is the player number
% ColumnIndexWanted is the column of the move chosen by the IA (return value)
%iaTreeExplorer(Grid, Id, NumCol).

maxDepth(4).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If the current column play allow us to win the game, we return the column number
%=> Replace _ by 1 in order to stop only if we can immediatly win (else use the two Plays law)
% If we are not at the depth 1, we have to check if the other player has won, then backtrack
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaTreeExplorer(Grid, Id, NumCol, _, _, Id) :-
		gameOver(Grid, NumCol, Id).
		
privateIaTreeExplorer(Grid, _, NumCol, _, _, IdToPlay) :-
		gameOver(Grid, NumCol, IdToPlay), fail.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If the maximal depth has been reached, we play random => IMPROVEMENT : Play where
%the maximal aligned pawn number is the highest
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaTreeExplorer(Grid, Id, NumCol, maxDepth, _, _) :-
		iaRandom(Grid, Id, NumCol).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next improvement : if two Plays on the same level allow us to win, that's the only play we choose !
%(instead of accepting the first winning play)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaTreeExplorer(Grid, Id, columnsNumber + 1, Depth, Plays, _) :-
		Depth1 is Depth + 1, privateIaTreeExplorer(Grid, Id, 1, Depth1, Plays).
		
privateIaTreeExplorer(Grid, Id, NumCol, Depth, Plays, IdToPlay) :-
		NumCol1 is NumCol + 1,
		gamePlay(Grid, NumCol, IdToPlay, Result),
		((Id == IdToPlay, append(Plays, [NumCol], Plays2)) ; (Id \= IdToPlay)), 
		privateIaTreeExplorer(Result, Id, NumCol1, Depth, Plays2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IA call%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iaTreeExplorer(Grid, Id, NumCol) :-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		privateIaTreeExplorer(Grid, Id, NumCol, 1, [], Id).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
