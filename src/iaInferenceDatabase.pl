
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATABASE
% free
% 1 : the winner
% 2 : the looser
:- dynamic iaInferenceDB/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN THE FIRST CASE
:- assert(iaInferenceDB([[1,1,1,1]])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HOW IS
% test a player status (winner of looser)
% iaInferencePlayerStatus(WinnerId, PlayerId, PlayerStatus).
iaInferencePlayerStatus(X, X, 1).
iaInferencePlayerStatus(X, Y, 2) :- gameOtherPlayer(X, Y).
