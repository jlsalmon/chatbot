% File:         english.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  

:-[map]. % needed for defining place names

/* version 2 - add parse tree */

sentence(s(X, Y, Z)) --> 
	subject_phrase(X), verb(Y), object_phrase(Z).

sentence(s(X, Y, Z)) --> question(X), determiner(Y), place_name(Z).

sentence(s(X, Y)) --> determiner(X), place_name(Y).

sentence(s(X, Y)) --> subject_tobe_verb(X), prepositional_phrase(Y).

subject_phrase(sp(X)) --> subject_pronoun(X).
subject_phrase(sp(X)) --> noun_phrase(X).

object_phrase(op(X,Y)) --> noun_phrase(X), adverb(Y).
object_phrase(op(X, Y)) --> object_pronoun(X), adverb(Y).

noun_phrase(np(X, Y)) --> determiner(X), noun(Y).
noun_phrase(np(Y)) --> noun(Y).

prepositional_phrase(pp(X, Y)) --> preposition(X), place_name(Y).

preposition(prep(in)) --> [in].
preposition(prep(at)) --> [at].
preposition(prep(from)) --> [from].

place_name(pname(reception)) --> [reception].
place_name(pname(cafe)) --> [cafe].
place_name(pname(toilet)) --> [toilet].
place_name(pname(vending_machines)) --> [vending_machines].
place_name(pname(lockers)) --> [lockers].
place_name(pname(exit)) --> [exit].
place_name(pname(london)) --> [london].
place_name(pname(bristol)) --> [bristol].
place_name(pname(exeter)) --> [exeter].
place_name(pname(X)) --> [X], { next(X,_,_,_,_) }.

subject_pronoun(spn(i)) --> [i].
subject_pronoun(spn(we)) --> [we].
subject_pronoun(spn(you)) --> [you].
subject_pronoun(spn(they)) --> [they].
subject_pronoun(spn(he)) --> [he].
subject_pronoun(spn(she)) --> [she].
subject_pronoun(spn(it)) --> [it].
subject_pronoun(spn(who)) --> [who].

object_pronoun(opn(you))--> [you].
object_pronoun(opn(your))--> [your].
object_pronoun(opn(me))--> [me].
object_pronoun(opn(us))--> [us].
object_pronoun(opn(them))--> [them].
object_pronoun(opn(him))--> [him].
object_pronoun(opn(her))--> [her].
object_pronoun(opn(it))--> [it].

determiner(dtmnr([])) --> [].
determiner(dtmnr([a])) --> [a].
determiner(dtmnr([the])) --> [the].
determiner(dtmnr([my])) --> [my].
determiner(dtmnr([some])) --> [some].
determiner(dtmnr([all])) --> [all].
determiner(dtmnr([that])) --> [that].

noun(noun(uwe)) --> [uwe].
noun(noun(cs_course)) --> [cs_course].
noun(noun(robotics_course)) --> [robotics_course].
noun(noun(robotics_course)) --> [computing_course].
noun(noun(robotics_course)) --> [sd_course].
noun(noun(name)) --> ['ChatBot'].

adverb(ad([very, much])) --> [very, much].
adverb(ad([])) --> [].

verb(vb(like)) --> [like].
verb(vb(love)) --> [love].
verb(vb(is)) --> [is].

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

/*  version 3 add some questions */

question(q(why,do,S)) --> [why, do], sentence(S).
question(q(do,S)) --> [do], sentence(S).
question(q(where,is,S)) --> [where, is], sentence(S).
question(q(what,is,S)) --> [what, is], sentence(S).

/* after added the above line, we can handle questions like:

% 6
| ?- question(Tree, [why,do , you, love,me],[]).
Tree = q(why,do,s(sp(spn(you)),vb(love),op(opn(me),ad([])))) ? 

**************/

/* version 4 add rules for changing a sentence to a question, vice versa */

mapping(s2why, % type of mapping is from a sentence to why question
	       % e.g [i,love,you] => [why,do,you,love,me] 
	s(
            sp(spn(N1)),
            vb(V),
            op(
                 opn(N2), 
                 ad(X)
              )
         ),
	q(
            why,do,
            s(
                sp(spn(P1)),
                vb(V),
                op(
                     opn(P2),
                     ad(X)
                  )
             )
         ) 
	) :- 
	mapping_spn(N1, P1), mapping_opn(N2, P2). 
mapping(s2why, % 
	       % e.g [i,love,uwe] => [why,do,you,love,uwe] 
	s(
            sp(spn(N1)),
            vb(V),
            op(
                 np(noun(N2)),
                 ad(X)
              )
         ),
	q(
            why,do,
            s(
                sp(spn(P1)),
                vb(V),
                op(
                     np(noun(N2)),
                     ad(X)
                  )
             )
         ) 
	) :- 
	mapping_spn(N1, P1).

mapping(s2q, % type of mapping is from a sentence to question
	       % e.g [i,love,uwe] => [do,you,love,me] 
	s(
            sp(spn(N1)),
            vb(V),
            op(
                 opn(N2),
                 ad(X)
              )
         ),
	q(
            do,
            s(
                sp(spn(P1)),
                vb(V),
                op(
                     opn(P2),
                     ad(X)
                  )
             )
         ) 
	) :- 
	mapping_spn(N1, P1), mapping_opn(N2, P2). 
mapping(s2q, % 
	       % e.g [i,love,uwe] => [do,you,love,uwe] 
	s(
            sp(spn(N1)),
            vb(V),
            op(
                 np(noun(N2)),
                 ad(X)
              )
         ),
	q(
            do,
            s(
                sp(spn(P1)),
                vb(V),
                op(
                     np(noun(N2)),
                     ad(X)
                  )
             )
         ) 
	) :- 
	mapping_spn(N1, P1).

mapping(s2name,
        s(
            sp(spn(What)),
            vb(Is),
            op(
                 np(noun(N2)),
                 ad(X)
              )
         ),
        q(
            sp(spn(P1)),
            name, is,
            np(noun(name))
         )
        ):-
        mapping_spn(N1, P1).

mapping_spn(i,you).
mapping_spn(you,i).
mapping_spn(my,your).
mapping_spn(your,my).

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
        readin(S),
        gen_reply(S,Ans),
        write_list(Ans), nl,
        S = [bye|_].

test:- write(bye),nl.
