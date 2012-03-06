/******************************************************************

simp(E1, E2).

E1 is an input arithmetic expression composed by operator '+' or 
'*' and E2 is an output which is the same as E1 except that
redundant zeroes are removed.

******************************************************************/

simp(X,X):- atomic(X).

simp(X+Y, NewXY):-
	simp(X, NewX), simp(Y, NewY),
	rules_for_plus(NewX, NewY, NewXY).

simp(X*Y, NewXY):-
	simp(X, NewX), simp(Y, NewY),
	rules_for_multiply(NewX, NewY, NewXY).

rules_for_plus(X, 0, X).
rules_for_plus(0, X, X).
rules_for_plus(X, Y, X+Y):- X \== 0, Y \== 0.

rules_for_multiply(X, 0, 0).
rules_for_multiply(0, X, 0).
rules_for_multiply(X, 1, X).
rules_for_multiply(1, X, X).
rules_for_multiply(X, Y, X*Y):- X \== 0, Y \== 0, X \== 1, Y \== 1.


/******************************************************************

Output

| ?- simp(0+a+b+0+0+1, Ans).
Ans = a+b+1 ? ;
no
| ?- simp((0+a)+(0+0), Ans).
Ans = a ? ;
Ans = a ? ;
no
| ?- simp(0+a*b+0*0+1, Ans).
Ans = a*b+1 ? ;
Ans = a*b+1 ? ;
no
| ?- simp(x*0, Ans).
Ans = 0 ? ;
no
| ?- simp(x*1, Ans).
Ans = x ? ;
no

Testing simp.pl with required queries

| ?- simp(a+b+3*c+0+1*d+0+0, R).
R = a+b+3*c+d ? ;
no
| ?- simp(1*(a+0)+0+d*1+c*0, R).
R = a+d ? ;
no
| ?- simp((a+b)*(0+0*d), R).
R = 0 ? ;
R = 0 ? ;
no
| ?- simp(3+1*0+0+a*1*b*1, R).
R = 3+a*b ? ;
R = 3+a*b ? ;
no

******************************************************************/
