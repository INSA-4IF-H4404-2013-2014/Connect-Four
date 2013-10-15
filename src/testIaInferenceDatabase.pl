
:- [testGridCases].
:- [testUtil].
:- [iaInferenceDatabase].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testIaInferencePlayerStatus :-
    iaInferencePlayerStatus(1, 1, 1),
    iaInferencePlayerStatus(2, 2, 1),
    iaInferencePlayerStatus(2, 1, 2),
    iaInferencePlayerStatus(1, 2, 2),
    not(iaInferencePlayerStatus(1, 1, 2)),
    not(iaInferencePlayerStatus(2, 2, 2)),
    not(iaInferencePlayerStatus(2, 1, 1)),
    not(iaInferencePlayerStatus(1, 2, 1)).

testAllIaInferenceDatabase :-
    test(testIaInferencePlayerStatus).
