% File:         route.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Functions for searching and calculating routes using the 
%               map structure defined in map.pl.
                

% find_route(Origin, Destination, Route)
%
% Finds a route between any two places on the map and builds a list of 
% user-friendly printable directions in R.
find_route(X, Y, R):-
	calc_route(X, Y, start, Dir, Dist, _),
	simp_route(Dir, Dist, NewDir, NewDist),
	print_route(X, Y, NewDir, NewDist, R).

% calc_route(Origin, Destination, Direction, DirectionList, DistanceList, Path)
%
% Calculates a route from Origin to Destination, building up lists of directions,
% distances and the path taken.
calc_route(X, Y, PreDir, [Dir], [Dist], [X, Y]):- 
	next(X, Y, Dir, _, Dist),
	\+u_turn(PreDir, Dir).
calc_route(X, Y, PreDir, [Dir | SubDir], [Dist | SubDist], [X | SubPath]):-
	next(X, Z, Dir, _, Dist),
	\+u_turn(PreDir, Dir),
	calc_route(Z, Y, Dir, SubDir, SubDist, SubPath).
	
% u_turn(Direction, Direction)
%
% Defines the set of 180 degree turns.
u_turn(south, north). u_turn(north, south).
u_turn(east, west). u_turn(west, east).

% simp_route(DirectionList, DistanceList, NewDirList, NewDistList)
%
% Simplifies a list of directions and distances to its most compact form.
simp_route([L1], [L2], [L1], [L2]). 
simp_route([H1, HT1|T1], [H2, HT2|T2], [H1 | SubDir], [H2 | SubDist]):- 
	H1 \== HT1,
	simp_route([HT1|T1], [HT2|T2], SubDir, SubDist).
simp_route([H1, H1|T1], [H2, HT2|T2], SubDir, SubDist):- 
	NewDist is H2 + HT2,
	simp_route([H1|T1], [NewDist | T2], SubDir, SubDist).

% print_route(Origin, Destination, DirectionList, DistanceList, String)
%
% Builds a human-readable list of strings that represent directions from Origin
% to Destination using Directions and Distances.
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






