/******************************************************************

find_route	(Origin, Destination, Direction, WhichSide, Distance, Path).

next		(Origin, Destination, Direction, WhichSide, Distance).

Program which finds a route between any two places on the map.

For example, from exit 1 to exit 4, your program should be able to 
produce an instruction represented by the following two lists (or 
something silimar):

[east, south]

[15, 26]

From room '2q25' to exit 1, your program should be able to produce 
two lists:

[west, south, east]

[16,33,10]

******************************************************************/

:- [map].

test(X, Y):-
	find_route(X, Y, start, DirectionList, DistanceList, Path),
	cal_route(DirectionList, DistanceList, NewDirList, NewDistList),
	write(NewDirList), nl,
	write(NewDistList), nl,
	write(Path), nl,
	

find_route(X, Y, PreDir, [Direction], [Distance], [X, Y]):- 
	next(X, Y, Direction, WhichSide, Distance),
	not_u_turn(PreDir, Direction).

find_route(X, Y, PreDir, [Direction | SubDirection], [Distance | SubDistance], [X | SubPath]):-
	next(X, Z, Direction, WhichSide, Distance),
	not_u_turn(PreDir, Direction),
	find_route(Z, Y, Direction, SubDirection, SubDistance, SubPath).
	

u_turn(south, north). u_turn(north, south).
u_turn(east, west). u_turn(west, east).
not_u_turn(X, Y):- \+( u_turn(X, Y) ).

cal_route([L1], [L2], [L1], [L2]). 

cal_route([H1, HT1|T1], [H2, HT2|T2], [H1 | SubDirList], [H2 | SubDistList]):- 
	H1 \== HT1,
	cal_route([HT1|T1], [HT2|T2], SubDirList, SubDistList).

cal_route([H1, H1|T1], [H2, HT2|T2], SubDirList, SubDistList):- 
	NewDist is H2 + HT2,
	cal_route([H1|T1], [NewDist | T2], SubDirList, SubDistList).
