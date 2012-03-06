% A small example used in lectrue 8

:-[map]. % needed for defining place names

/* version 1 - define a small set of language without parse tree */

sentence --> subject_phrase, verb, object_phrase.
sentence2 --> subject_tobe_verb, prepositional_phrase.

subject_phrase --> subject_pronoun.
%% subject_phrase --> noun_phrase.

object_phrase --> noun_phrase, adverb.
object_phrase --> object_pronoun, adverb.

%% noun_phrase --> determiner, noun.
noun_phrase --> noun.

prepositional_phrase --> preposition, place_name.

preposition --> [in].
preposition --> [at].
preposition --> [from].

place_name --> [reception].
place_name --> [london].
place_name --> [bristol].
place_name --> [X], { next(X,_,_,_,_) }.

subject_pronoun --> [i].
subject_pronoun --> [we].
subject_pronoun --> [you].

object_pronoun --> [you].
object_pronoun --> [me].
object_pronoun --> [us].

%% determiner --> [].
%% determiner --> [a].
%% determiner --> [the].

noun --> [uwe].
noun --> [cs_course].
noun --> [robotics_course].

adverb --> [very, much].
adverb --> [].

verb --> [like].
verb --> [love].

subject_tobe_verb --> [you, are].
subject_tobe_verb --> [i, am].
subject_tobe_verb --> [we, are].

/* some test examples:

| ?- sentence([we, love, uwe],[]).
yes

| ?- sentence([love,you],[]).
no

| ?- sentence([we, like, you, because, you, helped, us, a, lot], R).
R = [because,you,helped,us,a,lot] ? ;
no

| ?- sentence(L,[]).
L = [i,like,uwe,very,much] ? ;
L = [i,like,uwe] ? ;
L = [i,like,cs_course,very,much] ? ;
L = [i,like,cs_course] ? ;
L = [i,like,robotics_course,very,much] ? ;
L = [i,like,robotics_course] ? ;
L = [i,like,you,very,much] ? ;
L = [i,like,you] ? ;
L = [i,like,me,very,much] ? ;
L = [i,like,me] ? ;
L = [i,like,us,very,much] ? 
yes

| ?- findall(L, sentence(L,[]), All).
All = [[i,like,uwe,very,much],[i,like,uwe],[i,like,cs_course,very,much],[i,like,cs_course],[i,like,robotics_course,very,much],[i,like,robotics_course],[i,like,you,very|...],[i,like,you],[i,like|...],[...|...]|...] ? 

***************************************************/

/* version 2 - add parse tree */

sentence(s(X, Y, Z)) --> 
	subject_phrase(X), verb(Y), object_phrase(Z).

sentence2(s(X, Y)) --> subject_tobe_verb(X), prepositional_phrase(Y).

subject_phrase(sp(X)) --> subject_pronoun(X).
%% subject_phrase --> noun_phrase.

object_phrase(op(X,Y)) --> noun_phrase(X), adverb(Y).
object_phrase(op(X, Y)) --> object_pronoun(X), adverb(Y).

% noun_phrase(np(X, Y)) --> determiner(X), noun(Y).
noun_phrase(np(Y)) --> noun(Y).

prepositional_phrase(pp(X, Y)) --> preposition(X), place_name(Y).

preposition(prep(in)) --> [in].
preposition(prep(at)) --> [at].
preposition(prep(from)) --> [from].

place_name(pname(reception)) --> [reception].
place_name(pname(london)) --> [london].
place_name(pname(bristol)) --> [bristol].
place_name(pname(X)) --> [X], { next(X,_,_,_,_) }.

subject_pronoun(spn(i)) --> [i].
subject_pronoun(spn(we)) --> [we].
subject_pronoun(spn(you)) --> [you].

object_pronoun(opn(you))--> [you].
object_pronoun(opn(me))--> [me].
object_pronoun(opn(us))--> [us].

%% determiner --> [].
%% determiner --> [a].
%% determiner --> [the].

noun(noun(uwe)) --> [uwe].
noun(noun(cs_course)) --> [cs_course].
noun(noun(robotics_course)) --> [robotics_course].

adverb(ad([very, much])) --> [very, much].
adverb(ad([])) --> [].

verb(vb(like)) --> [like].
verb(vb(love)) --> [love].

subject_tobe_verb(s_2b([you, are])) --> [you, are].
subject_tobe_verb(s_2b([i,am])) --> [i, am].
subject_tobe_verb(s_2b([we, are])) --> [we, are].

/*** some tests

1. from list to tree

| ?- sentence(Tree, [i,love,you],[]).
Tree = s(sp(spn(i)),vb(love),op(opn(you),ad([]))) ? ;
no
| ?- sentence(Tree, [i,love,you,very,much],[]).
Tree = s(sp(spn(i)),vb(love),op(opn(you),ad([very,much]))) ? 
yes
% 6
| ?- sentence(T,[i,am,in,bristol],[]).
T = s(s_2b([i,am]),pp(prep(in),pname(bristol))) ? 

2, from tree to list

| ?- sentence(s(sp(spn(i)),vb(love),op(opn(you),ad([very,much]))), L,K).
L = [i,love,you,very,much|K] ? 
yes
% 6
| ?- sentence(s(s_2b([i,am]),pp(prep(in),pname(bristol))), L,[]).
L = [i,am,in,bristol] ? 


****/

/* version 3 add some questions
 */

question(q(why,do,S)) --> [why, do], sentence(S).
question(q(do,S)) --> [do], sentence(S).

/* after added the above line, we can handle questions like:

% 6
| ?- question(Tree, [why,do , you, love,me],[]).
Tree = q(why,do,s(sp(spn(you)),vb(love),op(opn(me),ad([])))) ? 

**************/

/* version 4 add rules for changing a sentence to a question, vice versa
 */

mapping(s2why, % type of mapping is from a sentence to why question
	       % e.g [i,love,you] => [why,do,you,love,me] 
	s(sp(spn(N1)),vb(V),op(opn(N2),ad(X))),
	q(why,do,s(sp(spn(P1)),vb(V),op(opn(P2),ad(X)))) 
	) :- 
	mapping_spn(N1, P1), mapping_opn(N2, P2). 
mapping(s2why, % 
	       % e.g [i,love,uwe] => [why,do,you,love,uwe] 
	s(sp(spn(N1)),vb(V),op(np(noun(N2)),ad(X))),
	q(why,do,s(sp(spn(P1)),vb(V),op(np(noun(N2)),ad(X)))) 
	) :- 
	mapping_spn(N1, P1).

mapping(s2q, % type of mapping is from a sentence to question
	       % e.g [i,love,uwe] => [do,you,love,me] 
	s(sp(spn(N1)),vb(V),op(opn(N2),ad(X))),
	q(do,s(sp(spn(P1)),vb(V),op(opn(P2),ad(X)))) 
	) :- 
	mapping_spn(N1, P1), mapping_opn(N2, P2). 
mapping(s2q, % 
	       % e.g [i,love,uwe] => [do,you,love,uwe] 
	s(sp(spn(N1)),vb(V),op(np(noun(N2)),ad(X))),
	q(do,s(sp(spn(P1)),vb(V),op(np(noun(N2)),ad(X)))) 
	) :- 
	mapping_spn(N1, P1).

mapping_spn(i,you).
mapping_spn(you,i).
mapping_opn(you,me).
mapping_opn(me,you).

/* 

| ?- question(Tree, [why,do,you,love,me],[]), mapping(s2why, T, Tree), sentence(T, L, []).
L = [i,love,you],
T = s(sp(spn(i)),vb(love),op(opn(you),ad([]))),
Tree = q(why,do,s(sp(spn(you)),vb(love),op(opn(me),ad([])))) ? 

| ?- sentence(T1, [i,like,uwe],[]), mapping(s2why,T1,T2), question(T2, L,[]).
L = [why,do,you,like,uwe],
T1 = s(sp(spn(i)),vb(like),op(np(noun(uwe)),ad([]))),
T2 = q(why,do,s(sp(spn(you)),vb(like),op(np(noun(uwe)),ad([])))) ? 
yes
% 7
| ?- sentence(T1, [i,like,uwe],[]), mapping(s2q,T1,T2), question(T2, L,[]).
L = [do,you,like,uwe],
T1 = s(sp(spn(i)),vb(like),op(np(noun(uwe)),ad([]))),
T2 = q(do,s(sp(spn(you)),vb(like),op(np(noun(uwe)),ad([])))) ? ;


******************************/

:-[readin].

test:-  repeat,
        readin(S),              % defined in file readin.pl
        gen_reply(S,Ans),
        write_list(Ans), nl,
        S = [bye|_].

test:- write(bye),nl.

gen_reply(S,Reply):- 
	sentence(Tree1, S, _Rest),!, 
	mapping(s2why,Tree1, Tree2),
	question(Tree2, Rep,[]),
	append(Rep, ['?'], Reply).
gen_reply(S,Reply):- 
	question(Tree2, S, _Rest),!, 
	mapping(s2q,Tree1, Tree2),
	sentence(Tree1, Rep,[]),
	append([yes, ','|Rep], ['!'], Reply).

gen_reply([bye|_],[bye ,for, now, '.']). 
gen_reply(_,[what,'?']). % defaul case


write_list([]):- nl.
write_list([H|T]):- write(H), write(' '), write_list(T).

/*** test run
| ?- test.
|: hi!
|: what ? 

Hi!
|: what ? 

i love you!
|: why do you love me ? 

don't know.
|: what ? 

do you love me?
|: yes , i love you ! 

bye.
bye for now . 

yes
| ?- 
*******************/
