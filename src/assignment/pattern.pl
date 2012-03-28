% File:         pattern.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Contains functions for matching sentences input by the
%               user with specific patterns.


% pattern_to_from/2
%
% Matches to-from, from-X-to-Y patterns.
pattern_to_from([to, X, from, Y |_], Y, X):-!.
pattern_to_from([from, X, to, Y |_], X, Y):-!.
pattern_to_from([at, X, how, do, i, get, to, Y |_], Y, X):-!.
pattern_to_from([from, X, how, do, i, get, to, Y |_], X, Y):-!.
pattern_to_from([_|T], X, Y):-
        pattern_to_from(T, X, Y).

% pattern_where_is/2
%
% Matches where-is, how-do-i-find patterns.
pattern_where_is([where, is, the, X |_], X):-!.
pattern_where_is([where, is, a, X |_], X):-!.
pattern_where_is([where, is, X |_], X):-!.
pattern_where_is([where, can, i, find, the, X |_], X):-!.
pattern_where_is([where, can, i, find, a, X |_], X):-!.
pattern_where_is([where, can, i, find, X |_], X):-!.
pattern_where_is([how, do, i, find, X |_], X):-!.
pattern_where_is([how, do, i, get, X |_], X):-!.
pattern_where_is([how, do, i, get, to, X |_], X):-!.
pattern_where_is([is, there, a, X |_], X):-!.
pattern_where_is([_|T], X):-
        pattern_where_is(T, X).

% pattern_name/2
%
% Matches questions about the chatbot's name.
pattern_name([what, is, your, name, X |_], X):-!.
pattern_name(['what\'s', your, name, X |_], X):-!.
pattern_name([whats, your, name, X |_], X):-!.
pattern_name([what, are, you, called, X |_], X):-!.
pattern_name([who, are, you, X |_], X):-!.
pattern_name([_|T], X):-
        pattern_name(T, X).

% pattern_my_subjects/2
%
% Matches questions about the chatbot's subjects.
pattern_my_subjects([what, are, you, studying, X |_], X):-!.
pattern_my_subjects([what, do, you, study, X |_], X):-!.
pattern_my_subjects([what, course, are, you, on, X |_], X):-!.
pattern_my_subjects([what, is, your, degree, X |_], X):-!.
pattern_my_subjects([_|T], X):-
        pattern_my_subjects(T, X).

% pattern_me/2
%
% Matches questions about how the chatbot is feeling.
pattern_me([how, are, you, X |_], X):-!.
pattern_me([are, you, ok, X |_], X):-!.
pattern_me([you, ok, X |_], X):-!.
pattern_me([you, okay, X |_], X):-!.
pattern_me([_|T], X):-
        pattern_me(T, X).