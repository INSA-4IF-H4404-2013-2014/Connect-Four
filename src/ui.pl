:- [gamePrint].
:- [uiPlayer].
:- [playerRandom].
:- [playerTreeExplorer].
:- [aiPlayer].
:- [gamePrint].

playerList(uiPlayer).
playerList(playerRandom).
playerList(playerRandomKamikaze).
playerList(playerRandomSmart).
playerList(playerTreeExplorer).
playerList(aiPlayer).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUCHES uiPlayer / uiPlayer game
ui :- ui(uiPlayer, 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUCHES uiPlayer / PlayerAgainst game
ui(PlayerAgainst, 1) :-
	playerList(PlayerAgainst),
	gameProcess(uiPlayer, PlayerAgainst, R, FinishGrid),
	privateUiPrintEnd(FinishGrid, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAUCHES PlayerAgainst / uiPlayer game
ui(PlayerAgainst, 2) :-
	playerList(PlayerAgainst),
	gameProcess(PlayerAgainst, uiPlayer, R, FinishGrid),
	privateUiPrintEnd(FinishGrid, R).

privateUiPrintEnd(FinishGrid, R) :-
	gamePrintGrid(FinishGrid),
	uiColors(Colored),
	gamePrintSymbols(Colored, R, Symb),
	(
		( (R == 0) -> write('\nThis is a DRAW match! Don\'t stay on a draw match. Play again and LET THE BEST WIN!') ) ;
		( (R == 1) -> ( write('\nPlayer 1 ('), write(Symb), write(') WON!') ) ) ;
		( (R == 2) -> ( write('\nPlayer 2 ('), write(Symb), write(') WON!') ) )
	).
