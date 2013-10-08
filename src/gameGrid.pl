% Matrix definition

% Constants
columnsNumber(7).
linesNumber(6).

undefinedPlayer(0).
player1(1).
player2(2).


% Define a matrix filled with 0
:- dynamic(gameGrid/3).

% Assert a value at the specified
gameSet(Col, Line, PlayerId) :- assert(gameGrid(Col, Line, PlayerId)).

% gamePlay(_, Line, _) :- linesNumber(LineMax), LineMax is Line + 1, fail.
gamePlay(Col, Line, PlayerId) :- 
	gameGrid(Col, Line, X), Line2 is Line+1, gamePlay(Col, Line2, PlayerId) ; gameSet(Col, Line, PlayerId).

gamePlay(Col, PlayerId) :-
	gamePlay(Col, 1, PlayerId).
