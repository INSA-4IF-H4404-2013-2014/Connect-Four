
:- [testGridCases].
:- [testUtil].
:- [iaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testIaInferenceConsultDatabase :-
    gameNewGrid(G0),
    gamePlay(G0, 1, 2, G1),
    gamePlay(G1, 4, 2, G2),
    iaInferenceConsultDatabase(G0, 1, _, _, _, 3),
    iaInferenceConsultDatabase(G1, 1, _, _, _, 3),
    iaInferenceConsultDatabase(G2, 1, _, _, _, 6).

testAllIaInferenceDatabase :-
    test(testIaInferenceConsultDatabase).
