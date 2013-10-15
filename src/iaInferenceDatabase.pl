
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATABASE
% 0 : occupied but don't care the player id
% 1 : the winner
% 2 : the looser
:- dynamic iaInferenceDB/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN THE FIRST CASE
:- assert(iaInferenceDB([[1,1,1,1]])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HOW IS
% iaInferencePlayerStatus(WinnerId, PlayerId, PlayerStatus).
iaInferencePlayerStatus(X, X, 1).
iaInferencePlayerStatus(X, Y, 2) :- gameOtherPlayer(X, Y).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN PREDICATE

%iaInferenceAnalysis(Grid, LastWinnerMove, Shem).
