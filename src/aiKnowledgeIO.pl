
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
