% File:         pattern.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Contains functions for matching sentences input by the
%               user with specific patterns.


% pattern_to_from(Sentence, Origin, Destination)
%
%
pattern_to_from([to, X, from, Y |_], Y, X):-!.
pattern_to_from([from, X, to, Y |_], X, Y):-!.
pattern_to_from([at, X, how, do, i, get, to, Y |_], Y, X):-!.
pattern_to_from([from, X, how, do, i, get, to, Y |_], X, Y):-!.
pattern_to_from([_|T], X, Y):-
        pattern_to_from(T, X, Y).

% pattern_where_is(Sentence, Destination)
%
%
pattern_where_is([where, is, the, X |_], X):-!.
pattern_where_is([where, is, a, X |_], X):-!.
pattern_where_is([where, is, X |_], X):-!.
pattern_where_is([where, can, i, find, the, X |_], X):-!.
pattern_where_is([where, can, i, find, a, X |_], X):-!.
pattern_where_is([where, can, i, find, X |_], X):-!.
pattern_where_is([_|T], X):-
        pattern_where_is(T, X).