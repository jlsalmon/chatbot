/******************************************************************

cal_route(DirList, DistList, X, Y).

Simplifies a route instruction described in DirList and DistList
and returns it in X any Y respectively.

For example,

?- cal_route([a,a,b,c,c],[1,2,3,4,5], X, Y). 
returns
D1 = [a,b,c]

D2 = [3,3,9]


******************************************************************/


% single element in list, no simplification needed
cal_route([L1], [L2], [L1], [L2]). 

% if first and second elements are not the same, push the head onto
% the sub list, then recurse without the head.
cal_route([H1, HT1|T1], [H2, HT2|T2], [H1 | SubDirList], [H2 | SubDistList]):- 
	H1 \== HT1,
	cal_route([HT1|T1], [HT2|T2], SubDirList, SubDistList).

% if first and second element are the same, add the distances, push
% the new distance onto the recursive input (replacing the first two
% elements) and throw away the head direction and recurse with the
% tail. Do nothing with the sub lists.
cal_route([H1, H1|T1], [H2, HT2|T2], SubDirList, SubDistList):- 
	NewDist is H2 + HT2,
	cal_route([H1|T1], [NewDist | T2], SubDirList, SubDistList).


/******************************************************************

Output

| ?- cal_route([a,a,b,c,c],[1,2,3,4,5], X, Y). 

X = [a,b,c],
Y = [3,3,9] ? yes

| ?- cal_route([a,b,c], [3,4,5], X, Y).

X = [a,b,c],
Y = [3,4,5] ? ;
no

******************************************************************/
