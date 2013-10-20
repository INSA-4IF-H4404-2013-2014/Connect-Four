:- [gameCore].

%privatePlayerTreeExplorer(Grid, IdPlayer, NumCol, NextCol, Evaluations, Depth, CurrentPlayer)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Évaluation d'une grille de jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonctions requises par l'algo MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% getMax(List, Max) <=> Max = getMax(List)
% Retourne le plus grand élément présent dans une liste (x est une valeur à skipper)
%%%%%%%%%%%%%%%%%%%%
getMax([Max], Max).
getMax([x|L], Max) :- getMax(L, Max).
getMax([T|L], Max) :- getMax(L, Max1), (T >= Max1, Max = T; T < Max1, Max = Max1).



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% Retourne le plus petit élément présent dans une liste (x est une valeur à skipper)
%%%%%%%%%%%%%%%%%%%%
getMin([Min], Min).
getMin([x|L], Min) :- getMin(L, Min).
getMin([T|L], Min) :- getMin(L, Min1), (T <= Min1, Min = T; T > Min1, Min = Min1).



%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% Retourne l'index du premier élément égal à Elt présent dans la liste
%%%%%%%%%%%%%%%%%%%%
indexOf([Elt|L], Elt, 0).
indexOf([T|L], Elt, Idx) :- indexOf(L, Elt, Idx1), Idx is Idx + 1.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si nextCol = nbMaxCol + 1 : P1
%		évaluations est une liste vide
% fin
% si profondeur maximale atteinte : P2
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en tête de la liste Evaluations le résultat de la fonction évaluation (ou x si on ne peut jouer)
% fin
% sinon : P3
%     copier la grille reçue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s'appeler soit-même avec la grille jouée, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer
%             ajouter en tête de la liste evaluations le max de la liste evaluations1 initialisée par l'appel au fils
%         sinon
%             ajouter en tête de la liste evaluations le min de la liste evaluations1 initialisée par l'appel au fils
%         fin
%	  sinon
%         ajouter en tête de la liste evaluations x
%     fin
%     s'appeler soit-même avec la grille copiée de la grille reçue, avec nextcol = nextcol + 1
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
% P1
% si nextCol = nbMaxCol + 1 : P1
%		évaluations est une liste vide
% fin
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [], Depth, CurrentPlayer) :-
	NextCol1 is NextCol-1 ->
	columnsNumber(NextCol).
	
	
%%%%%%%%%%%%%%%%%%%%
% P2
% si profondeur maximale atteinte : P2
%     JOUER un pion dans la colonne nextCol si possible
%     ajouter en tête de la liste Evaluations le résultat de la fonction évaluation (ou x si on ne peut jouer)
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
%     copier la grille reçue
%     si on peut jouer
%		  JOUER un pion dans la colonne nextCol
%         s'appeler soit-même avec la grille jouée, avec nextcol = 1 et depth += 1
%         si idplayer = currentplayer : P4
%             ajouter en tête de la liste evaluations le max de la liste evaluations1 initialisée par l'appel au fils
%         sinon : P5
%             ajouter en tête de la liste evaluations le min de la liste evaluations1 initialisée par l'appel au fils
%         fin
%	  sinon
%         ajouter en tête de la liste evaluations x
%     fin
%     s'appeler soit-même avec la grille copiée de la grille reçue, avec nextcol = nextcol + 1
%%%%%%%%%%%%%%%%%%%%
privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	copy_term(Grid, Grid1) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		linesNumber(ColumnHeight) ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		Depth1 is Depth + 1 ->
		gameOtherPlayer(IdPlayer, NextPlayerId),
		privatePlayerTreeExplorer(GridResult, IdPlayer, 1, EvaluationsResult, Depth1, NextPlayerId) ->
		(
			IdPlayer = CurrentPlayer ->
			getMax(EvaluationsResult, Evaluation)
			;
			getMin(EvaluationsResult, Evaluation)
		) ->
		;
		Evaluation is x,
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
	LineId1 is LineId + 1,
	countLine(Matrix, 1, LineId1, PlayerId, Value).
	
% Stop when we are at the grid limit	
countLine(Matrix, NumCol, LineId, PlayerId, Value) :- NumCol1 is NumCol - 1, columnsNumber(NumCol1).

% Count the ammount of pawn belonging to PlayerId
countLine(Matrix, NumCol, LineId, PlayerId, Value) :-
	gameGridGet(Matrix, NumCol, LineId, PlayerId) ->
		Value1 is Value + 1;
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
countColumn(Matrix, ColumnId, NumLine, PlayerId, Value) :- NumLine1 is NumLine - 1, linesNumber(NumLine1).

% Count the ammount of pawn belonging to PlayerId
countColumn(Matrix, ColumnId, NumLine, PlayerId, Value) :-
	gameGridGet(Matrix, ColumnId, NumLine, PlayerId) ->
		Value1 is Value + 1; % Problem: Value is never initialized at 0
	NumLine1 is NumLine + 1,
	countColumn(Matrix, ColumnId, NumLine1, PlayerId, Value1).
	
% Mini-test for evaluateColumn
testEvaluate(Value) :- 
		gameNewGrid(Grid),
		gamePlay(Grid, 1, 1, ResGrid),
		gamePlay(ResGrid, 1, 1, ResGrid2),
		evaluateColumn(ResGrid2, 1, 1, Value).
		

evaluate(Matrix, ColumnId, PlayerId, Value) :-
	evalutLine(Matrix, ColumnId, PlayerId, LinePawns),
	LineValue = 10 ^ LinePaws,
	evaluateColumn(Matrix, ColumnId, PlayerId, ColumnPawns),
	ColumnValue = 10 ^ ColumnPawns,
	Value is max(LineValue, ColumnValue).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial call
playerTreeExplorer(Grid, Id, NumCol) :-
	copy_term(Grid, Grid1) ->
	privatePlayerTreeExplorer(Grid1, Id, 1, Evaluations, 1, Id) ->
	getMax(Evaluations, Max) ->
	indexOf(Evaluations, Max, NumCol).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How to call this player
% gameProcess(playerTreeExplorer, playerTest1, R).