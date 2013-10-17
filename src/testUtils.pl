%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS UTILS

test(TestPredicate) :-
    (call(TestPredicate) ->
        (write(TestPredicate), write(': OK\n')), true ;
        (write(TestPredicate), write(': Failed\n')), fail
    ), !.
