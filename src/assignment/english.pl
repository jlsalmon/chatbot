% File:         english.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Contains English grammars and mappings for converting
%               sentences to appropriate responses.

:-[map].

sentence( s(X,Y, is, Z) ) --> belonging_phrase(X), abstract_noun(Y),  
                              [is],  special_noun(Z).

sentence(s(X, Y, Z)) --> subject_pronoun(X), indicative_verb(Y), 
                         adjective(Z).

sentence(s(X, Y, Z)) --> subject_phrase(X), verb(Y), object_phrase(Z).

sentence(s(X, Y, Z)) --> question(X), determiner(Y), place_name(Z).

sentence(s(X, Y)) --> determiner(X), place_name(Y).

sentence(s(X, Y)) --> subject_tobe_verb(X), prepositional_phrase(Y).

sentence(s(X, Y, Z)) --> question(X), object_pronoun(Y), noun(Z).

belonging_phrase(belong(your)) --> [your].
belonging_phrase(belong(my)) --> [my].

abstract_noun(abs_noun(name)) --> [name].

special_noun(sp_noun(justin)) --> [justin].
special_noun(sp_noun(frank)) --> [frank].


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
noun(noun(name)) --> [name].

adverb(ad([very, much])) --> [very, much].
adverb(ad([how])) --> [how].
adverb(ad([])) --> [].

verb(vb(like)) --> [like].
verb(vb(love)) --> [love].
verb(vb(is)) --> [is].

indicative_verb(ivb(are)) --> [are].
indicative_verb(ivb(am)) --> [am].

subject_tobe_verb(s_2b([you, are])) --> [you, are].
subject_tobe_verb(s_2b([i,am])) --> [i, am].
subject_tobe_verb(s_2b([we, are])) --> [we, are].

adjective(adj(great)) --> [great].
adjective(adj(good)) --> [good].
adjective(adj(fine)) --> [fine].

question(q(why,do,S)) --> [why, do], sentence(S).
question(q(do,S)) --> [do], sentence(S).
% for "how are you"
question(q(X, Y, Z)) --> adverb(X), indicative_verb(Y), subject_pronoun(Z).
% for "what is"
question( q( what, is, X, Y ) ) -->  [what, is],  belonging_phrase(X),  
                                     abstract_noun(Y).   

/* version 4 add rules for changing a sentence to a question, vice versa */

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

mapping(s2name,% what is your name -> my name is X
        s( belong(Y1), abs_noun(X2), is, sp_noun(Y2) ),
        q( what, is, belong(X1), abs_noun(X2) )
        ):-
        mapping_belong(X1, Y1), mapping_noun(X2, Y2).

mapping(s2how, % how are you -> i am fine
        s(spn(X1), ivb(Y1), adj(_)),
        q(ad(_), ivb(Y2), spn(Z2))
        ):-
        mapping_spn(X1, Z2), mapping_indicative(Y1, Y2).

mapping_belong(my,your).
mapping_belong(your,my).

mapping_noun(name, frank).
mapping_noun(frank, name).

mapping_indicative(are, am).
mapping_indicative(am, are).

mapping_ad(how, fine).
mapping_ad(fine, how).

mapping_spn(i, you).
mapping_spn(you, i).

mapping_opn(you,me).
mapping_opn(me,you).

% Experimental stuff
%
%question( q( what , is, X, Y)) -->  [what, is],  belonging_phrase(X),  
%                                    abstract_noun((Y,_)).
%
%sentence(s(X,Y, is, Z)) --> belonging_phrase(X), abstract_noun((Y,Tag)),  
%                            [is],  special_noun((Tag,Z)).
%
%abstract_noun((name, personname)) --> [name].
%abstract_noun((hobby, activities)) --> [hobby].
%abstract_noun((major, subjects)) --> [major].
%
%special_noun((personname,justin)) --> [justin].
%special_noun((personname,chatbot)) --> [chatbot].
%
%special_noun((subjects, computer_science)) --> [computer_science].
%special_noun((subjects, physics)) --> [physics].
%
%special_noun((activities, chatting)) --> [chatting].
%special_noun((activities, swimming)) --> [swimming].
%
%mapping(s2relate,% experimental
%        s( belong(Y1), abs_noun(X2), is, sp_noun(Y2) ),
%        q( what, is, belong(X1), abs_noun(X2) )
%        ):-
%        mapping_belong(X1, Y1), mapping_noun(X2, Y2).
