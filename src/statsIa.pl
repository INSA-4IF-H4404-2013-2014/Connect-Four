:- [gameCore].
:- [iaRandom].
:- [gameLauncher].

%Please add here all IAs to be tested.
%Give them a primary key.
statsIaFightingIaDB(iaRandom, 1).
statsIaFightingIaDB(iaRandom, 2).
statsIaFightingIaDB(iaRandom, 3).
statsIaFightingIaDB(iaRandom, 4).
statsIaFightingIaDB(iaRandom, 5).
statsIaFightingIaDB(iaRandom, 6).

%Please indicate here the number of matchs per round you want
statsIaNumberOfMatchsPerRound(100).

%%%%%%%%%%%%%%%% Lauches all the IA matches and prints stats %%%%%%%%%%%%%%%%%%%
statsIa :-
	privateStatsIaPopulateStatsDB,
	privateStatsIaPrintTournamentResults.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




:- dynamic statsIaTournamentResultsDB/4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaPopulateStatsDB :-
	retractall(statsIaTournamentResultsDB(_,_,_,_)),
	forall((statsIaFightingIaDB(Ia1, Ia1Id), statsIaFightingIaDB(Ia2, Ia2Id)),
	(
		write('Computing Round: '),
		write(Ia1), write(' ('), write(Ia1Id), write(') \VS/ '),
		write(Ia2), write(' ('), write(Ia2Id), write(')\n'),
		privateStatsIaOneRoundLoop(Ia1Id, Ia2Id)
	)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaPrintTournamentResults :-
	write('                     '),
	forall(statsIaFightingIaDB(X,Y),
		writef('%21C', [X])),
	write('\n                     '),
	forall(statsIaFightingIaDB(X,Y),
		writef('%7C%7C%7C', [ia1,ia2,draw])),
	write('\n'),

	forall(statsIaFightingIaDB(X1,X2),
	(
		%For each line
		writef('%21R', [X1]),
		forall(statsIaFightingIaDB(_,Y2),
		(
			%For each column
			forall(statsIaTournamentResultsDB(X2,Y2,_,R),
			(
				%For each result
				writef('%7C', [R])
			))
		)),
		write('\n')
	)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% Launches one loop of matchs (a round) and records the results %%%%%%%%%
% The number of matchs in a round is controlled by
%		statsIaNumberOfMatchsPerRound(X).
%
% A round means two given IAs playing against each other lots of several times.
%
privateStatsIaOneRoundLoop(Ia1Id, Ia2Id) :-
	statsIaFightingIaDB(Ia1, Ia1Id), statsIaFightingIaDB(Ia2, Ia2Id),
	statsIaNumberOfMatchsPerRound(NumberOfMatchsPerRound),
	privateStatsIaOneRoundLoop2(Ia1, Ia2, NumberOfMatchsPerRound, NbWon1, NbWon2, NbDraw),
	asserta(statsIaTournamentResultsDB(Ia1Id, Ia2Id, 0, NbDraw)),
	asserta(statsIaTournamentResultsDB(Ia1Id, Ia2Id, 1, NbWon1)),
	asserta(statsIaTournamentResultsDB(Ia1Id, Ia2Id, 2, NbWon2)), !.

privateStatsIaOneRoundLoop2(_, _, 0, 0, 0, 0).
privateStatsIaOneRoundLoop2(Ia1, Ia2, MatchNumber, NbWon1, NbWon2, NbDraw) :-
	NewMatchNumber is (MatchNumber - 1),
	privateStatsIaOneRoundLoop2(Ia1, Ia2, NewMatchNumber, NbWon1Bis, NbWon2Bis, NbDrawBis),
	launch(Ia1, Ia2, MatchResult),
	privateStatsIaIncrementTool(MatchResult, NbWon1Bis, NbWon2Bis, NbDrawBis, NbWon1, NbWon2, NbDraw).

privateStatsIaIncrementTool(0, NbWon1, NbWon2, NbDraw, NbWon1, NbWon2, NbDrawBis) :- NbDrawBis is (NbDraw + 1).
privateStatsIaIncrementTool(1, NbWon1, NbWon2, NbDraw, NbWon1Bis, NbWon2, NbDraw) :- NbWon1Bis is (NbWon1 + 1).
privateStatsIaIncrementTool(2, NbWon1, NbWon2, NbDraw, NbWon1, NbWon2Bis, NbDraw) :- NbWon2Bis is (NbWon2 + 1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
