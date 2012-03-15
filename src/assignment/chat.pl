:- [map, readin, find_route, english]. % load two files map.pl and readin.pl

:- use_module(library(random)). % needed for genreating a random number

/*** Notes



***/

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

gen_reply(S, R):- is_quit(S),!,
	respones_db(bye, Res), 
	random_pick(Res, R).
gen_reply(S, ['Done']):- 
	pattern_to_from(S, X, Y),!,
	give_route(X, Y).
gen_reply(_, R):-  % totally random
	respones_db(random, Res),
	random_pick(Res, R).
% new
/*
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
*/
random_pick(Res, R):- 
	length(Res, Length),  
	Upper is Length+1,
	% create a random number between 1..Upper
	random(1, Upper, Rand),
	nth_item(Res, Rand, R).


is_quit(S):- subset([bye], S).

pattern_to_from([to, X, from, Y |_], Y, X):-!.
pattern_to_from([from, X, to, Y |_], X, Y):-!.
pattern_to_from([at, X, how, do, i, get, to, Y |_], Y, X):-!.
pattern_to_from([from, X, how, do, i, get, to, Y |_], X, Y):-!.

pattern_to_from([_|T], X, Y):-
	pattern_to_from(T, X, Y).

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
	]).

respones_db(change_topic, [
	]).

print_welcome:-
	write('Welcome! I am a chatbot'), nl, 
	write('Please finish your line with a full stop, ?, or !'), nl, 
	flush_output. 

print_prompt(me):-
	my_icon(X), write(X), write('  : '), flush_output.
print_prompt(you):-
	user_icon(X), write(X), write('  : '), flush_output.

my_icon(bot1).
user_icon(user).


write_list([H]):- !,  write(H), nl.
write_list([H|T]):- write(H), write(' '), write_list(T).


subset([], _).
subset([H|T], L2):- 
	member(H, L2),
	subset(T, L2).


nth_item([H|_], 1, H).
nth_item([_|T], N, X):-
	nth_item(T, N1, X),
	N is N1 + 1.

