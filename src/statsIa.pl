:- [gameCore].
:- [iaRandom].
:- [gameLauncher].

%%%%%%%%%%%%%%%%%%%%%%%% SETTINGS - EDIT ACCORDINGLY %%%%%%%%%%%%%%%%%%%%%%%%%%%
%Please add here all IAs to be tested, and give them a primary key.
statsIaFightingIaDB(iaRandom, 1).
statsIaFightingIaDB(iaRandom, 2).
statsIaFightingIaDB(iaRandom, 3).
statsIaFightingIaDB(iaRandom, 4).

%Please indicate here the number of matchs per round you want.
statsIaNumberOfMatchsPerRound(100).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%% Lauches all the IA matches and prints stats %%%%%%%%%%%%%%%%%%%
statsIa :-
	privateStatsIaPopulateStatsDB,
	write('\n'),
	privateStatsIaPrintInfos,
	write('\n'),
	privateStatsIaPrintTournamentResults.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





:- dynamic statsIaTournamentResultsDB/4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaPopulateStatsDB :-
	retractall(statsIaTournamentResultsDB(_,_,_,_)),
	forall((statsIaFightingIaDB(Ia1, Ia1Id), statsIaFightingIaDB(Ia2, Ia2Id)),
	(
		write('Computing Round: '),
		write(Ia1), write(' ('), write(Ia1Id), write(') \\VS/ '),
		write(Ia2), write(' ('), write(Ia2Id), write(')...\n'),
		privateStatsIaOneRoundLoop(Ia1Id, Ia2Id)
	)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaPrintInfos :-
	privateStatsIaNumberOfTruePredicates(statsIaFightingIaDB(_,_), NumberOfFightingIas),
	statsIaNumberOfMatchsPerRound(NumberOfMatchsPerRound),
	TotalRounds is (NumberOfFightingIas*NumberOfFightingIas),
	TotalMatchs is (NumberOfMatchsPerRound*TotalRounds),
	write('Total fighting IAs: '), write(NumberOfFightingIas), write('\n'),
	write('Matchs per round: '), write(NumberOfMatchsPerRound), write('\n'),
	write('Total Rounds: '), write(TotalRounds), write('\n'),
	write('Total Matchs: '), write(TotalMatchs), write('\n').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaPrintTournamentResults :-
	write('                      '),
	forall(statsIaFightingIaDB(X,Y),
		writef('%22C', [X])),
	write('\n                      '),
	forall(statsIaFightingIaDB(X,Y),
		writef('  %6C%6C%6C  ', [ia1,ia2,draw])),
	write('\n\n'),

	forall(statsIaFightingIaDB(X1,X2),
	(
		%For each line
		writef('%22R', [X1]),
		forall(statsIaFightingIaDB(_,Y2),
		(
			%For each column
			write('  '),
			forall(statsIaTournamentResultsDB(X2,Y2,_,R),
			(
				%For each result
				writef('%6C', [R])
			)),
			write('  ')
		)),
		write('\n\n')
	)),

	write('Legend:\n'),
	writef('%6L%w', ['ia1', 'Number of matchs won by the IA printed on the left\n']),
	writef('%6L%w', ['ia2', 'Number of matchs won by the IA printed on the top\n']),
	writef('%6L%w', ['draw', 'Number of draw matchs between the 2 IAs\n\n']).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% Launches one loop of matchs (a round) and records the results %%%%%%%%%
% The number of matchs in a round is controlled by
%		statsIaNumberOfMatchsPerRound(X).
%
% A round means two given IAs playing against each other lots of times.
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


%%%%%%%%%%%%%%%%% Helper: return number of true predicates %%%%%%%%%%%%%%%%%%%%%
privateStatsIaNumberOfTruePredicates(Predicate, Result) :-
	findall(1, Predicate, List),
	length(List, Result).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
