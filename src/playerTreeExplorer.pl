:- [gameCore].
:- [gameSmart].

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
% test the maximum in a list
%%%%%%%%%%%%%%%%%%%%
getMax([Max], Max).
getMax([T|L], Max) :- getMax(L, Max1), (T >= Max1, Max = T; T < Max1, Max = Max1).



%%%%%%%%%%%%%%%%%%%%
% getMin(List, Min) <=> Min = getMin(List)
% test the minimum in a list
%%%%%%%%%%%%%%%%%%%%
getMin([Min], Min).
getMin([x|L], Min) :- getMin(L, Min).
getMin([T|L], Min) :- getMin(L, Min1), (T =< Min1, Min = T; T > Min1, Min = Min1).


%%%%%%%%%%%%%%%%%%%%
% indexOf(List, Elt, Idx) <=> Idx = indexOf(List, Elt)
% test the index of an element in a list
%%%%%%%%%%%%%%%%%%%%
indexOf([Elt|_], Elt, 1).
indexOf([_|L], Elt, Idx) :- indexOf(L, Elt, Idx1), Idx is Idx1 + 1.


%%%%%%%%%%%%%%%%%%%%
% countItem(List, Elt, NbOcc)
% test the number of occurence in a list
%%%%%%%%%%%%%%%%%%%%
countItem([], _, 0).
countItem([Elt|L], Elt, NbOcc) :- countItem(L, Elt, NbOcc1), NbOcc is NbOcc1 + 1.
countItem([_|L], Elt, NbOcc) :- countItem(L, Elt, NbOcc).


%%%%%%%%%%%%%%%%%%%%
% countNegative(List, NbOcc)
%%%%%%%%%%%%%%%%%%%%
countNegative([], 0).
countNegative([T|L], NbOcc) :- countNegative(L, NbOcc1), (T < 0, NbOcc is NbOcc1 + 1 ; NbOcc is NbOcc1).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% evaluate a play%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to use :
% evaluatePlay(Grid, ColumnId, PlayerId, MaxScore)

evaluatePlay(Grid, ColumnId, PlayerId, MaxScore) :-
	evaluateCurrentPlayer(Grid, ColumnId, PlayerId, Evaluation1) ->
	evaluateOtherPlayer(Grid, ColumnId, PlayerId, Evaluation2) ->
	(
		Evaluation1 > Evaluation2 ->
		MaxScore is Evaluation1
		;
		MaxScore is Evaluation2
	).
	


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Launch all the evaluations
evaluateAll(Matrix, ColumnId, PlayerId, Column, Line, Diago1, Diago2) :-
	evaluateColumn(Matrix, ColumnId, PlayerId, Column),
	evaluateLine(Matrix, ColumnId, PlayerId, Line),
	evaluateDiago1(Matrix, ColumnId, PlayerId, Diago1),
	evaluateDiago2(Matrix, ColumnId, PlayerId, Diago2).
	
distanceAll(Matrix, ColumnId, PlayerId, Column, Line, Diago1, Diago2) :-
	distanceColumn(Matrix, ColumnId, PlayerId, Column),
	distanceLine(Matrix, ColumnId, PlayerId, Line),
	distanceDiago1(Matrix, ColumnId, PlayerId, Diago1),
	distanceDiago2(Matrix, ColumnId, PlayerId, Diago2).

% Convert the number of align pawn of the player into the corresponding value
currentPlayerCoeff(Value, Result) :- Value1 is Value - 1, Result is 10 ^ Value1.

% Convert the distance value into a score -> currentPlayerDistCoeff(Value, Score)
currentPlayerDistCoeff(0, 0).
currentPlayerDistCoeff(1, 5).
currentPlayerDistCoeff(2, 3).
currentPlayerDistCoeff(3, 2).

% Return the maximum value obtained by evaluation for the current player
evaluateCurrentPlayer(Matrix, ColumnId, PlayerId, MaxWin) :-
	evaluateAll(Matrix, ColumnId, PlayerId, Column, Line, Diago1, Diago2),
	currentPlayerCoeff(Column, RColumn),
	currentPlayerCoeff(Line, RLine),
	currentPlayerCoeff(Diago1, RDiago1),
	currentPlayerCoeff(Diago2, RDiago2),
	distanceAll(Matrix, ColumnId, PlayerId, DColumn, DLine, DDiago1, DDiago2),
	currentPlayerDistCoeff(DColumn, RDColumn),
	currentPlayerDistCoeff(DLine, RDLine),
	currentPlayerDistCoeff(DDiago1, RDDiago1),
	currentPlayerDistCoeff(DDiago2, RDDiago2),
	getMax([RColumn, RLine, RDiago1, RDiago2, RDColumn, RDLine, RDDiago1, RDDiago2], MaxWin).

% Convert the number of align pawn of the opponent into the corresponding value	
otherPlayerCoeff(Value, Result) :- Value1 is Value - 1, Coeff is 10 ^ Value1, Result is 5 * Coeff.

% Return the maximum value obtained by evaluation for the opponent player
evaluateOtherPlayer(Matrix, ColumnId, PlayerId, MaxWin) :-
	gameOtherPlayer(PlayerId, OtherPlayer),
	evaluateAll(Matrix, ColumnId, OtherPlayer, Column1, Line1, Diago11, Diago21),
	Column is Column1 - 1,
	Line is Line1 - 1,
	Diago1 is Diago11 - 1,
	Diago2 is Diago21 - 1,
	otherPlayerCoeff(Column, RColumn),
	otherPlayerCoeff(Line, RLine),
	otherPlayerCoeff(Diago1, RDiago1),
	otherPlayerCoeff(Diago2, RDiago2),
	getMax([RColumn, RLine, RDiago1, RDiago2], MaxWin).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%					!!!!!!!!!!! CAUTION !!!!!!!!!!
% All evalute predicates count the number of conscutive pawns in the line, column or diagonals
% corresponding at the ColumnId.
% THIS NUMBER INCLUDES THE PAWN PLAYED!
% For example, if no pawns are aligned on line, evaluateLine(Matrix, ColumnId, PlayerId, Value)
% will get Value = 1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played line
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix
evaluateLine(Matrix, ColumnId, PlayerId, Value) :-
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId,
	ColumnId1 is ColumnId - 1,
	ColumnId2 is ColumnId + 1,
	countLineLeft(Matrix, ColumnId1, LineId1, PlayerId, Value1), countLineRight(Matrix, ColumnId2, LineId1, PlayerId, Value2),
	Value is Value1 + Value2 - 1.

countLineLeft(Matrix, ColumnId, LineId, PlayerId, 1) :- (not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)) ; ColumnId = 0), !.

countLineLeft(Matrix, ColumnId, LineId, PlayerId, Value) :-
	ColumnId1 is ColumnId - 1 ->
		countLineLeft(Matrix, ColumnId1, LineId, PlayerId, Value1) ->
			Value is Value1 + 1.
			
			
countLineRight(Matrix, ColumnId, LineId, PlayerId, 1) :- (not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)) ; (ColumnId1 is ColumnId - 1, columnsNumber(ColumnId1))), !.
	
countLineRight(Matrix, ColumnId, LineId, PlayerId, Value) :-
	ColumnId1 is ColumnId + 1 ->
		countLineRight(Matrix, ColumnId1, LineId, PlayerId, Value1) ->
			Value is Value1 + 1.
	
%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played column
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix
evaluateColumn(Matrix, ColumnId, PlayerId, Value) :- gameColumnHeight(Matrix, ColumnId, LineId), LineId1 is LineId - 1, countColumn(Matrix, ColumnId, LineId1, PlayerId, Value).

countColumn(Matrix, ColumnId, LineId, PlayerId, 1) :- (not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)) ; LineId = 0), !.

countColumn(Matrix, ColumnId, LineId, PlayerId, Value) :- 
	LineId1 is LineId - 1 ->
		countColumn(Matrix, ColumnId, LineId1, PlayerId, Value1) ->
			Value is Value1 + 1.
	
	
evaluate(Matrix, ColumnId, PlayerId, Value) :-
	evalutLine(Matrix, ColumnId, PlayerId, LinePawns),
	LineValue is 10 ^ LinePawns,
	evaluateColumn(Matrix, ColumnId, PlayerId, ColumnPawns),
	ColumnValue is 10 ^ ColumnPawns,
	Value is max(LineValue, ColumnValue).


%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played first diagonale (from bottom left to top right)
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix
evaluateDiago1(Matrix, ColumnId, PlayerId, Value) :- 
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId - 1,
	LineId2 is LineId + 1,
	ColumnId1 is ColumnId - 1,
	ColumnId2 is ColumnId + 1,	
	countDiago1Left(Matrix, ColumnId1, LineId1, PlayerId, Value1), countDiago1Right(Matrix, ColumnId2, LineId2, PlayerId, Value2),
	Value is Value1 + Value2 - 1.
	
% Stop when a pawn doesn't belong to the player or we are out of the grid
countDiago1Left(Matrix, ColumnId, LineId, PlayerId, 1) :- 
	(
		not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)); 
		ColumnId = 0; 
		LineId = 0
	), 
	!.

countDiago1Left(Matrix, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId - 1, LineId1 is LineId - 1) ->
		countDiago1Left(Matrix, ColumnId1, LineId1, PlayerId, Value1) ->
			Value is Value1 + 1.
			
% Stop when a pawn doesn't belong to the player or we are out of the grid			
countDiago1Right(Matrix, ColumnId, LineId, PlayerId, 1) :- 
	(
		not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)); 
		(ColumnId1 is ColumnId - 1, columnsNumber(ColumnId1));
		(LineId1 is LineId - 1, linesNumber(LineId1))
	), 
	!.
	
countDiago1Right(Matrix, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId + 1, LineId1 is LineId + 1) ->
		countDiago1Right(Matrix, ColumnId1, LineId1, PlayerId, Value1) ->
			Value is Value1 + 1.

			
%%%%%%%%%%%%%%%%%%%%%%
% Give the number of pawn of the playerId in the played first diagonale (from top left to bottom right)
%%%%%%%%%%%%%%%%%%%%%%
% return value : Value
% column to be played : ColumnId
% player playing : PlayerId
% actual matrix : Matrix
evaluateDiago2(Matrix, ColumnId, PlayerId, Value) :- 
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId + 1,
	LineId2 is LineId - 1,
	ColumnId1 is ColumnId - 1,
	ColumnId2 is ColumnId + 1,	
	countDiago2Left(Matrix, ColumnId1, LineId1, PlayerId, Value1), countDiago2Right(Matrix, ColumnId2, LineId2, PlayerId, Value2),
	Value is Value1 + Value2 - 1.
	
% Stop when a pawn doesn't belong to the player or we are out of the grid
countDiago2Left(Matrix, ColumnId, LineId, PlayerId, 1) :- 
	(
		not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)); 
		ColumnId = 0; 
		(LineId1 is LineId - 1, linesNumber(LineId1))
	), 
	!.

countDiago2Left(Matrix, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId - 1, LineId1 is LineId + 1) ->
		countDiago2Left(Matrix, ColumnId1, LineId1, PlayerId, Value1) ->
			Value is Value1 + 1.
			
% Stop when a pawn doesn't belong to the player or we are out of the grid			
countDiago2Right(Matrix, ColumnId, LineId, PlayerId, 1) :- 
	(
		not(gameGridGet(Matrix, ColumnId, LineId, PlayerId)); 
		(ColumnId1 is ColumnId - 1, columnsNumber(ColumnId1));
		LineId = 0
	), 
	!.
	
countDiago2Right(Matrix, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId + 1, LineId1 is LineId - 1) ->
		countDiago2Right(Matrix, ColumnId1, LineId1, PlayerId, Value1) ->
			Value is Value1 + 1.			
			
			
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DISTANCE EVALUATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the minimum of the two value, but the min is > 0
getMinDistance(0, Value, Value) :- !.
getMinDistance(Value, 0, Value) :- !.
getMinDistance(Value1, Value2, Value) :- getMin([Value1, Value2], Value), !.


% Get the Value of the distance from one PlayerId's pawn to another in the same line in the Matrix
% If distance > 3 or out of grid, Value = 0
distanceLine(Matrix, ColumnId, PlayerId, Value) :-
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId,
	ColumnId1 is ColumnId - 1,
	ColumnId2 is ColumnId + 1,
	countDistanceLineLeft(Matrix, ColumnId, ColumnId1, LineId1, PlayerId, Value1), countDistanceLineRight(Matrix, ColumnId, ColumnId2, LineId1, PlayerId, Value2),
	getMinDistance(Value1, Value2, Value).

countDistanceLineLeft(_, ColumnRef, ColumnId, _, _, 0) :- 
		Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(	
			Value > 3;
			ColumnId = 0
		), 
		!.
	
countDistanceLineLeft(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :- 
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(	
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.

		
countDistanceLineLeft(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	ColumnId1 is ColumnId - 1 ->
		countDistanceLineLeft(Matrix, ColumnRef, ColumnId1, LineId, PlayerId, Value).
		
		
		
countDistanceLineRight(_, ColumnRef, ColumnId, _, _, 0) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
	(	
		Value > 3;
		(ColumnId1 is ColumnId - 1, columnsNumber(ColumnId1))
	), 
	!.
		
countDistanceLineRight(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :- 
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.


countDistanceLineRight(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	ColumnId1 is ColumnId + 1 ->
		countDistanceLineRight(Matrix, ColumnRef, ColumnId1, LineId, PlayerId, Value).
	

% Get the Value of the distance from one PlayerId's pawn to another in the same column in the Matrix
% If distance > 3 or out of grid, Value = 0
distanceColumn(Matrix, ColumnId, PlayerId, Value) :- 
	gameColumnHeight(Matrix, ColumnId, LineId), 
	LineId1 is LineId - 1,
	countDistanceColumn(Matrix, ColumnId, LineId, LineId1, PlayerId, Value).

countDistanceColumn(_, _, LineRef, LineId, _, 0) :-
	Value is (abs(LineRef - LineId)) - 1 ->
	(	
		Value > 3;
		LineId = 0
	), 
	!.
	
countDistanceColumn(Matrix, ColumnId, LineRef, LineId, PlayerId, Value) :- 
	Value is (abs(LineRef - LineId)) - 1 ->
		(
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.
		
countDistanceColumn(Matrix, ColumnId, LineRef, LineId, PlayerId, Value) :-
	LineId1 is LineId - 1 ->
		countDistanceColumn(Matrix, ColumnId, LineRef, LineId1, PlayerId, Value).
		
		
% Get the Value of the distance from one PlayerId's pawn to another in the same diago1 in the Matrix
% If distance > 3 or out of grid, Value = 0
distanceDiago1(Matrix, ColumnId, PlayerId, Value) :- 
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId - 1,
	LineId2 is LineId + 1,
	ColumnId1 is ColumnId - 1,
	ColumnId2 is ColumnId + 1,	
	countDistanceDiago1Left(Matrix, ColumnId, ColumnId1, LineId1, PlayerId, Value1), countDistanceDiago1Right(Matrix, ColumnId, ColumnId2, LineId2, PlayerId, Value2),
	getMinDistance(Value1, Value2, Value).
	
% Stop when a pawn doesn't belong to the player or we are out of the grid
countDistanceDiago1Left(_, ColumnRef, ColumnId, LineId, _, 0) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
	(	
		Value > 3;
		ColumnId = 0;
		LineId = 0
	), 
	!.
	
countDistanceDiago1Left(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(	
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.

countDistanceDiago1Left(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId - 1, LineId1 is LineId - 1) ->
		countDistanceDiago1Left(Matrix, ColumnRef, ColumnId1, LineId1, PlayerId, Value).
			
% Stop when a pawn doesn't belong to the player or we are out of the grid			
countDistanceDiago1Right(_, ColumnRef, ColumnId, LineId, _, 0) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
	(	
		Value > 3;
		(ColumnId1 is ColumnId - 1, columnsNumber(ColumnId1));
		(LineId1 is LineId - 1, linesNumber(LineId1))
	), 
	!.
	
countDistanceDiago1Right(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :- 
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(	
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.
	
countDistanceDiago1Right(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId + 1, LineId1 is LineId + 1) ->
		countDistanceDiago1Right(Matrix, ColumnRef, ColumnId1, LineId1, PlayerId, Value).
		
		
% Get the Value of the distance from one PlayerId's pawn to another in the same diago2 in the Matrix
% If distance > 3 or out of grid, Value = 0
distanceDiago2(Matrix, ColumnId, PlayerId, Value) :- 
	gameColumnHeight(Matrix, ColumnId, LineId),
	LineId1 is LineId + 1,
	LineId2 is LineId - 1,
	ColumnId1 is ColumnId - 1,
	ColumnId2 is ColumnId + 1,	
	countDistanceDiago2Left(Matrix, ColumnId, ColumnId1, LineId1, PlayerId, Value1), countDistanceDiago2Right(Matrix, ColumnId, ColumnId2, LineId2, PlayerId, Value2),
	getMinDistance(Value1, Value2, Value).
	
% Stop when a pawn doesn't belong to the player or we are out of the grid
countDistanceDiago2Left(_, ColumnRef, ColumnId, LineId, _, 0) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
	(	
		Value > 3;
		ColumnId = 0; 
		(LineId1 is LineId - 1, linesNumber(LineId1))
	), 
	!.
	
countDistanceDiago2Left(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(	
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.

countDistanceDiago2Left(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId - 1, LineId1 is LineId + 1) ->
		countDistanceDiago2Left(Matrix, ColumnRef, ColumnId1, LineId1, PlayerId, Value).
		
		
% Stop when a pawn doesn't belong to the player or we are out of the grid			
countDistanceDiago2Right(_, ColumnRef, ColumnId, LineId, _, 0) :-
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
	(	
		Value > 3;
		(ColumnId1 is ColumnId - 1, columnsNumber(ColumnId1));
		LineId = 0
	), 
	!.
	
countDistanceDiago2Right(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :- 
	Value is (abs(ColumnRef - ColumnId)) - 1 ->
		(	
			gameGridGet(Matrix, ColumnId, LineId, PlayerId)
		),
		!.
	
countDistanceDiago2Right(Matrix, ColumnRef, ColumnId, LineId, PlayerId, Value) :-
	(ColumnId1 is ColumnId + 1, LineId1 is LineId - 1) ->
		countDistanceDiago2Right(Matrix, ColumnRef, ColumnId1, LineId1, PlayerId, Value).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGO MIN-MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% max search depth
%%%%%%%%%%%%%%%%%%%%
% The depth MUST BE an impair number
maxDepth(5).

privatePlayerTreeExplorer(_, _, NextCol, [], _, _) :-
	NextCol1 is NextCol-1 ->
	columnsNumber(NextCol1).

privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	maxDepth(Depth) ->
	copy_term(Grid, Grid1) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		not(linesNumber(ColumnHeight)) ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		evaluatePlay(GridResult, NextCol, CurrentPlayer, EvaluationR) ->
		Evaluation is EvaluationR / Depth
		;
		Evaluation = x
	) ->
	NextCol1 is NextCol + 1 ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, NextCol1, L, Depth, CurrentPlayer).

privatePlayerTreeExplorer(Grid, IdPlayer, NextCol, [Evaluation|L], Depth, CurrentPlayer) :-
	copy_term(Grid, Grid1) ->
	gameColumnHeight(Grid, NextCol, ColumnHeight) ->
	(
		not(linesNumber(ColumnHeight)) ->
		gamePlay(Grid, NextCol, CurrentPlayer, GridResult) ->
		evaluatePlay(GridResult, NextCol, CurrentPlayer, EvaluationR) -> 
		(
			%If the current player can win => evaluation = 1000 / if the opponent can win => evaluation = -1000
			(
				CurrentPlayer == IdPlayer ->
				EvaluationR >= 500 ->
				Evaluation is EvaluationR / Depth
				;
				EvaluationR == 1000 ->
				Evaluation is -EvaluationR / Depth
			)
			;
			Depth1 is Depth + 1 ->
			gameOtherPlayer(CurrentPlayer, NextPlayerId) ->
			privatePlayerTreeExplorer(GridResult, IdPlayer, 1, EvaluationsResult, Depth1, NextPlayerId) ->
			removeXValues(EvaluationsResult, EvaluationsResult1) ->
			(
				IdPlayer == CurrentPlayer ->
				getMin(EvaluationsResult1, Evaluation)
				;
				countNegative(EvaluationsResult1, N) ->
				(
					N >= 2 ->
					Evaluation is -1000 / Depth
					;
					getMax(EvaluationsResult1, Evaluation)
				)
			)
		)
		;
		Evaluation = x
	) ->  
	NextCol1 is NextCol + 1 ->
	privatePlayerTreeExplorer(Grid1, IdPlayer, NextCol1, L, Depth, CurrentPlayer).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial call
playerTreeExplorer(Grid, PlayerId, NumCol) :-	
	copy_term(Grid, Grid1) ->
	privatePlayerTreeExplorer(Grid1, PlayerId, 1, Evaluations, 1, PlayerId) ->
	removeXValues(Evaluations, Evaluations1) ->
	getMax(Evaluations1, Max) ->
	indexOf(Evaluations, Max, NumCol).
