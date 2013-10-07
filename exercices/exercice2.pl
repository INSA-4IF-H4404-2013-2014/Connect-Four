
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Text existance d'un membre dans une liste
% END
    membre(X, [X|_]).

% FOREACH
    membre(X, [_|L]) :- membre(X, L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Soustraction ensembliste : arg2\arg1 = arg3
% END
    element1(X, [X|R], R).

% FOREACH
    element1(X, [T|Q1], [T|Q2]) :- element1(X, Q1, Q2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Extraction des permutations
% END
    extract(List, [X]) :-
        membre(X, List).

% FOREACH
    extract(List, [X|L]) :-
        element1(X, List, R), extract(R, L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Concatenation de listes
% END
    concatLists([], Result, Result).

% FOREACH
    concatLists([X|ListA], ListB, [X|Result]) :-
        concatLists(ListA, ListB, Result).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Inversion de la liste
% END
    invertList([], []).

% FOREACH
    invertList([X|List], Return) :-
        invertList(List, Result), concatLists(Result, [X], Return).


% --------- GOTO: MARTIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg4 = arg3.replaceAll(arg1 by arg2)
% END
    subsAll(_, _, [], []).

% FOREACH
    subsAll(Pattern, Replace, [Pattern|List], [Replace|Result]) :-
        subsAll(Pattern, Replace, List, Result).
    subsAll(Pattern, Replace, [X|List], [X|Result]) :-
        subsAll(Pattern, Replace, List, Result), not(X = Pattern).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg4 = arg3.replaceFirst(arg1 by arg2)
% END
    subsFirst(Pattern, Replace, [Pattern|List], [Replace|List]).

% FOREACH
    subsFirst(Pattern, Replace, [X|List], [X|Result]) :-
        subsFirst(Pattern, Replace, List, Result), not(X = Pattern).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg4 = arg3.replaceOnce(arg1 by arg2)
% END
    subsOnce(Pattern, Replace, [Pattern|List], [Replace|List]).

% FOREACH
    subsOnce(Pattern, Replace, [X|List], [X|Result]) :-
        subsOnce(Pattern, Replace, List, Result).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS!
testsExo2 :-
    membre(a, [a,b]),
    not(membre(x, [a,b])),

	element1(b,[a,b,c],[a,c]),
	element1(a,[a,b,c],[b,c]),
	element1(a,[b,a,c],[b,c]),
	element1(a,[b,d,w,z,d,a],[b,d,w,z,d]),
	
    extract([a,b,c,d], [b,c]),
    extract([a,b,c,d], [c,b]),

    concatLists([], [], []),
    concatLists([a,b], [], [a,b]),
    concatLists([], [a,b], [a,b]),
    concatLists([a,b], [c,d], [a,b,c,d]),

    invertList([], []),
    invertList([a,b], [b,a]),

    subsAll(x, y, [a,x,b,x], [a,y,b,y]),

    subsFirst(x, y, [a,x,b,x], [a,y,b,x]),
    not(subsFirst(x, y, [a,x,b,x], [a,x,b,y])),
    not(subsFirst(x, y, [a,x,b,x], [a,y,b,y])),

    subsOnce(x, y, [a,x,b,x], [a,y,b,x]),
    subsOnce(x, y, [a,x,b,x], [a,x,b,y]),
    not(subsOnce(x, y, [a,x,b,x], [a,y,b,y])).
