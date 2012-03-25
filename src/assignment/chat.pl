:- [map, readin, find_route, english].

:- use_module(library(random)). % needed for genreating a random number

% top level call
chat:-
	print_welcome, nl,
	conversations.

conversations:-
	repeat, % prolog built-in which repeats through backtracking 
	print_prompt(you),
	readin(S), 		% defined in file readin.pl
	gen_reply(S,R),
	print_prompt(me),
	write_list(R),
	is_quit(S).

% check for "bye"
gen_reply(S, R):- is_quit(S), !,
	respones_db(bye, Res), 
	random_pick(Res, R).
% check for greeting
gen_reply(S, R):- is_greeting(S), !,
	respones_db(greeting, Res), 
	random_pick(Res, R).
% give a route
gen_reply(S, R):- 
	pattern_to_from(S, X, Y), !,
	give_route(X, Y, R).
% give directions
gen_reply(S, R):- 
        pattern_where_is(S, X), !,
        get_location,
        write(location(Y)),
        give_route(X, Y, R).
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
        not_question(S), !,
        get_alevel_info_loop,
        R = ['Thanks', for, the, 'info!'].
% totally random, last resort
gen_reply(_, R):-
	respones_db(random, Res),
	random_pick(Res, R).


random_pick(Res, R):- 
	length(Res, Length),  
	Upper is Length+1,
	% create a random number between 1..Upper
	random(1, Upper, Rand),
	nth_item(Res, Rand, R).


is_quit(S):- subset([bye], S), print_report, !.

is_greeting(S):-
        greeting_db(D),
        intersect(S, D, A),
        A \== [].

not_question(S):-
        \+member('?', S).

pattern_to_from([to, X, from, Y |_], Y, X):-!.
pattern_to_from([from, X, to, Y |_], X, Y):-!.
pattern_to_from([at, X, how, do, i, get, to, Y |_], Y, X):-!.
pattern_to_from([from, X, how, do, i, get, to, Y |_], X, Y):-!.
pattern_to_from([_|T], X, Y):-
	pattern_to_from(T, X, Y).

pattern_where_is([where, is, X |_], X):-!.
pattern_where_is([where, is, the, X |_], X):-!.
pattern_where_is([where, is, a, X |_], X):-!.
pattern_where_is([where, can, i, find, X |_], X):-!.
pattern_where_is([where, can, i, find, the, X |_], X):-!.
pattern_where_is([where, can, i, find, a, X |_], X):-!.
pattern_where_is([_|T], X):-
        pattern_where_is(T, X).

get_location:-
        print_prompt(me),
        write('Where are you at the moment?'), nl,
        print_prompt(you),
        readin(L),
        get_location(L).

get_location(L):-
        is_valid_loc(L), assert(location(L)), !.

get_location(_):- get_location.

is_valid_loc(X):- next(X,_,_,_,_).

get_alevel_info_loop:-
	print_prompt(me),
	write_list(['What', subjects, are, you, taking, '?']),
	print_prompt(you),
	readin(S),
	get_alevel_info_loop(S).

get_alevel_info_loop(S):- 
	is_valid_alevel(S), !.

get_alevel_info_loop(_):- get_alevel_info_loop.

is_valid_alevel(S):- 
    alevel_db(D),
    intersect(S,D, A),
    A \== [],
   assert(alevel(A)).

intersect([], _, []).  % an empty list intersect with any list = an empty list

intersect([H|T1], L2, [H|T3]):- member(H, L2), !, % if the head of L1 is in L2,it  must be in L3, 
        intersect(T1, L2, T3).                                 % carry on checking the rest of L1

intersect([_|T1], L2, L3):- % otherwise skip head,  carry on checking
        intersect(T1, L2, L3).

respones_db(random, [
	[hello, !],
	[hi, there , '.', this, is, not, a, hello_world, program, '!'],
	[oh, '......', ok],
	[it, is, a, nice, day, '.'],
	[sorry, ',', i, am, only, a, single, minded, chatbot, '.'],
	[sorry, i, cannot, remember, everything, you, said, '.'],
	[can, you, say, it, again, '?'],
	[do, you, like, uwe, '?'],
	[can, we, be, friends, '?'],
	[have, you, talked, to, me, before, '?'],
  	['.', '.', '.', what, do, you, mean, '?'] 
	]).

respones_db(bye, [
	[bye, '!'], 
	[hope, to, see, you, again, '.'], 
	[have, a, nice, day, '!']
	]).

respones_db(greeting, [
	['hello!'], 
	['hello,', nice, to, meet, 'you.'], 
	[hi, 'there!']
	]).

respones_db(change_topic, [
	]).

greeting_db([
        hello, 
        hi, 
        hey
        ]).

alevel_db([maths,
	physics,
	chemistry,
	geography,
	biology,
	history,
	psychology
        ]).

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


write_list([]):- nl.
write_list([H|T]):- write(H), write(' '), write_list(T).


subset([], _).
subset([H|T], L2):- 
	member(H, L2),
	subset(T, L2).


nth_item([H|_], 1, H).
nth_item([_|T], N, X):-
	nth_item(T, N1, X),
	N is N1 + 1.

print_report:-
	alevel(X), write(X), write(' '), retract(alevel(X)), fail.
print_report:- nl.

