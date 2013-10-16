:- [gamePrint].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRACE UTILS
%----------------------------
% constant which indicates what is to trace (by default 'none' but can add the other )
tracing('none').

% constant which indicates if tracing what happend when playing
% tracing('game').

% constant which indicates if printing an graphical interface for player s ia(redundant with 'game')
% tracing('graphInt').

% Should iaRandom unit test tracing be activated?
%tracing('iarandom').

%Should iaStats-module's statistics be displayed?
%tracing('statsIa').
%----------------------------

writeTrace(Cond, Text) :-
	tracing(Cond) ->
	write(Text);
	true.

gridTrace(Cond, Grid) :-
	tracing(Cond) ->
	gamePrintGrid(Grid);
	true.
