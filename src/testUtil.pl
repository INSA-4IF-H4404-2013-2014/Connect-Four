
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS UTILS

%----------------------------
% constant which indicates what is to trace
tracing('none').
%----------------------------

%----------------------------
% constant which indicates if tracing what happend when playing
%tracing('game').
%tracing('iarandom').
%----------------------------

test(TestPredicate) :-
    (call(TestPredicate) ->
        (write(TestPredicate), write(': OK\n')), true ;
        (write(TestPredicate), write(': Failed\n')), fail
    ), !.

writeTrace(Cond, Text) :-
	tracing(Cond) ->
	write(Text);
	true.


gridTrace(Cond, Grid) :-
	tracing(Cond) -> 
	gamePrintGrid(Grid);
	true.
