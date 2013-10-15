:- [gameCore].
:- [iaRandom].
:- [gameLauncher].

%Please add here all IAs to be tested. Minimum is 2 IAs.
iaStatsIaList([
	iaRandom,
	iaRandom,
	iaRandom
]).


%Please indicate here the number of matchs per round you want
iaStatsNumberOfMatchsPerRound(100).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaStatsGenEmptyResultsGrid1(0,[]).
privateIaStatsGenEmptyResultsGrid1(Col, [[0,0,0]|Matrix]) :-
    Col1 is Col-1,
    privateIaStatsGenEmptyResultsGrid1(Col1, Matrix).

privateIaStatsGenEmptyResultsGrid(_,0,[]).
privateIaStatsGenEmptyResultsGrid(Ligne, Col, [Y|Matrix]) :-
    Col1 is Col-1,
    privateIaStatsGenEmptyResultsGrid(Ligne, Col1, Matrix),
    privateIaStatsGenEmptyResultsGrid1(Ligne, Y).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaStatsOneRoundLoop2(_, _, 0).
privateIaStatsOneRoundLoop2(Ia1, Ia2, MatchNumber) :-
	NewMatchNumber is (MatchNumber - 1),
	privateIaStatsOneRoundLoop2(Ia1, Ia2, NewMatchNumber),
	writeTrace(iaStats, 'Match number '), writeTrace(iaStats, MatchNumber), writeTrace(iaStats, '\n'),
	launch(Ia1, Ia2, _).

privateIaStatsOneRoundLoop(Ia1, Ia2) :-
	iaStatsNumberOfMatchsPerRound(NumberOfMatchsPerRound),
	privateIaStatsOneRoundLoop2(Ia1, Ia2, NumberOfMatchsPerRound).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaStatsRoundsDispatcher2(_, []).
privateIaStatsRoundsDispatcher2(Ia1, [Ia2|Others]) :-
	writeTrace(iaStats, 'Round: '),
	writeTrace(iaStats, Ia1), writeTrace(iaStats, ' VS '), writeTrace(iaStats, Ia2), writeTrace(iaStats, '\n'),
	privateIaStatsOneRoundLoop(Ia1, Ia2),
	privateIaStatsRoundsDispatcher2(Ia1, Others).

privateIaStatsRoundsDispatcher([]).
privateIaStatsRoundsDispatcher([Ia1|Others]) :-
	privateIaStatsRoundsDispatcher2(Ia1, Others),
	privateIaStatsRoundsDispatcher(Others).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%% Lauches all the IA matches and prints stats %%%%%%%%%%%%%%%%%%%
% I will return false if iaStatsIaList has less than 2 elements.
iaStats :-
	iaStatsIaList(IaList),
	length(IaList, L), L>=2,
	privateIaStatsRoundsDispatcher(IaList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
