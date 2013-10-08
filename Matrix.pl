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

gamePlay(Col, linesNumber, PlayerId) :- gameSet(Col, linesNumber, PlayerId).
gamePlay(Col, Line, PlayerId) :- gameGrid(Col, Line, undefinedPlayer), gameSet(Col, Line, PlayerId) ; Line2 is Line+1, gamePlay(Col, Line2, PlayerId).
gamePlay(Col, PlayerId) :- gamePlay(Col, 1, PlayerId).
