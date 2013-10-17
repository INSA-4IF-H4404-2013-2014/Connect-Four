
:- [testGridCases].
:- [testUtils].
:- [iaSchemaProcessing].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testIaSchemaCreate :-
    testCaseGridPlayer1IsWining1(R),
    iaSchemaCreate(R, [5,6], [[5,4,0],[6,3,0]]).

testIaSchemaInsertPawn :-
    iaSchemaInsertPawn([], 3, 2, [[3, 2, 1]]),
    iaSchemaInsertPawn([[3, 2, 1]], 3, 2, [[3, 2, 1]]),
    iaSchemaInsertPawn([[3, 2, 0]], 3, 2, [[3, 2, 0]]),
    iaSchemaInsertPawn([[3, 2, 1]], 2, 2, [[2, 2, 1], [3, 2, 1]]),
    not(iaSchemaInsertPawn([[3, 2, 1]], 3, 2, [[3, 2, 1], [3, 2, 1]])).

testAllIaSchemaProcessing :-
    test(testIaSchemaCreate),
    test(testIaSchemaInsertPawn).
