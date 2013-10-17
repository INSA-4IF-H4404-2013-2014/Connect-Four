
:- [testGridCases].
:- [testUtils].
:- [iaSchemaProcessing].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UNIT TESTS

testIaSchemaCreate :-
    testCaseGridPlayer1IsWining1(R),
    iaSchemaCreate(R, [5,6], [[5,4,0],[6,3,0]]).

testAllIaSchemaProcessing :-
    test(testIaSchemaCreate).
