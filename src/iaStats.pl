:- [gameCore].
:- [iaRandom].
:- [gameLauncher].

%Please add here all IAs
iaStatsIaList([
	iaRandom,
	iaRandom,
	iaRandom,
	iaRandom
]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
privateIaStatsGenEmptyResultsGrid(0,[]).

privateIaStatsGenEmptyResultsGrid(Col, [[]|Matrix]) :-
    Col1 is Col-1,
    privateIaStatsGenEmptyResultsGrid(Col1, Matrix).

privateIaStatsGenEmptyResultsGrid(ResultsGrid) :-
	iaStatsIaList(IaList),
	length(IaList, NumberOfIa),
    privateIaStatsGenEmptyResultsGrid(NumberOfIa, ResultsGrid), !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


privateIaStatsOneMatchLoop2(_, _, 101).
privateIaStatsOneMatchLoop2(Ia1, Ia2, MatchInstanceNumber) :-
%	write('Match instance '), write(MatchInstanceNumber), write('\n'),
	launch(Ia1, Ia2, _),
	NewMatchInstanceNumber is (MatchInstanceNumber + 1),
	privateIaStatsOneMatchLoop2(Ia1, Ia2, NewMatchInstanceNumber).

privateIaStatsOneMatchLoop(Ia1, Ia2) :-
	privateIaStatsOneMatchLoop2(Ia1, Ia2, 1).




privateIaStatsLaunchMatch2(_, []).
privateIaStatsLaunchMatch2(Ia1, [Ia2|Others]) :-
%	write('Match1: '),
%	write(Ia1), write(' VS '), write(Ia2), write('\n'),
	privateIaStatsOneMatchLoop(Ia1, Ia2),
	privateIaStatsLaunchMatch2(Ia1, Others).

privateIaStatsLaunchMatch1([]).
privateIaStatsLaunchMatch1([Ia1|Others]) :-
	privateIaStatsLaunchMatch2(Ia1, Others),
	privateIaStatsLaunchMatch1(Others).


%%%%%%%%%%%%%%%% Lauches all the IA matches and prints stats %%%%%%%%%%%%%%%%%%%
iaStats :-
	iaStatsIaList(IaList),
	privateIaStatsLaunchMatch1(IaList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
