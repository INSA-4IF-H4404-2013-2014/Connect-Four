:- [gameCore].

%%%%%%%%%%%%% Lauches the Tree Explorer Player and get its move decision %%%%%%%%%%%%%%%
% Matrix is the game grid
% The second parameter is the player number
% ColumnIndexWanted is the column of the move chosen by the Player (return value)
%playerTreeExplorer(Grid, Id, NumCol).

maxDepth(1).


%%%%%%%%%%%%%%%%%%%%%%
%BUGS ACTUELS :
%L'Player ne divise pas ses branches, toutes les branches sont dans la même grille, donc 
%elle met les pions dans les colonnes unes à unes
%Solution : Une fonction de plus qui s'appelle elle même avec incrémentation du n° de colonne
%et appel à la fonction privatePlayerTreeExplorer
%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If the current column play allow us to win the game, we return the column number
%=> Replace _ by 1 in order to stop only if we can immedplayertly win (else use the two Plays law)
% If we are not at the depth 1, we have to check if the other player has won, then backtrack
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Peu importe la profondeur actuelle, on vérifie si l'un des joueurs a gagné

%Si le joueur 1 a gagné, la première colonne jouée est celle du coup à jouer

privatePlayerTreeExplorer(Grid, Id, NumCol, _, Depth, Plays, _, Id) :- 
		length(Plays, L),
		listFetch(Plays, L, LastPlay),
		gameOver(Grid, LastPlay, Id),
		write('Coup gagnant'),
		write('depth='),write(Depth),nl,
		write('grid='),write(Grid),nl,
		write('lastPlay='),write(LastPlay),nl,
		write('id='),write(Id),
		NumCol is LastPlay.
		
%Si l'autre joueur a gagné, et que la profondeur est à 1, il faut jouer immédplayertement
% le coup pour l'empêcher
% Sinon, c'est une branche morte

privatePlayerTreeExplorer(Grid, Id, NumCol, _, Depth, _, OpponentPlays, IdToPlay) :-
		Id \= IdToPlay,
		length(OpponentPlays, L),
		listFetch(OpponentPlays, L, LastPlay),
		gameOver(Grid, LastPlay, IdToPlay),
		
		%If depth = 1 : we have to play where the opponent can win
		maxDepth(Depth) ->
		write('Contre coup'),
		NumCol is LastPlay ;
		
		%Else : dead branch
		write('5'),
		fail.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If the maximal depth has been reached, we play random => IMPROVEMENT : Play where
%the maximal aligned pawn number is the highest
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%7

%Condition d'arrêt : Dans le cas (voir ci-dessus) ou aucun joueur n'a gagné,
% on vérifie la profondeur : si toutes les colonnes ont été parcourues
% et si la profondeur max est atteinte, on arrête la recherche
% et on joue random

privatePlayerTreeExplorer(Grid, Id, NumCol, _, Depth, Plays, _, _) :-
		write('4'),
		length(Plays, L),
		listFetch(Plays, L, LastPlay),
		columnsNumber(LastPlay),
		maxDepth(Depth),
		playerRandom(Grid, Id, NumCol).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next improvement : if two Plays on the same level allow us to win, that's the only play we choose !
%(instead of accepting the first winning play)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Moteur principal de l'Player, avec incrémentation des colonnes et de la profondeur de recherche

privatePlayerTreeExplorer(Grid, Id, NumCol, _, Depth, Plays, OpponentPlays, IdToPlay) :-
		length(Plays, L),
		listFetch(Plays, L, LastPlay),
		columnsNumber(LastPlay),
		write('3'),
		Depth1 is Depth + 1, privatePlayerTreeExplorer(Grid, Id, NumCol, 1, Depth1, Plays, OpponentPlays, IdToPlay).
		
privatePlayerTreeExplorer(Grid, Id, NumCol, NextCol, Depth, Plays, OpponentPlays, IdToPlay) :-
		write('2'),
		gamePlay(Grid, NextCol, IdToPlay, Result),
		(
			(Id == IdToPlay, append(Plays, [NextCol], Plays2), OpponentPlays2 = OpponentPlays) ;
			(append(OpponentPlays, [NextCol], OpponentPlays2), Plays2 = Plays)
		),
		NextCol1 is NextCol + 1,
		privatePlayerTreeExplorer(Result, Id, NumCol, NextCol1, Depth, Plays2, OpponentPlays2, IdToPlay).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Player call
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Appel initplayerl

playerTreeExplorer(Grid, Id, NumCol) :-
		write('1'),
		privatePlayerTreeExplorer(Grid, Id, NumCol, 1, 1, [], [], Id).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% launch(playerTreeExplorer, playerTest1, R).
