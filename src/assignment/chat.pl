% File:         chat.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  
%

:- [map, database, route, pattern, readin, english, lib, names].
:- use_module(library(random)).
:- dynamic usr_name/1, information/2, feedback/2, alevel/1.

% chat/0
%
% top level call
chat:-
	print_welcome, nl,
	conversations.

% conversations/0
%
% Main chatbot backtracking loop. Repeats until user enters "bye".
conversations:-
	repeat, % repeat through backtracking 
	print_prompt(you),
	readin(S),
	gen_reply(S,R),
	print_prompt(me),
	write_list(R),
	is_quit(S), 
        print_report, !.

% gen_reply/2
%
% 
gen_reply(S, R):- % check for "bye"
        is_quit(S), !,
	responses_db(bye, Res), 
	random_pick(Res, R).
gen_reply(S, R):- % check for greeting
        is_greeting(S), !,
	responses_db(greeting, Res), 
	random_pick(Res, R).
gen_reply(S, R):- % check for thanks
        is_thanks(S), !,
        responses_db(thanked, Res), 
        random_pick(Res, R).
gen_reply(S, R):- % give a route
	pattern_to_from(S, X, Y), !,
	find_route(X, Y, R).
gen_reply(S, R):- % give directions
        pattern_where_is(S, X), !,
        (info(D, X); next(X,_,_,_,_)),
        print_prompt(me),
        write('Where are you at the moment?'), nl,
        get_location(2),
        loc(Y),
        find_route(Y, D, R), !,
        retract(loc(Y)).
gen_reply(S, R):- % asking my name?
        question(Tree2, S, _Rest), !, 
        mapping(s2name,Tree1, Tree2),
        sentence(Tree1, Rep,[]),
        append(Rep, ['!'], R).
gen_reply(S, R):- % asking my name?
        pattern_name(S, _), !,
        responses_db(my_name, D),
        random_pick(D, R).
gen_reply(S, R):- % asking my subjects?
        pattern_my_subjects(S, _), !,
        responses_db(my_subjects, D),
        random_pick(D, R).
gen_reply(S, R):- % map to why question
	sentence(Tree1, S, _Rest), !, 
	mapping(s2why,Tree1, Tree2),
	question(Tree2, Rep,[]),
	append(Rep, ['?'], R).
gen_reply(S, R):- % map to question
	question(Tree2, S, _Rest), !, 
	mapping(s2q,Tree1, Tree2),
	sentence(Tree1, Rep,[]),
	append([yes, ','|Rep], ['!'], R).

%gen_reply(S, R):- % experimental!
%        question(Tree2, S, _Rest), !, 
%        mapping(s2relate,Tree1, Tree2),
%        sentence(Tree1, Rep,[]),
%        append([yes, ','|Rep], ['!'], R).

gen_reply(S, R):- % get information
        \+ is_question(S), 
        \+ information(_, _), !,
        get_info(4),
        responses_db(thanks, D),
        random_pick(D, R).
gen_reply(S, R):- % get feedback
        \+ is_question(S), 
        \+ feedback(_, _), !,
        get_feedback(4),
        responses_db(thanks, D),
        random_pick(D, R).
gen_reply(_, R):- % totally random, last resort
	responses_db(random, Res),
	random_pick(Res, R).

% is_greeting(Sentence)
% 
% True if the sentence matches any greetings in the database.
is_greeting(S):-
        greeting_db(D),
        intersect(S, D, A),
        A \== [].

is_question(S):-
        member('?', S).

is_thanks(S):-
        thanks_db(D),
        intersect(S, D, A),
        A \== [].

is_quit(S):- 
        subset([bye], S).

get_location(0).
get_location(N):-
        print_prompt(you),
        readin(L),
        M is N - 1,
        get_location(L, M).
get_location(_, 0).
get_location(X, _):-
        is_valid_loc(X, L), 
        assert(loc(L)), !.
get_location(_, N):- 
        responses_db(get_location, D),
        random_pick(D, R),
        print_prompt(me),
        write_list(R),
        M is N - 1,
        get_location(M).

is_valid_loc([H|_], L):- 
        (info(L, H); next(H,_,_,_,_)), !.
is_valid_loc([_|T], L):-
        is_valid_loc(T, L).

get_feedback(0).
get_feedback(N):-
        questions_db(feedback, D),
        nth_item(D, N, R),
        print_prompt(me),
        write_list(R),
        print_prompt(you),
        readin(S),
        assert(feedback(R, S)),
        M is N - 1,
        get_feedback(M).

get_info(0).
get_info(N):-
        questions_db(info, D),
        nth_item(D, N, Q),
        print_prompt(me),
        write_list(Q),
        print_prompt(you),
        readin(R),
        assert(information(Q, R)),
        get_info(Q, R),
        M is N - 1,
        get_info(M).
get_info(QL, RL):-
        nth_item(QL, 1, Q),
        contains(Q, name), !,
        get_usr_name(Q, RL).
get_info(QL, _):-
        nth_item(QL, 1, Q),
        contains(Q, subjects), !,
        get_alevel_info_loop.
get_info(_, _).

get_usr_name(_, RL):-
        is_valid_name(RL),
        assert(usr_name(RL)), !.
get_usr_name(Q, _):-
        responses_db(get_name, D), 
        random_pick(D, X), 
        print_prompt(me),
        write_list(X),
        get_usr_name(Q).
get_usr_name(Q):-
        print_prompt(you),
        readin(S),
        get_usr_name(Q, S).

is_valid_name(NL):-
        nth_item(NL, 1, N),
        name(N).

get_alevel_info_loop:-
	print_prompt(you),
	readin(S),
	get_alevel_info_loop(S).
get_alevel_info_loop(S):- 
	is_valid_alevel(S), !.
get_alevel_info_loop(_):- 
        responses_db(get_alevels, D),
        random_pick(D, R),
        print_prompt(me),
        write_list(R),
        get_alevel_info_loop.

is_valid_alevel(S):- 
        alevel_db(D),
        intersect(S,D, A),
        A \== [],
        assert(alevel(A)).

print_welcome:-
        responses_db(greeting, D),
        random_pick(D, W),
        print_prompt(me),
	write_list(W), 
	flush_output. 

print_prompt(me):-
	my_icon(X), write(X), write(': '), flush_output.
print_prompt(you):-
	user_icon(X), write(X), write(': '), flush_output.

my_icon('user 1').
user_icon('user 2').

random_pick(Res, R):- 
        length(Res, Length),  
        Upper is Length+1,
        % create a random number between 1..Upper
        random(1, Upper, Rand),
        nth_item(Res, Rand, R).

% print_report/0
%
% 
print_report:-
        write('\n--- Conversation report ---\n'),
	usr_name(X), alevel(Y), 
        write_list(['User name:', X, 'Studying: ', Y]),
        retract(usr_name(X)), retract(alevel(Y)), fail.
print_report:-
        nl, feedback(X, Y), write(X), write(' : '), write_list(Y), 
        retract(feedback(X, Y)), fail.
print_report:-
        nl, information(X, Y), write(X), write(' : '), write_list(Y), 
        retract(information(X, Y)), fail.
print_report.

