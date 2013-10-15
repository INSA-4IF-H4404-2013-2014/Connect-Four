
testCaseGridColumn34([
    [],
    [],
    [],
    [1,1,1,1],
    [2,2,2],
    [],
    []
]).

testCaseGridPlayer1IsWining1([
    [],
    [1],
    [1,1,2],
    [2,2,1,2],
    [1,2,1],
    [1,2],
    [2,1,1]
]).

testCaseGridPlayer1Win1(R) :-
    testCaseGridPlayer1IsWining1(R0),
    gamePlay(R0, 6, 2, R1),
    gamePlay(R1, 5, 1, R).
