:- [gameCore].

%privatePlayerTreeExplorer(Grid, IdPlayer, NumCol, NextCol, Evaluations, Depth, CurrentPlayer)



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
% Retourne le plus grand �l�ment pr�sent dans une liste (x est une valeur � skipper)
%%%%%%%%%%%%%%%%%%%%
getMax([Max], Max).
getMax([T|L], Max) :- getMax(L, Max1), (T >= Max1, Max = T; T < Max1, Max = Max1).



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% Retourne le plus petit �l�ment pr�sent dans une liste (x est une valeur � skipper)
%%%%%%%%%%%%%%%%%%%%
getMin([Min], Min).
getMin([x|L], Min) :- getMin(L, Min).
getMin([T|L], Min) :- getMin(L, Min1), (T =< Min1, Min = T; T > Min1, Min = Min1).


%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% Retourne l'index du premier �l�ment �gal � Elt pr�sent dans la liste
%%%%%%%%%%%%%%%%%%%%
indexOf([Elt|_], Elt, 1).
indexOf([_|L], Elt, Idx) :- indexOf(L, Elt, Idx1), Idx is Idx1 + 1.









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �valuation d'une grille de jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
evaluate(_, _, _, 1).

%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played line
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix
evaluateLine(Matrix, ColumnId, PlayerId, Value) :-
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId + 1,
	countLine(Matrix, 1, LineId1, PlayerId, Value).
	
% Stop when we are at the grid limit	
countLine(Matrix, NumCol, LineId, PlayerId, 0) :- NumCol1 is NumCol - 1, columnsNumber(NumCol1).

% Count the ammount of pawn belonging to PlayerId
countLine(Matrix, NumCol, LineId, PlayerId, Value) :-
	gameGridGet(Matrix, NumCol, LineId, PlayerId) ->
		Value1 is Value - 1;
	NumCol1 is NumCol + 1,
	countLine(Matrix, NumCol1, LineId, PlayerId, Value1).
	
%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played column
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix

evaluateColumn(Matrix, ColumnId, PlayerId, Value) :- countColumn(Matrix, ColumnId, 1, PlayerId, Value).

% Stop when we are at the grid limit
countColumn(Matrix, ColumnId, NumLine, PlayerId, 0) :- NumLine1 is NumLine - 1, linesNumber(NumLine1).

% Count the ammount of pawn belonging to PlayerId
countColumn(Matrix, ColumnId, NumLine, PlayerId, Value) :-
	NumLine1 is NumLine + 1 ->
	countColumn(Matrix, ColumnId, NumLine1, PlayerId, Value1) ->
	(
		gameGridGet(Matrix, ColumnId, NumLine, PlayerId) ->
		Value is Value1 + 1
		;
		Value is Value1
	).
		

evaluate(Matrix, ColumnId, PlayerId, Value) :-
	evalutLine(Matrix, ColumnId, PlayerId, LinePawns),
	LineValue is 10 ^ LinePaws,
	evaluateColumn(Matrix, ColumnId, PlayerId, ColumnPawns),
	ColumnValue is 10 ^ ColumnPawns,
	Value is max(LineValue, ColumnValue).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si nextCol = nbMaxCol + 1 : P1
%		�valuations est une liste vide
% fin
% si profondeur maximale atteinte : P2
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en t�te de la liste Evaluations le r�sultat de la fonction �valuation (ou x si on ne peut jouer)
%     s appeler soit-m�me avec la grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
% fin
% sinon : P3
%     copier la grille re�ue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s appeler soit-m�me avec la grille jou�e, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer
%             ajouter en t�te de la liste evaluations le max de la liste evaluations1 initialis�e par l'appel au fils
%         sinon
%             ajouter en t�te de la liste evaluations le min de la liste evaluations1 initialis�e par l'appel au fils
%         fin
%	  sinon
%         ajouter en t�te de la liste evaluations x
%     fin
%     s appeler soit-m�me avec la grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
% fin
%%%%%
% Appel Initial :
% On calcule le max d'�valuations
% NumCol est l'indice du max
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%Profondeur maximale de recherche
%%%%%%%%%%%%%%%%%%%%
maxDepth(2).


%%%%%%%%%%%%%%%%%%%%
% P1
% si nextCol = nbMaxCol + 1 : P1
%		�valuations est une liste vide
% fin
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(_, _, NextCol, [], _, _) :-
	NextCol1 is NextCol-1 ->
	columnsNumber(NextCol1), write('col max reached') -> nl.
	

%%%%%%%%%%%%%%%%%%%%
% P2
% si profondeur maximale atteinte : P2
%     copier la grille re�ue
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en t�te de la liste Evaluations le r�sultat de la fonction �valuation (ou x si on ne peut jouer)
%     s appeler soit-m�me avec la grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
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
%     copier la grille re�ue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s appeler soit-m�me avec la grille jou�e, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer : P4
%             ajouter en t�te de la liste evaluations le max de la liste evaluations1 initialis�e par l'appel au fils
%         sinon : P5
%             ajouter en t�te de la liste evaluations le min de la liste evaluations1 initialis�e par l'appel au fils
%         fin
%	  sinon
%         ajouter en t�te de la liste evaluations x
%     fin
%     s appeler soit-m�me avec la grille copi�e de la grille re�ue, avec nextcol = nextcol + 1
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
