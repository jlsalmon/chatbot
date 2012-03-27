
arrow(a,b).
arrow(a,c).
arrow(a,e).
arrow(b,d).
arrow(b,f).
arrow(c,d).
arrow(c,g).
arrow(d,h).
arrow(e,f).
arrow(e,g).
arrow(f,h).
arrow(g,h).

next(a,b, east).
next(a,c, north).
next(a,e, down).
next(b,d, north).
next(b,f, down).
next(c,d, east).
next(c,g, down).
next(d,h, down).
next(e,f, east).
next(e,g, north).
next(f,h, north).
next(g,h, east).

/******************************************************************

Output

| ?- cango(a, Where).
Where = b ? ;
Where = c ? ;
Where = e ? ;
Where = d ? ;
Where = f ? ;
Where = h ? ;
Where = h ? ;
Where = d ? ;
Where = g ? ;
Where = h ? ;
Where = h ? ;
Where = f ? ;
Where = g ? ;
Where = h ? ;
Where = h ? ;
no

Number of solutions = 15

Solutions appear more than once because there is more than one 
route to a node.
Num occurrences == num routes.

******************************************************************/



























