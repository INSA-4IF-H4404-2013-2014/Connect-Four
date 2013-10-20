:- [gameCore].

%privatePlayerTreeExplorer(Grid, IdPlayer, NumCol, NextCol, Evaluations, Depth, CurrentPlayer)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �valuation d'une grille de jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonctions requises par l'algo MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% getMax(List, Max) <=> Max = getMax(List)
% Retourne le plus grand �l�ment pr�sent dans une liste (x est une valeur � skipper)
%%%%%%%%%%%%%%%%%%%%
getMax([Max], Max).
getMax([x|L], Max) :- getMax(L, Max).
getMax([T|L], Max) :- getMax(L, Max1), (T >= Max1, Max = T; T < Max1, Max = Max1).



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% Retourne le plus petit �l�ment pr�sent dans une liste (x est une valeur � skipper)
%%%%%%%%%%%%%%%%%%%%
getMin([Min], Min).
getMin([x|L], Min) :- getMin(L, Min).
getMin([T|L], Min) :- getMin(L, Min1), (T <= Min1, Min = T; T > Min1, Min = Min1).



%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% Retourne l'index du premier �l�ment �gal � Elt pr�sent dans la liste
%%%%%%%%%%%%%%%%%%%%
indexOf([Elt|L], Elt, 0).
indexOf([T|L], Elt, Idx) :- indexOf(L, Elt, Idx1), Idx is Idx + 1.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si nextCol = nbMaxCol + 1 : P1
%		�valuations est une liste vide
% fin
% si profondeur maximale atteinte : P2
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en t�te de la liste Evaluations le r�sultat de la fonction �valuation (ou x si on ne peut jouer)
% fin
% sinon : P3
%     copier la grille re�ue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s'appeler soit-m�me avec la grille jou�e, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer
%             ajouter en t�te de la liste evaluations le max de la liste evaluations1 initialis�e par l'appel au fils
%         sinon
%             ajouter en t�te de la liste evaluations le min de la liste evaluations1 initialis�e par l'appel au fils
%         fin
%	  sinon
%         ajouter en t�te de la liste evaluations x
%     fin
%     s'appeler soit-m�me avec la grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
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
% P1
% si nextCol = nbMaxCol + 1 : P1
%		�valuations est une liste vide
% fin
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [], Depth, CurrentPlayer) :-
	NextCol1 is NextCol-1 ->
	columnsNumber(NextCol).
	
	
%%%%%%%%%%%%%%%%%%%%
% P2
% si profondeur maximale atteinte : P2
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en t�te de la liste Evaluations le r�sultat de la fonction �valuation (ou x si on ne peut jouer)
% fin
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	maxDepth(Depth) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		linesNumber(ColumnHeight) ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		evaluate(GridResult, NextCol, CurrentPlayer, Evaluation)
		;
		Evaluation = x
	).
	
	
%%%%%%%%%%%%%%%%%%%%
% P3 : 
%     copier la grille re�ue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s'appeler soit-m�me avec la grille jou�e, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer : P4
%             ajouter en t�te de la liste evaluations le max de la liste evaluations1 initialis�e par l'appel au fils
%         sinon : P5
%             ajouter en t�te de la liste evaluations le min de la liste evaluations1 initialis�e par l'appel au fils
%         fin
%	  sinon
%         ajouter en t�te de la liste evaluations x
%     fin
%     s'appeler soit-m�me avec la grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	copy_term(Grid, Grid1) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		linesNumber(ColumnHeight) ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		Depth1 is Depth + 1 ->
		gameOtherPlayer(IdPlayer, NextPlayerId)
		privatePlayerTreeExplorer(GridResult, IdPlayer, 1, EvaluationsResult, Depth1, NextPlayerId) ->
		(
			IdPlayer = CurrentPlayer ->
			getMax(EvaluationsResult, Evaluation)
			;
			getMin(EvaluationsResult, Evaluation)
		) ->
		;
		Evaluation is x
	) ->
	nextCol1 is nextCol + 1 ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, nextCol1, MinMax, Depth, CurrentPlayer).


%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played line
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix

evaluateLine(Matrix, ColumnId, PlayerId, Value) :-
	getColumnHeight(Matrix, ColumnId, LineId),
	countLine(Matrix, 1, LineId + 1, PlayerId, Value).
	
countLine(Matrix, NumCol, LineId, PlayerId, Value) :- columnsNumber(NumCol - 1).

countLine(Matrix, NumCol, LineId, PlayerId, Value) :-
	gameGridGet(Matrix, NumCol, LineId, PlayerId) ->
		Value1 is Value + 1,
	countLine(Matrix, NumCol + 1, LineId, PlayerId, Value1).
	
%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played column
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix

evaluateColumn(Matrix, ColumnId, PlayerId, Value) :- countColumn(Matrix, ColumnId, 1, PlayerId, Value).

countColumn(Matrix, ColumnId, NumLine, PlayerId, Value) :- linesNumber(NumLine - 1).

countColumn(Matrix, ColumnId, NumLine, PlayerId, Value) :-
	gameGridGet(Matrix, ColumnId, NumLine, PlayerId) ->
		Value1 is Value + 1,
	countColumn(Matrix, ColumnId, NumLine + 1, PlayerId, Value1).
	

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