
:- [gameSmart].
:- [testUtils].

testCaseGameSmartFullGrid([
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2]
]).

testCaseGameSmartAlmostFullGrid([
    [1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 1, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2]
]).

testCaseGameSmartNoOneWinNextTurn([
    [1, 1, 1, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 2, 1, 2],
    [2, 2, 1, 1, 2],
    []
]).

testCaseGameSmartSuicide([
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 1, 2, 2, 2],
    [2, 2, 2, 1, 1, 1],
    [1, 1, 2, 1, 2, 2],
    [2, 2, 1, 1, 2, 2],
    [1, 1]
]).

testCaseGameSmartSuicide2([
    [],
    [1, 2],
    [1, 2],
    [1, 2],
    [],
    [],
    []
]).

testCaseGameSmartSuicide3([
    [],
    [1, 2],
    [2, 2],
    [1, 2],
    [],
    [1],
    []
]).

testCaseGameSmartPlayer2Win([
    [1],
    [1],
    [1, 2, 2, 2],
    [],
    [],
    [],
    []
]).

testCaseGameSmartPlayer1Win([
    [],
    [1],
    [1,1,2],
    [2,2,1,2],
    [1,2,1],
    [1,2],
    [2,1,1]
]).

testGameCanWin :-
	testCaseGameSmartFullGrid(M1),
	not(gameCanWin(M1, 2, _)),
	gameNewGrid(M2),
	not(gameCanWin(M2, 2, _)),
	testCaseGameSmartNoOneWinNextTurn(M3),
	not(gameCanWin(M3, 2, _)),
	testCaseGameSmartPlayer2Win(M4),
	gameCanWin(M4, 1, 4).

testGameWinningMoves :-
	testCaseGameSmartFullGrid(M1),
	not(gameWinningMoves(M1, 2, _)),
	gameNewGrid(M2),
	not(gameWinningMoves(M2, 2, _)),
	testCaseGameSmartNoOneWinNextTurn(M3),
	not(gameWinningMoves(M3, 2, _)),
	testCaseGameSmartPlayer2Win(M4),
	gameWinningMoves(M4, 2, _),
	testCaseGameSmartPlayer1Win(M5),
	gameWinningMoves(M5, 1, _),
	testCaseGameSmartAlmostFullGrid(M6),
	gameWinningMoves(M6, 2, _),
	not(gameWinningMoves(M6, 1, _)).

testGameObviousMove :-
    gameNewGrid(G0),
    testCaseGameSmartPlayer1Win(G1),
    not(gameObviousMove(G0, 1, 1)),
    not(gameObviousMove(G0, 2, 1)),
    (gameObviousMove(G1, 2, 5) ; gameObviousMove(G1, 2, 6)).

testGameIsSuicideMove :-
    testCaseGameSmartAlmostFullGrid(G1),
    testCaseGameSmartSuicide(G2),
    not(gameIsSuicideMove(G1, 1, 1)),
    not(gameIsSuicideMove(G1, 2, 1)),
    gameIsSuicideMove(G2, 2, 7),
    not(gameIsSuicideMove(G2, 1, 7)).

testGameSuicideMoves :-
    testCaseGameSmartSuicide(G1),
    testCaseGameSmartSuicide2(G2),
    testCaseGameSmartSuicide3(G3),
    gameSuicideMoves(G1, 1, []),
    gameSuicideMoves(G1, 2, [7]),
    gameSuicideMoves(G2, 1, []),
    gameSuicideMoves(G2, 2, []),
    gameSuicideMoves(G3, 1, [1, 5]),
    gameSuicideMoves(G3, 2, []).

testAllGameSmart :-
	test(testGameCanWin),
	test(testGameWinningMoves),
    test(testGameObviousMove),
    test(testGameIsSuicideMove),
    test(testGameSuicideMoves).
