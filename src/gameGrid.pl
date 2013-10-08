%%%%%%%%%%%%%%%%%%%%%%%
% Game grid definition
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% Constants
% Game grid
%%%%%%%%%%%%
columnsNumber(7).
linesNumber(6).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a new empty matrix
% gameNewGrid(GridResult).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gameNewGrid(0,[]).
gameNewGrid(Col, [[]|Matrix]) :- Col1 is Col-1, gameNewGrid(Col1, Matrix).
gameNewGrid(Matrix) :- columnsNumber(L), gameNewGrid(L, Matrix).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Insert a pawn in the grid at the specified column
% gamePlay(Grid, ColumnNumber, PlayerId, GridResult).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gamePlay([Column|Grid], ColumnId, PlayerId, [ColumnR|Grid], ColumnId) :- append(Column, [PlayerId], ColumnR).
gamePlay([X|Grid], Column, PlayerId, [X|Result], Pos) :-
	not(Pos = Column), Pos1 is Pos + 1, gamePlay(Grid, Column, PlayerId, Result, Pos1).
gamePlay(Grid, Column, PlayerId, Result) :-
    gamePlay(Grid, Column, PlayerId, Result, 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Returns the value of a Pawn at the specified line and column
% gameGridGet(Grid, ColumnNumber, LineNumber, ResultContent).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateGameGridGet([T|_], 1, T).
privateGameGridGet([T|R], Line, Result) :- not(Line = 1), Line1 is Line - 1, privateGameGridGet(R, Line1, Result).
gameGridGet([T|_], 1, Line, Result) :- privateGameGridGet(T, Line, Result).
gameGridGet([_|Grid], Col, Line, Result) :- not(Col = 1), Col1 is Col-1, gameGridGet(Grid, Col1, Line, Result).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test function
% test(Pawn).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test(Pawn) :- gameNewGrid(G),
		gamePlay(G, 1, 1, R),
		gamePlay(R, 1, 2, R2),
		gameGridGet(R2, 1, 2, Pawn).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% :- dynamic(gameGrid/3).
% gameSet(Col, Line, PlayerId) :- assert(gameGrid(Col, Line, PlayerId)).
% gamePlay(Col, Line, PlayerId) :- gameGrid(Col, Line, X), Line2 is Line+1, gamePlay(Col, Line2, PlayerId) ; gameSet(Col, Line, PlayerId).
% gamePlay(Col, PlayerId) :- gamePlay(Col, 1, PlayerId).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
