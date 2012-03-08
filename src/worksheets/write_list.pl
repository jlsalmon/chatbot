/*******************************************************

write_list(List).

The items in List are printed on screen, one by one.

*******************************************************/


write_list([H|T]):- T = [], write(H).

write_list([H|T]):- write(H), write(' '), write_list(T).


/*******************************************************

Output

| ?- write_list(['Hello', 'world', !]).
Hello world !
yes

********************************************************/
