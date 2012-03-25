% File: lib.pl
% Author: Justin Lewis Salmon
% Student ID: 10000937
%
% Description: 

intersect([], _, []).  % an empty list intersect with any list = an empty list

intersect([H|T1], L2, [H|T3]):- 
        member(H, L2), !, % if the head of L1 is in L2,it  must be in L3, 
        intersect(T1, L2, T3). % carry on checking the rest of L1

intersect([_|T1], L2, L3):- % otherwise skip head,  carry on checking
        intersect(T1, L2, L3).

write_list([]):- nl.
write_list([H|T]):- write(H), write(' '), write_list(T).

subset([], _).
subset([H|T], L2):- 
        member(H, L2),
        subset(T, L2).

nth_item([H|_], 1, H).
nth_item([_|T], N, X):-
        nth_item(T, N1, X),
        N is N1 + 1.