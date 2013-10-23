
:- [utils].
:- [aiKnowledge].


% ==============================================================================
% aiKnowledgeLoad(FilePath)
% -------------------------
% <FilePath> : the knowledge database's file path
% ==============================================================================

aiKnowledgeLoad(FilePath) :-
    aiKnowledgeLoad(FilePath, Schemas) -> (
        privateAiKnowledgeLoadSave(Schemas)
    ).

aiKnowledgeLoad(FilePath, Schemas) :-
    utilReadFile(FilePath, Lines) -> (
        privateAiKnowledgeLoad(Lines, Schemas)
    ).


% ==============================================================================
% aiKnowledgeStore(FilePath)
% -------------------------
% <FilePath> : the knowledge database's file path to write to
% ==============================================================================

aiKnowledgeStore(FilePath) :-
    aiKnowledgeAll(Schemas) -> (
        aiKnowledgeStore(FilePath, Schemas)
    ).

aiKnowledgeStore(FilePath, Schemas) :-
    open(FilePath, write, Stream) -> (
        privateAiKnowledgeStore(Stream, Schemas),
        close(Stream)
    ).


% ====================================================================== PRIVATE

privateAiKnowledgeLoad([], []).

privateAiKnowledgeLoad([Line|Lines], [Schema|Schemas]) :-
    atomic_list_concat(ElementRaws, ',', Line),
    privateAiKnowledgeLoadLine(ElementRaws, Schema),
    privateAiKnowledgeLoad(Lines, Schemas).


privateAiKnowledgeLoadLine([], []).

privateAiKnowledgeLoadLine([ElementRaw|ElementRaws], [[X, Y, Z]|Elements]) :-
    atomic_list_concat([RawX, RawY, RawZ], ' ', ElementRaw),
    atom_number(RawX, X),
    atom_number(RawY, Y),
    atom_number(RawZ, Z),
    privateAiKnowledgeLoadLine(ElementRaws, Elements).

privateAiKnowledgeLoadSave([]).

privateAiKnowledgeLoadSave([Schema|Schemas]) :-
    aiKnowledgeSaveSchema(Schema),
    privateAiKnowledgeLoadSave(Schemas).



privateAiKnowledgeStore(_, []).
privateAiKnowledgeStore(Stream, [[Element|Schema]|Schemas]) :-
    write(Stream, '\''),
    privateAiKnowledgeStoreElement(Stream, Element),
    privateAiKnowledgeStoreSchema(Stream, Schema),
    privateAiKnowledgeStore(Stream, Schemas).

privateAiKnowledgeStoreSchema(Stream, []) :-
    write(Stream, '\'.\n').

privateAiKnowledgeStoreSchema(Stream, [Element|Schema]) :-
    write(Stream, ','),
    privateAiKnowledgeStoreElement(Stream, Element),
    privateAiKnowledgeStoreSchema(Stream, Schema).

privateAiKnowledgeStoreElement(Stream, [X,Y,Z]) :-
    write(Stream, X),
    write(Stream, ' '),
    write(Stream, Y),
    write(Stream, ' '),
    write(Stream, Z).
