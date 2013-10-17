:- [gameCore].
:- [playerRandom].
:- [gameLauncher].

%%%%%%%%%%%%%%%%%%%%%%%% SETTINGS - EDIT ACCORDINGLY %%%%%%%%%%%%%%%%%%%%%%%%%%%
%Please add here all players to be tested, and give them a primary key.
statsPlayerFightingPlayerDB(playerRandom, 1).
statsPlayerFightingPlayerDB(playerRandom, 2).
statsPlayerFightingPlayerDB(playerRandom, 3).
statsPlayerFightingPlayerDB(playerRandom, 4).

%Please indicate here the number of matchs per round you want.
statsPlayerNumberOfMatchsPerRound(100).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% Lauches all the matches and prints stats %%%%%%%%%%%%%%%%%%%%
statsPlayer :-
	privateStatsPlayerPopulateStatsDB,
	write('\n'),
	privateStatsPlayerPrintInfos,
	write('\n'),
	privateStatsPlayerPrintTournamentResults.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





:- dynamic statsPlayerTournamentResultsDB/4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsPlayerPopulateStatsDB :-
	retractall(statsPlayerTournamentResultsDB(_,_,_,_)),
	forall((statsPlayerFightingPlayerDB(P1, P1Id), statsPlayerFightingPlayerDB(P2, P2Id)),
	(
		write('Computing Round: '),
		write(P1), write(' ('), write(P1Id), write(') \\VS/ '),
		write(P2), write(' ('), write(P2Id), write(')...\n'),
		privateStatsPlayerOneRoundLoop(P1Id, P2Id)
	)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsPlayerPrintInfos :-
	privateStatsPlayerNumberOfTruePredicates(statsPlayerFightingPlayerDB(_,_), NumberOfFightingPlayers),
	statsPlayerNumberOfMatchsPerRound(NumberOfMatchsPerRound),
	TotalRounds is (NumberOfFightingPlayers*NumberOfFightingPlayers),
	TotalMatchs is (NumberOfMatchsPerRound*TotalRounds),
	write('Total fighting players: '), write(NumberOfFightingPlayers), write('\n'),
	write('Matchs per round: '), write(NumberOfMatchsPerRound), write('\n'),
	write('Total Rounds: '), write(TotalRounds), write('\n'),
	write('Total Matchs: '), write(TotalMatchs), write('\n').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsPlayerPrintTournamentResults :-
	write('                      '),
	forall(statsPlayerFightingPlayerDB(X,Y),
		writef('%22C', [X])),
	write('\n                      '),
	forall(statsPlayerFightingPlayerDB(X,Y),
		writef('  %6C%6C%6C  ', [p1,p2,draw])),
	write('\n\n'),

	forall(statsPlayerFightingPlayerDB(X1,X2),
	(
		%For each line
		writef('%22R', [X1]),
		forall(statsPlayerFightingPlayerDB(_,Y2),
		(
			%For each column
			write('  '),
			forall(statsPlayerTournamentResultsDB(X2,Y2,_,R),
			(
				%For each result
				writef('%6C', [R])
			)),
			write('  ')
		)),
		write('\n\n')
	)),

	write('Legend:\n'),
	writef('%6L%w', ['p1', 'Number of matchs won by the player printed on the left\n']),
	writef('%6L%w', ['p2', 'Number of matchs won by the player printed on the top\n']),
	writef('%6L%w', ['draw', 'Number of draw matchs between the 2 players\n\n']).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% Launches one loop of matchs (a round) and records the results %%%%%%%%%
% The number of matchs in a round is controlled by
%		statsPlayerNumberOfMatchsPerRound(X).
%
% A round means two given Players playing against each other lots of times.
%
privateStatsPlayerOneRoundLoop(P1Id, P2Id) :-
	statsPlayerFightingPlayerDB(P1, P1Id), statsPlayerFightingPlayerDB(P2, P2Id),
	statsPlayerNumberOfMatchsPerRound(NumberOfMatchsPerRound),
	privateStatsPlayerOneRoundLoop2(P1, P2, NumberOfMatchsPerRound, NbWon1, NbWon2, NbDraw),
	asserta(statsPlayerTournamentResultsDB(P1Id, P2Id, 0, NbDraw)),
	asserta(statsPlayerTournamentResultsDB(P1Id, P2Id, 1, NbWon1)),
	asserta(statsPlayerTournamentResultsDB(P1Id, P2Id, 2, NbWon2)), !.

privateStatsPlayerOneRoundLoop2(_, _, 0, 0, 0, 0).
privateStatsPlayerOneRoundLoop2(P1, P2, MatchNumber, NbWon1, NbWon2, NbDraw) :-
	NewMatchNumber is (MatchNumber - 1),
	privateStatsPlayerOneRoundLoop2(P1, P2, NewMatchNumber, NbWon1Bis, NbWon2Bis, NbDrawBis),
	launch(P1, P2, MatchResult),
	privateStatsPlayerIncrementTool(MatchResult, NbWon1Bis, NbWon2Bis, NbDrawBis, NbWon1, NbWon2, NbDraw).

privateStatsPlayerIncrementTool(0, NbWon1, NbWon2, NbDraw, NbWon1, NbWon2, NbDrawBis) :- NbDrawBis is (NbDraw + 1).
privateStatsPlayerIncrementTool(1, NbWon1, NbWon2, NbDraw, NbWon1Bis, NbWon2, NbDraw) :- NbWon1Bis is (NbWon1 + 1).
privateStatsPlayerIncrementTool(2, NbWon1, NbWon2, NbDraw, NbWon1, NbWon2Bis, NbDraw) :- NbWon2Bis is (NbWon2 + 1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% Helper: return number of true predicates %%%%%%%%%%%%%%%%%%%%%
privateStatsPlayerNumberOfTruePredicates(Predicate, Result) :-
	findall(1, Predicate, List),
	length(List, Result).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
