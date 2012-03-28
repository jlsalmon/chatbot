/*________________________________________________________________________
|	Copyright (C)  David Warren and  Fernando Pereira 		  |
|	This program may be used, copied, altered or included in other	  |
|	programs only for academic purposes and provided that the	  |
|	authorship of the initial program is aknowledged.		  |
|	Use for commercial purposes without the previous written 	  |
|	agreement of the authors is forbidden.				  |
|_______________________________________________________________________ */
/* version 2: added a fileter to remove '\n' from the input list 3/3/2012
 */
/* comments added by rong  (Feb 2012)
 */

/* read_in(P) read a sentence from screen, then put all words in list P 
 * the sentence has to be ended with either '.', '!', or '?'
 */
read_in(P):-initread(L),words(P,L,[]).

/* initread(L) - read every char from std input stream
 * get adn get0 are nolonger working, so use get_code instead
 */
%initread([K1,K2|U]):-get(K1),get0(K2),readrest(K2,U). % orig code
% 'get' is nolonger supported from Sicstus Prolog, so use get_code instead: 
initread([K1,K2|U]):-get_code(K1),get_code(K2),readrest(K2,U).

%readrest(46,[]):-!.  % 46 ascii for '.' - don't actually want this.
readrest(63,[]):-!.  % 63 ascii for '?'
readrest(33,[]):-!.  % 33 ascii for '!'
readrest(10,[]):-!.  % 10 ascii for '\n' wrote by Justin :)
%readrest(K,[K1|U]):-K=<32,!,get(K1),readrest(K1,U). % orig code
%readrest(_K1,[K2|U]):-get0(K2),readrest(K2,U). % orig code
readrest(K,[K1|U]):-K=<32,!,get_code(K1),readrest(K1,U).
readrest(_K1,[K2|U]):-get_code(K2),readrest(K2,U).

/* This is a lexical parser which converts a sequence of chars to a sequence 
 * tokens
 * words (P, L, []) where L is a list of chars, and P is the readult from
 * the parser, i.e. a list of tokens
 */
words([V|U]) --> word(V),!,blanks,words(U).
words([]) --> [].

word(U1) --> [K],{lc(K,K1)},!,alphanums(U2),{name(U1,[K1|U2])}.
word(nb(N)) --> [K],{digit(K)},!,digits(U),{name(N,[K|U])}.
word(V) --> [K],{name(V,[K])}.

alphanums([K1|U]) --> [K],{alphanum(K,K1)},!,alphanums(U).
alphanums([]) --> [].

alphanum(95,95) :- !.
alphanum(K,K1):-lc(K,K1).
alphanum(K,K):-digit(K).

digits([K|U]) --> [K],{digit(K)},!,digits(U).
digits([]) --> [].

blanks--> [K],{K=<32},!,blanks.
blanks --> [].

digit(K):-K>47,K<58.

lc(K,K1):-K>64,K<91,!,K1 is K+32. 
% The above line changes Upcase to lower case, the old code was 
% K1 is K\/8'40 which dosen't work 
% I changed it to K1 is K+32	- rong 27-1-2012 

lc(K,K):-K>96,K<123.

/*********** the end of David's code *******************/

/* A filter for chatbot  - rong 
 * The room number of Q-block is represented as 2qXXX
 *  We need to filter these
 */

my_filter([],[]).
my_filter(['\n'|T], R):-  !, % remove new line
	my_filter(T, R).
my_filter([nb(2), X|T], [Rm|R]):- 
	name(X, CharList),
	q_followed_by_nb(CharList),!,% check if CharList is a letter q+numbers
	name(Rm, [50|CharList]),
	my_filter(T, R).
my_filter([X|T], [X|R]):- % otherwise
	my_filter(T, R).

q_followed_by_nb([113,X|_]):- % check if CharList is a letter q+numbers
	% 113 is ascii code for letter 'q'
	digit(X).

readin(S):- read_in(L), my_filter(L,S).
