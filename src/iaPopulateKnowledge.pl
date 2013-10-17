:- [gameLauncher].
:- [iaInference].



% ===============================
% Check if the ActualMatch number is not equal to the MatchAccount wanted.
% If not, launch a match with the Player playing first and increments the ActualMatch counter.
% At the end, it launchs a new match with the AI playing first
% ===============================
privateIaPopulateKnowledge(Player, MatchCount, ActualMatch, 1) :-
	not(ActualMatch = MatchCount),
	launch(Player, iaInference, _),
	ActualMatch1 is ActualMatch + 1,
	privateIaPopulateKnowledge(Player, MatchCount, ActualMatch1, 2).

% ===============================
% Same as above, but with the AI playing first
% ===============================	
privateIaPopulateKnowledge(Player, MatchCount, ActualMatch, 2) :-
	not(ActualMatch = MatchCount),
	launch(iaInference, Player, _),
	ActualMatch1 is ActualMatch + 1,
	privateIaPopulateKnowledge(Player, MatchCount, ActualMatch1, 1).


	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iaPopulateKnowledge(Player, MatchCount)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ==========================================================================	
%
% Launch a series of match between the inference based AI and another player
%	- Player is the player you want the AI to face (human or another AI)
%	- MatchCount is the number of match you want to be played
%	- no return values
%
% ==========================================================================

iaPopulateKnowledge(Player, MatchCount) :- privateIaPopulateKnowledge(Player, MatchCount, 0, 1).
	