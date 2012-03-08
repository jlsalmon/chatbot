/******************************************************************

Inductive definition for cango2(X, Y, Steps)

	Base: 		if arrow(X, Y) then Steps = 1.
	Induction: 	if arrow(X, Z) and cango2(Z, Y, SubSteps) 
			then Steps = SubSteps + 1.

******************************************************************/

cango2(X, Y, 1):- arrow(X, Y).

cango2(X, Y, Steps):- 
	arrow(X, Z), 
	cango2(Z, Y, SubSteps), 
	Steps is SubSteps + 1.

/******************************************************************

Output

| ?- cango2(a,b,N).
N = 1 ? ;
no
| ?- cango2(a,h,N).
N = 3 ? ;
N = 3 ? ;
N = 3 ? ;
N = 3 ? ;
N = 3 ? ;
N = 3 ? ;
no

******************************************************************/
