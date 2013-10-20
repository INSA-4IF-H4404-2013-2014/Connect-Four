
% ==============================================================================
% utilReadFile(FilePath, Lines)
% -----------------------------
% <FilePath> : file path
% <Lines> : returned lines
% ==============================================================================

utilReadFile(FilePath, Lines) :-
    open(FilePath, read, Stream),
    privateUtilReadFile(Stream, Lines),
    close(Stream).

privateUtilReadFile(Stream,[]) :-
    at_end_of_stream(Stream).

privateUtilReadFile(Stream,[Line|Lines]) :-
    not(at_end_of_stream(Stream)),
    read(Stream, Line),
    privateUtilReadFile(Stream, Lines).
