% File: route.pl
% Author: Justin Lewis Salmon
% Student ID: 10000937
%
% Description: Finds a route between any two places on the map.

% find_route()
find_route(X, Y, R):-
	calc_route(X, Y, start, DirList, DistList, _),
	simp_route(DirList, DistList, NewDirList, NewDistList),
	print_route(X, Y, NewDirList, NewDistList, R).

% calc_route(Origin, Destination, Direction, WhichSide, Distance, Path).
calc_route(X, Y, PreDir, [Dir], [Dist], [X, Y]):- 
	next(X, Y, Dir, _, Dist),
	not_u_turn(PreDir, Dir).
calc_route(X, Y, PreDir, [Dir | SubDir], [Dist | SubDist], [X | SubPath]):-
	next(X, Z, Dir, _, Dist),
	not_u_turn(PreDir, Dir),
	calc_route(Z, Y, Dir, SubDir, SubDist, SubPath).
	
% u_turn()
u_turn(south, north). u_turn(north, south).
u_turn(east, west). u_turn(west, east).
not_u_turn(X, Y):- \+( u_turn(X, Y) ).

% simp_route()
simp_route([L1], [L2], [L1], [L2]). 
simp_route([H1, HT1|T1], [H2, HT2|T2], [H1 | SubDirList], [H2 | SubDistList]):- 
	H1 \== HT1,
	simp_route([HT1|T1], [HT2|T2], SubDirList, SubDistList).
simp_route([H1, H1|T1], [H2, HT2|T2], SubDirList, SubDistList):- 
	NewDist is H2 + HT2,
	simp_route([H1|T1], [NewDist | T2], SubDirList, SubDistList).

/**

Program which prints out a direction on screen, such as, "please walk to west 16 meters, 
turn left (or say turn to south) walk 33 meters, turn right, walk 10 meters, the exit 1 
will be on your right". Note that the information about which side exit1 is can be 
obtained by calling

next(_, exit1, east, WhichSide,_)

*/

% print_route()
print_route(Dest, [Dir], [Dist], String):- !,
	next(_, Dest, Dir, WhichSide, _),
        String = ['walk', Dir, Dist, 'metres.', 'Your destination,'
                 , Dest, ', will be on your', WhichSide, '.'].
print_route(Dest, [Dir | DirList], [Dist | DistList], Str):-	
        Str = ['walk', Dir, Dist, 'metres, then' | SubStr],
	print_route(Dest, DirList, DistList, SubStr).
print_route(Orig, Dest, DirList, DistList, Str):-
        Str = ['From', Orig | SubStr],
	print_route(Dest, DirList, DistList, SubStr).






