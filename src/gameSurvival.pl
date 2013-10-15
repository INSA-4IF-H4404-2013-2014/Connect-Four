:- [gameCore].
:- [gameOver].

% Survival predicat
% Return true if one player can block the other
% Test if 3 enemy's pawns are aligned, and try to play
% Player is playing, we test if OtherPlayer can win next turn


otherCanWin(Grid, Player, Column) :- gameOtherPlayer(Player, OtherPlayer), gamePlay(Grid, Column, OtherPlayer, GridResult), gameOver(GridResult, Column, OtherPlayer).

survive(Grid, Player, Column, 7) :- otherCanWin(Grid, Player, 7), Column is 7.
survive(Grid, Player, Column, Pos) :- (otherCanWin(Grid, Player, Pos), Column is Pos) ; (NextColumn is Pos +1, survive(Grid, Player, Column, NextColumn)).
survive(Grid, Player, Column) :- survive(Grid, Player, Column, 1), !.
