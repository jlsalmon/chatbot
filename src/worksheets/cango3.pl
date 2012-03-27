/******************************************************************

Inductive definition for cango3(X, Y, Steps, Path)

	Base: 		if arrow(X, Y) then Steps = 1 and Path = [X, Y].
	Induction: 	if arrow(X, Z) and cango3(Z, Y, SubSteps, Path) 
			then Steps = SubSteps + 1.
			and Path = X + SubPath.

******************************************************************/
:- [cube].

cango3(X, Y, 1, [X,Y]):- arrow(X, Y).

cango3(X, Y, Steps, Path):- 
	arrow(X, Z), 
	cango3(Z, Y, SubSteps, SubPath), 
	Steps is SubSteps + 1,
	Path = [X | SubPath].


/******************************************************************

Output

| ?- cango3(a,h,N,P).
N = 3,
P = [a,b,d,h] ? ;
N = 3,
P = [a,b,f,h] ? ;
N = 3,
P = [a,c,d,h] ? ;
N = 3,
P = [a,c,g,h] ? ;
N = 3,
P = [a,e,f,h] ? ;
N = 3,
P = [a,e,g,h] ? ;
no

******************************************************************/
