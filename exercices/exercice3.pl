
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg2 = arg3[arg1]
% END
    elementFind(1, Pattern, [Pattern|_]).

% FOREACH
    elementFind(Pos, Pattern, [_|ListEnd]) :-
        NextPos is Pos-1, elementFind(NextPos, Pattern, ListEnd).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS!
testsExo3 :-
    elementFind(1, a, [a,b,c,a,b]),
    elementFind(4, a, [a,b,c,a,b]),
    elementFind(2, b, [a,b,c,a,b]),
    not(elementFind(1, a, [])).
