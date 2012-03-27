% File:         lib.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  General functions for use with any program. Contains useful
%               things such as subset/intersection finding etc.


% intersect(Set1, Set2, SubSet)
%
% Checks to see if SubSet is an intersection of Set1 and Set2.
intersect([], _, []).
intersect([H|T1], L2, [H|T3]):- 
        member(H, L2), !,
        intersect(T1, L2, T3).
intersect([_|T1], L2, L3):-
        intersect(T1, L2, L3).

% write_list(List)
%
% Prints a list without brackets and without separating commas.
write_list([]):- nl.
write_list([H|T]):- write(H), write(' '), write_list(T).

% subset(SubSet, Set)
%
% True if SubSet is indeed a subset of Set.
subset([], _).
subset([H|T], L2):- 
        member(H, L2),
        subset(T, L2).

% nth_item(List, N, Item)
%
% Holds true if the N-th item in the List is Item.
nth_item([H|_], 1, H).
nth_item([_|T], N, X):-
        nth_item(T, N1, X),
        N is N1 + 1.

% contains(String, SubString)
%
% True if the substring exists in String.
contains(A, B) :-
  atom(A),
  atom(B),
  name(A, AA),
  name(B, BB),
  contains(AA, BB).
contains(A, B) :-
  atom(A),
  name(A, AA),
  contains(AA, B).
contains(A, B) :-
  sublist(B, A),
  B \= [].

% sublist()
sublist(S, L) :-
  append(_, L2, L),
  append(S, _, L2).

