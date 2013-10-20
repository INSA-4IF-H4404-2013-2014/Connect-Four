:- [gameCore].

%privatePlayerTreeExplorer(Grid, IdPlayer, NumCol, NextCol, Evaluations, Depth, CurrentPlayer)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Évaluation d'une grille de jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
evaluate(_, _, _, 1).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonctions requises par l'algo MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% removeXValues(List, Result) <=> Result = List\x
% Remove x values
%%%%%%%%%%%%%%%%%%%%
removeXValues([], []).
removeXValues([x|L], L1) :- removeXValues(L, L1).
removeXValues([T|L], [T|L1]) :- removeXValues(L, L1). 


%%%%%%%%%%%%%%%%%%%%
% getMax(List, Max) <=> Max = getMax(List)
% Retourne le plus grand élément présent dans une liste (x est une valeur à skipper)
%%%%%%%%%%%%%%%%%%%%
getMax([Max], Max).
getMax([T|L], Max) :- getMax(L, Max1), (T >= Max1, Max = T; T < Max1, Max = Max1).



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% Retourne le plus petit élément présent dans une liste (x est une valeur à skipper)
%%%%%%%%%%%%%%%%%%%%
getMin([Min], Min).
getMin([x|L], Min) :- getMin(L, Min).
getMin([T|L], Min) :- getMin(L, Min1), (T =< Min1, Min = T; T > Min1, Min = Min1).


%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% Retourne l'index du premier élément égal à Elt présent dans la liste
%%%%%%%%%%%%%%%%%%%%
indexOf([Elt|_], Elt, 1).
indexOf([_|L], Elt, Idx) :- indexOf(L, Elt, Idx1), Idx is Idx1 + 1.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si nextCol = nbMaxCol + 1 : P1
%		évaluations est une liste vide
% fin
% si profondeur maximale atteinte : P2
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en tête de la liste Evaluations le résultat de la fonction évaluation (ou x si on ne peut jouer)
%     s appeler soit-même avec la grille copiée de la grille reçue, avec nextcol = nextcol + 1
% fin
% sinon : P3
%     copier la grille reçue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s appeler soit-même avec la grille jouée, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer
%             ajouter en tête de la liste evaluations le max de la liste evaluations1 initialisée par l'appel au fils
%         sinon
%             ajouter en tête de la liste evaluations le min de la liste evaluations1 initialisée par l'appel au fils
%         fin
%	  sinon
%         ajouter en tête de la liste evaluations x
%     fin
%     s appeler soit-même avec la grille copiée de la grille reçue, avec nextcol = nextcol + 1
% fin
%%%%%
% Appel Initial :
% On calcule le max d'évaluations
% NumCol est l'indice du max
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%Profondeur maximale de recherche
%%%%%%%%%%%%%%%%%%%%
maxDepth(2).


%%%%%%%%%%%%%%%%%%%%
% P1
% si nextCol = nbMaxCol + 1 : P1
%		évaluations est une liste vide
% fin
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(_, _, NextCol, [], _, _) :-
	NextCol1 is NextCol-1 ->
	columnsNumber(NextCol1), write('col max reached') -> nl.
	

%%%%%%%%%%%%%%%%%%%%
% P2
% si profondeur maximale atteinte : P2
%     copier la grille reçue
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en tête de la liste Evaluations le résultat de la fonction évaluation (ou x si on ne peut jouer)
%     s appeler soit-même avec la grille copiée de la grille reçue, avec nextcol = nextcol + 1
% fin
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	maxDepth(Depth) ->
	write('max depth reached / depth=') -> write(Depth) -> write(' col=') -> write(NextCol) ->
	copy_term(Grid, Grid1) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		not(linesNumber(ColumnHeight)) ->
		write(' playing and evaluating') -> nl ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		gamePrintGrid(GridResult) ->  %TO DELETE
		evaluate(GridResult, NextCol, CurrentPlayer, Evaluation)
		;
		write(' can t play') -> nl ->
		Evaluation = x
	) ->
	NextCol1 is NextCol + 1 ->
	write(' calling brother node') -> nl ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, NextCol1, L, Depth, CurrentPlayer).
	
	
%%%%%%%%%%%%%%%%%%%%
% P3 : 
%     copier la grille reçue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s appeler soit-même avec la grille jouée, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer : P4
%             ajouter en tête de la liste evaluations le max de la liste evaluations1 initialisée par l'appel au fils
%         sinon : P5
%             ajouter en tête de la liste evaluations le min de la liste evaluations1 initialisée par l'appel au fils
%         fin
%	  sinon
%         ajouter en tête de la liste evaluations x
%     fin
%     s appeler soit-même avec la grille copiée de la grille reçue, avec nextcol = nextcol + 1
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	write('depth=') -> write(Depth) -> write(' col=') -> write(NextCol) ->
	copy_term(Grid, Grid1) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		not(linesNumber(ColumnHeight)) ->
		write(' playing') -> nl ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		gamePrintGrid(GridResult) -> %TO DELETE
		Depth1 is Depth + 1 ->
		write(' calling deth + 1') -> nl ->
		gameOtherPlayer(IdPlayer, NextPlayerId) ->
		privatePlayerTreeExplorer(GridResult, IdPlayer, 1, EvaluationsResult, Depth1, NextPlayerId) ->
		write(' evaluating the depth + 1 call') -> nl ->
		removeXValues(EvaluationsResult, EvaluationsResult1) ->
		(
			IdPlayer = CurrentPlayer ->
			getMax(EvaluationsResult1, Evaluation)
			;
			getMin(EvaluationsResult1, Evaluation)
		)
		;
		Evaluation = x
	) ->
	NextCol1 is NextCol + 1 ->
	write(' calling brother node') -> nl ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, NextCol1, L, Depth, CurrentPlayer).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial call
playerTreeExplorer(Grid, PlayerId, NumCol) :-
	write('=================================') -> nl ->
	write('==== TREE EXPLORER INIT CALL ====') -> nl ->
	write('=================================') -> nl -> 
	gamePrintGrid(Grid) -> %TO DELETE
	write('=================================') -> nl ->
	
	copy_term(Grid, Grid1) ->
	privatePlayerTreeExplorer(Grid1, PlayerId, 1, Evaluations, 1, PlayerId) ->
	removeXValues(Evaluations, Evaluations1) ->
	getMax(Evaluations1, Max) ->
	indexOf(Evaluations, Max, NumCol).
