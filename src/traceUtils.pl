:- [gamePrint].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRACE UTILS
%----------------------------
% constant which indicates what is to trace (by default 'none' but can add the other )
tracing(none).

% constant which indicates if tracing what happend when playing
%tracing(game).

% Should playerRandom unit test tracing be activated?
%tracing(playerrandom).
%----------------------------

writeTrace(Cond, Text) :-
	tracing(Cond) ->
	write(Text);
	true.

gridTrace(Cond, Grid) :-
	tracing(Cond) ->
	gamePrintGrid(Grid);
	true.
