% File:         chat.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  
%
% Compulsory questions to be asked:
%       - What is your name?
%       - What are you studying?
%       - Where is the reception?
%       - Is there a cafe in this building?
%       - How do I get out of this building?

:- [map, database, route, pattern, readin, english, lib, names].
:- use_module(library(random)).
:- dynamic information/2, feedback/2, alevel/1.
:- volatile information/2, feedback/2, alevel/1.

% top level call
chat:-
	print_welcome, nl,
	conversations.

conversations:-
	repeat, % prolog built-in which repeats through backtracking 
	print_prompt(you),
	readin(S),
	gen_reply(S,R),
	print_prompt(me),
	write_list(R),
	is_quit(S), 
        print_report, !.

% check for "bye"
gen_reply(S, R):- 
        is_quit(S), !,
	responses_db(bye, Res), 
	random_pick(Res, R).
% check for greeting
gen_reply(S, R):- 
        is_greeting(S), !,
	responses_db(greeting, Res), 
	random_pick(Res, R).
% give a route
gen_reply(S, R):- 
	pattern_to_from(S, X, Y), !,
	find_route(X, Y, R).
% give directions
gen_reply(S, R):- 
        pattern_where_is(S, X), !,
        (info(D, X); next(X,_,_,_,_)),
        print_prompt(me),
        write('Where are you at the moment?'), nl,
        get_location,
        location(Y),
        find_route(Y, D, R),
        retract(location(Y)).
% asking my name?
gen_reply(S,Reply):- 
        question(Tree2, S, _Rest), !, 
        mapping(s2name,Tree1, Tree2),
        sentence(Tree1, Rep,[]),
        append([yes, ','|Rep], ['!'], Reply).
gen_reply(S, R):-
        pattern_name(S, _), !,
        responses_db(my_name, D),
        random_pick(D, R).
% map to why question
gen_reply(S,Reply):- 
	sentence(Tree1, S, _Rest), !, 
	mapping(s2why,Tree1, Tree2),
	question(Tree2, Rep,[]),
	append(Rep, ['?'], Reply).
% map to question
gen_reply(S,Reply):- 
	question(Tree2, S, _Rest), !, 
	mapping(s2q,Tree1, Tree2),
	sentence(Tree1, Rep,[]),
	append([yes, ','|Rep], ['!'], Reply).
% start asking questions
gen_reply(S, R):-
        \+ is_question(S), 
        \+ feedback(_, _), !,
        get_feedback(4),
        responses_db(thanks, D),
        random_pick(D, R).
gen_reply(S, R):-
        \+ is_question(S), !,
        \+ information(_, _),
        get_info(4),
        responses_db(thanks, D),
        random_pick(D, R).
% totally random, last resort
gen_reply(_, R):-
	responses_db(random, Res),
	random_pick(Res, R).

is_greeting(S):-
        greeting_db(D),
        intersect(S, D, A),
        A \== [].

is_question(S):-
        member('?', S).

is_quit(S):- 
        subset([bye], S).

get_location:-
        print_prompt(you),
        readin(L),
        get_location(L).
get_location(X):-
        is_valid_loc(X, L), 
        assert(location(L)), !.
get_location(_):- 
        responses_db(get_location, D),
        random_pick(D, R),
        print_prompt(me),
        write_list(R),
        get_location.

is_valid_loc([L|_], L):- 
        next(L,_,_,_,_), !.

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
        nth_item(D, N, R),
        print_prompt(me),
        write_list(R),
        print_prompt(you),
        readin(S),
        assert(information(R, S)),
        M is N - 1,
        get_info(M).
%get_info(N, Q):-
%        subset([name], Q),
        

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
        print_prompt(me),
	write('Welcome! I am a chatbot.'), 
	flush_output. 

print_prompt(me):-
	my_icon(X), write(X), write(': '), flush_output.
print_prompt(you):-
	user_icon(X), write(X), write(': '), flush_output.

my_icon(chatbot).
user_icon(user).

random_pick(Res, R):- 
        length(Res, Length),  
        Upper is Length+1,
        % create a random number between 1..Upper
        random(1, Upper, Rand),
        nth_item(Res, Rand, R).

print_report:-
        write('Conversation report:'),
	alevel(X), write(X), write(' '), 
        retract(alevel(X)), fail.
print_report:-
        nl, feedback(X, Y), write(X), write(' : '), write_list(Y), 
        retract(feedback(X, Y)), fail.
print_report:-
        nl, information(X, Y), write(X), write(' : '), write_list(Y), 
        retract(information(X, Y)), fail.
print_report.

