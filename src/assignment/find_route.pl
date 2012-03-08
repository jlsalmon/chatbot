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

give_route(X, Y):-
	find_route(X, Y, start, DirectionList, DistanceList, _),
	simp_route(DirectionList, DistanceList, NewDirList, NewDistList),
	print_route(X, Y, NewDirList, NewDistList).
	

find_route(X, Y, PreDir, [Direction], [Distance], [X, Y]):- 
	next(X, Y, Direction, _, Distance),
	not_u_turn(PreDir, Direction).

find_route(X, Y, PreDir, [Direction | SubDirection], [Distance | SubDistance], [X | SubPath]):-
	next(X, Z, Direction, _, Distance),
	not_u_turn(PreDir, Direction),
	find_route(Z, Y, Direction, SubDirection, SubDistance, SubPath).
	

u_turn(south, north). u_turn(north, south).
u_turn(east, west). u_turn(west, east).
not_u_turn(X, Y):- \+( u_turn(X, Y) ).

simp_route([L1], [L2], [L1], [L2]). 

simp_route([H1, HT1|T1], [H2, HT2|T2], [H1 | SubDirList], [H2 | SubDistList]):- 
	H1 \== HT1,
	simp_route([HT1|T1], [HT2|T2], SubDirList, SubDistList).

simp_route([H1, H1|T1], [H2, HT2|T2], SubDirList, SubDistList):- 
	NewDist is H2 + HT2,
	simp_route([H1|T1], [NewDist | T2], SubDirList, SubDistList).

/**

Program which prints out a direction on screen, such as, "please walk to west 16 meters, turn left (or say turn to south) walk 33 meters, turn right, walk 10 meters, the exit 1 will be on your right". Note that the information about which side exit1 is can be obtained by calling

next(_, exit1, east, WhichSide,_)

*/

print_route(Destination, [Direction], [Distance]):- !,
	next(_, Destination, Direction, WhichSide, _),
	write(" walk "), write(Direction), write(" "),
	write(Distance), write(" metres."),
	write(" Your destination, "), write(Destination),
	write(", will be on your "), write(WhichSide), write('.'), nl.

print_route(Destination, [H1 | DirectionList], [H2 | DistanceList]):-	
	write(" walk "), write(H1), 
	write(" "), write(H2), write(" metres, then"),
	print_route(Destination, DirectionList, DistanceList).

print_route(Origin, Destination, DirectionList, DistanceList):-
	write("From "), write(Origin),
	print_route(Destination, DirectionList, DistanceList).






