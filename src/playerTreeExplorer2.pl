:- [gameCore

%privatePlayerTreeExplorer(Grid, IdPlayer, NumCol, NextCol, Evaluations, Depth, CurrentPlayer)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �valuation d'une grille de jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonctions requises par l'algo MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Fonction simulatePlay
% 		  si l'on peut jouer dans la colonne nextCol
%		      jouer
%         	  �valuation = le r�sultat de la fonction d'�valuation sur la grille pass�e en param�tre
%		  sinon
%			  �valuation = 0
%         fin



si l'on peut jouer
%			jouer dans la colonne nextCol
%		 fin
%        	s'appeler soit-m�me avec une grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
%        si l'on peut jouer
%        	ajouter en t�te de la liste evaluations la valeur �valuation re�ue par l'appel du fils
%        sinon
%           ajouter en t�te de la liste evaluations 0
%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%
% getMax(List, Max) <=> Max = getMax(List)
% Retourne le plus grand �l�ment pr�sent dans une liste
%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% Retourne le plus petit �l�ment pr�sent dans une liste
%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% Retourne l'index du premier �l�ment �gal � Elt pr�sent dans la liste
%%%%%%%%%%%%%%%%%%%%
indexOf([], Elt, Idx)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si hauteur maximale atteinte
%     si nextCol = nbMaxCol : P1
%         %JOUER un pion dans la colonne nextCol si possible
%         Evaluations est une liste contenant pour seul �l�ment le r�sultat de la fonction �valuation (ou 0 si on ne peut jouer)
%     sinon : P2
%		  %JOUER un pion dans la colonne nextCol si possible
%         ajouter en t�te de la liste Evaluations le r�sultat de la fonction �valuation (ou 0 si on ne peut jouer)
%     fin
% sinon
%     si nextCol = nbMaxCol : P3
%		  %JOUER un pion dans la colonne nextCol si possible
%         s'appeler soit-m�me avec une grille copi�e de la grille jou�e, avec nextcol = 1 et depth = depth + 1
%         si idplayer = currentplayer : P4
%             Evaluations est (D�sactiv� : mettre [MINMAX] pour activer : %une liste ayant pour seul �l�ment%) le max de la liste evaluations1
%         sinon : P5
%             Evaluations est %une liste ayant pour seul �l�ment% le min de la liste evaluations1
%         fin
%     sinon : P6
%        %JOUER un pion dans la colonne nextCol si possible
%        s'appeler soit-m�me avec une grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
%        ajouter en t�te de la liste evaluations la valeur �valuation re�ue par l'appel du fils
%     fin
% fin
%%%%%
% Appel Initial :
% On calcule le max d'�valuations
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
% P1 : Profondeur maximale atteinte : on �value la grille
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