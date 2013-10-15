
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDES

:- [gameCore].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATABASE
% free
% 1 : the winner
% 2 : the looser
:- dynamic iaInferenceDB/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LEARN THE FIRST SHEMA
% N W W W M
:- assert(iaInferenceDB([
    [0, 0, 0],
    [1, 0, 1],
    [2, 0, 1],
    [3, 0, 1],
    [4, 0, 0]
])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HOW IS
% test a player status (winner of looser)
% iaInferencePlayerStatus(WinnerId, PlayerId, PlayerStatus).
iaInferencePlayerStatus(X, X, 1).
iaInferencePlayerStatus(X, Y, 2) :- gameOtherPlayer(X, Y).
