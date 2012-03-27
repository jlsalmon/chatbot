/******************************************************************

cango4(X, Y, Steps, Path, Direction).

******************************************************************/

:- [cube].

cango4(X, Y, 1, [X,Y], [Direction]):- next(X, Y, Direction).

cango4(X, Y, Steps, Path, DirectionList):-
	next(X, Z, Direction),
	cango4(Z, Y, SubSteps, SubPath, SubDirection),
	Steps is SubSteps + 1,
	Path = [X | SubPath],
	DirectionList = [Direction | SubDirection].


/******************************************************************

| ?- cango4(a,h,N,P,D).
D = [east,north,down],
N = 3,
P = [a,b,d,h] ? ;
D = [east,down,north],
N = 3,
P = [a,b,f,h] ? ;
D = [north,east,down],
N = 3,
P = [a,c,d,h] ? ;
D = [north,down,east],
N = 3,
P = [a,c,g,h] ? ;
D = [down,east,north],
N = 3,
P = [a,e,f,h] ? ;
D = [down,north,east],
N = 3,
P = [a,e,g,h] ? ;
no

******************************************************************/
