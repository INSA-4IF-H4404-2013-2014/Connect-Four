
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg2 = arg3[arg1]
% END
    elementFind(Pos, Pattern, [Pattern|_],Pos).

% FOREACH
    elementFind(Pos, Pattern, [_|ListEnd], CurPos) :-
        NextPos is CurPos+1, elementFind(Pos, Pattern, ListEnd, NextPos).

% INIT
    elementFind(Pos, Pattern, List) :-
        elementFind(Pos, Pattern, List, 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS!
testsExo3 :-
    elementFind(1, a, [a,b,c,a,b]),
    elementFind(4, a, [a,b,c,a,b]),
    elementFind(2, b, [a,b,c,a,b]),
    not(elementFind(1, a, [])).
