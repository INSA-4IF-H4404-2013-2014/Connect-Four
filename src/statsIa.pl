:- [gameCore].
:- [iaRandom].
:- [gameLauncher].
:- [traceUtil].

%Please add here all IAs to be tested. Minimum is 2 IAs.
statsIaIaList([
	iaRandom,
	iaRandom,
	iaRandom
]).


%Please indicate here the number of matchs per round you want
statsIaNumberOfMatchsPerRound(100).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaGenEmptyResultsGrid1(0,[]).
privateStatsIaGenEmptyResultsGrid1(Col, [[0,0,0]|Matrix]) :-
    Col1 is Col-1,
    privateStatsIaGenEmptyResultsGrid1(Col1, Matrix).

privateStatsIaGenEmptyResultsGrid(_,0,[]).
privateStatsIaGenEmptyResultsGrid(Ligne, Col, [Y|Matrix]) :-
    Col1 is Col-1,
    privateStatsIaGenEmptyResultsGrid(Ligne, Col1, Matrix),
    privateStatsIaGenEmptyResultsGrid1(Ligne, Y).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaOneRoundLoop2(_, _, 0).
privateStatsIaOneRoundLoop2(Ia1, Ia2, MatchNumber) :-
	NewMatchNumber is (MatchNumber - 1),
	privateStatsIaOneRoundLoop2(Ia1, Ia2, NewMatchNumber),
	writeTrace(statsIa, 'Match number '), writeTrace(statsIa, MatchNumber), writeTrace(statsIa, '\n'),
	launch(Ia1, Ia2, _).

privateStatsIaOneRoundLoop(Ia1, Ia2) :-
	statsIaNumberOfMatchsPerRound(NumberOfMatchsPerRound),
	privateStatsIaOneRoundLoop2(Ia1, Ia2, NumberOfMatchsPerRound).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateStatsIaRoundsDispatcher2(_, []).
privateStatsIaRoundsDispatcher2(Ia1, [Ia2|Others]) :-
	writeTrace(statsIa, 'Round: '),
	writeTrace(statsIa, Ia1), writeTrace(statsIa, ' VS '), writeTrace(statsIa, Ia2), writeTrace(statsIa, '\n'),
	privateStatsIaOneRoundLoop(Ia1, Ia2),
	privateStatsIaRoundsDispatcher2(Ia1, Others).

privateStatsIaRoundsDispatcher([]).
privateStatsIaRoundsDispatcher([Ia1|Others]) :-
	privateStatsIaRoundsDispatcher2(Ia1, Others),
	privateStatsIaRoundsDispatcher(Others).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%% Lauches all the IA matches and prints stats %%%%%%%%%%%%%%%%%%%
% I will return false if statsIaIaList has less than 2 elements.
statsIa :-
	statsIaIaList(IaList),
	length(IaList, L), L>=2,
	privateStatsIaRoundsDispatcher(IaList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
