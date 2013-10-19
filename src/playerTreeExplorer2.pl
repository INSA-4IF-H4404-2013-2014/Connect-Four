:- [gameCore

%privatePlayerTreeExplorer(Grid, IdPlayer, NumCol, NextCol, Evaluations, Depth, CurrentPlayer)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Évaluation d'une grille de jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonctions requises par l'algo MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Fonction simulatePlay
% 		  si l'on peut jouer dans la colonne nextCol
%		      jouer
%         	  évaluation = le résultat de la fonction d'évaluation sur la grille passée en paramètre
%		  sinon
%			  évaluation = 0
%         fin



si l'on peut jouer
%			jouer dans la colonne nextCol
%		 fin
%        	s'appeler soit-même avec une grille copiée de la grille reçue, avec nextcol = nextcol + 1
%        si l'on peut jouer
%        	ajouter en tête de la liste evaluations la valeur évaluation reçue par l'appel du fils
%        sinon
%           ajouter en tête de la liste evaluations 0
%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%
% getMax(List, Max) <=> Max = getMax(List)
% Retourne le plus grand élément présent dans une liste
%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% Retourne le plus petit élément présent dans une liste
%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% Retourne l'index du premier élément égal à Elt présent dans la liste
%%%%%%%%%%%%%%%%%%%%
indexOf([], Elt, Idx)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si hauteur maximale atteinte
%     si nextCol = nbMaxCol : P1
%         %JOUER un pion dans la colonne nextCol si possible
%         Evaluations est une liste contenant pour seul élément le résultat de la fonction évaluation (ou 0 si on ne peut jouer)
%     sinon : P2
%		  %JOUER un pion dans la colonne nextCol si possible
%         ajouter en tête de la liste Evaluations le résultat de la fonction évaluation (ou 0 si on ne peut jouer)
%     fin
% sinon
%     si nextCol = nbMaxCol : P3
%		  %JOUER un pion dans la colonne nextCol si possible
%         s'appeler soit-même avec une grille copiée de la grille jouée, avec nextcol = 1 et depth = depth + 1
%         si idplayer = currentplayer : P4
%             Evaluations est (Désactivé : mettre [MINMAX] pour activer : %une liste ayant pour seul élément%) le max de la liste evaluations1
%         sinon : P5
%             Evaluations est %une liste ayant pour seul élément% le min de la liste evaluations1
%         fin
%     sinon : P6
%        %JOUER un pion dans la colonne nextCol si possible
%        s'appeler soit-même avec une grille copiée de la grille reçue, avec nextcol = nextcol + 1
%        ajouter en tête de la liste evaluations la valeur évaluation reçue par l'appel du fils
%     fin
% fin
%%%%%
% Appel Initial :
% On calcule le max d'évaluations
% NumCol est l'indice du max
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%Profondeur maximale de recherche
%%%%%%%%%%%%%%%%%%%%
maxDepth(3).


%%%%%%%%%%%%%%%%%%%%
% P0 : Jouer un coup si possible
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation], Depth, CurrentPlayer) :-
	maxDepth(Depth) ->
	columnsNumber(NextCol) ->
	evaluate(Grid, NumCol, CurrentPlayer, Evaluation).


%%%%%%%%%%%%%%%%%%%%
% P1 : Profondeur maximale atteinte : on évalue la grille
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation], Depth, CurrentPlayer) :-
	maxDepth(Depth) ->
	columnsNumber(NextCol) ->
	evaluate(Grid, NumCol, CurrentPlayer, Evaluation).
	
	
%%%%%%%%%%%%%%%%%%%%
% P2
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	maxDepth(Depth) ->
	evaluate(Grid, NumCol, CurrentPlayer, Evaluation).
	
	
%%%%%%%%%%%%%%%%%%%%
% P3 : 
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, MinMax, Depth, CurrentPlayer) :-
	columnsNumber(NextCol) ->
	copy_term(Grid, Grid1) ->
	Depth1 is Depth + 1 ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, 1, EvaluationsR, Depth1, IdPlayer) ->
	(
		%P4
		IdPlayer = CurrentPlayer ->
		getMax(EvaluationsR, MinMax)
		;
		%P5
		getMin(EvaluationsR, MinMax)
	).
	

%%%%%%%%%%%%%%%%%%%%
% P6 : 
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	copy_term(Grid, Grid1) ->
	NextCol1 is NextCol + 1 ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, NextCol, Evaluation, Depth, IdPlayer).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial call
playerTreeExplorer(Grid, Id, NumCol) :-
	copy_term(Grid, Grid1) ->
	privatePlayerTreeExplorer(Grid1, Id, 1, Evaluations, 1, Id) ->
	getMax(Evaluations, Max) ->
	indexOf(Evaluations, Max, NumCol).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How calling this player
% launch(playerTreeExplorer, playerTest1, R).