
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% isSet(A)
% END
    isSet(_, []).

% FOREACH
    isSet(Tested, [X|Remainings]) :-
        not(member(X, Tested)),
        isSet([X|Tested], Remainings).

% INIT
    isSet(List) :-
        isSet([], List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg2 = set(arg1)
% END
    genSet([], Result, Result).

% FOREACH
    genSet([X|L], Result, BuildedSet) :-
        member(X, BuildedSet) ->
        genSet(L, Result, BuildedSet) ;
        genSet(L, Result, [X|BuildedSet]).

% INIT
    genSet(L,Result) :-
        genSet(L, Result, []).


% all following function are assuming the parameters
% are (un)ordered sets!!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg3 = arg1 U arg2
% END
    setUnion([], Result, Result).

% FOREACH
    setUnion([X|A], Union, Result) :-
        member(X,Union) ->
        setUnion(A,Union,Result) ;
        setUnion(A, [X|Union], Result).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg3 = arg1 inter arg2
% END
    setInter([], _, Result, Result).

% FOREACH
    setInter([X|A], B, Result, Inter) :-
        member(X,B) ->
        setInter(A, B, Result, [X|Inter]) ;
        setInter(A, B, Result, Inter).

% INIT
    setInter(A, B, Result) :-
        setInter(A, B, Result, []).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% arg3 = arg1 - arg2
% END
    setMinus([], _, Result, Result).

% FOREACH
    setMinus([X|A], B, Result, Inter) :-
        member(X,B) ->
        setMinus(A, B, Result, Inter) ;
        setMinus(A, B, Result, [X|Inter]).

% INIT
    setMinus(A, B, Result) :-
        setMinus(A, B, Result,[]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (arg1 = arg2)
% CALL (A = B) <=> (A - B = B - A)
    areEqualSets(A, B) :-
        setMinus(A, B, Minus),
        setMinus(B, A, Minus).

% Actualy, the areEqualSets time complexity is the same as
% setMinus O(len(A)*len(B)). But with sorted sets given into
% parameters, this complexity would fall down to
% O(min(len(A),len(B))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS!
testsExo4 :-
    isSet([]),
    isSet([a,b,c]),
    not(isSet([a,b,a,c])),

    genSet([], []),
    genSet([a,b], R21),              areEqualSets(R21,[a,b]),
    genSet([a,b,a,b,c], R22),        areEqualSets(R22,[a,b,c]),

    areEqualSets([], []),
    areEqualSets([a,b], [a,b]),
    areEqualSets([a,b], [b,a]),

    setUnion([], [], []),
    setUnion([a,b], [], R01),        areEqualSets(R01, [a,b]),
    setUnion([], [a,b], R02),        areEqualSets(R02, [a,b]),
    setUnion([a,b], [c,d], R03),     areEqualSets(R03, [a,b,c,d]),
    setUnion([a,b,c], [c,d], R04),   areEqualSets(R04, [a,b,c,d]),

    setInter([], [], []),
    setInter([a,b], [], []),
    setInter([], [a,b], []),
    setInter([a,b], [b,c], [b]),

    setMinus([], [], []),
    setMinus([a], [], [a]),
    setMinus([], [a,b], []),
    setMinus([a,b,c,d], [b,d], R05), areEqualSets(R05, [a,c]).
