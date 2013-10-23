:- [gamePrint].
:- [uiPlayer].
:- [playerRandom].
:- [playerTreeExplorer].
:- [aiPlayer].

playerList(uiPlayer).
playerList(playerRandom).
playerList(playerTreeExplorer).
playerList(aiPlayer).

ui(PlayerAgainst, 1) :-
	playerList(PlayerAgainst),
	gameProcess(uiPlayer, PlayerAgainst, R, FinishGrid),
	privateUiPrintEnd(FinishGrid, R).

ui(PlayerAgainst, 2) :-
	playerList(PlayerAgainst),
	gameProcess(PlayerAgainst, uiPlayer, R, FinishGrid),
	privateUiPrintEnd(FinishGrid, R).

privateUiPrintEnd(FinishGrid, R) :-
	gamePrintGrid(FinishGrid),
	(
		( (R == 0) -> write('This is a draw match! Don\'t stay on a draw match. Play again and LET THE BEST WIN!') ) ;
		( (R == 1) -> write('Player 1 WON!') ) ;
		( (R == 2) -> write('Player 2 WON!') )
	).
