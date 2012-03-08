/******************************************************************

subset(L1, L2) holds if L1 is a subset of L2.


if 	L1 == [],
	then L1 is a subset of L2

else if head(L1) is a member of L2
	and tail(L2) is a subset of L2,
	then L1 is a subset of L2

******************************************************************/

subset(L1, L2):- L1 = [].

subset([H|T], L2):- 
	member(H, L2),
	subset(T, L2).


/******************************************************************
	
Output

| ?- subset([a,b], [e,d,b,x,a]).
yes
| ?- subset([a], [a]).
yes
| ?- subset([x,y], [x,w,b,a]).
no
| ?- 

******************************************************************/
