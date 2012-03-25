% File: database.pl
% Author: Justin Lewis Salmon
% Student ID: 10000937
%
% Description: 

responses_db(random, [
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

responses_db(bye, [
        [bye, '!'], 
        [hope, to, see, you, again, '.'], 
        [have, a, nice, day, '!']
        ]).

responses_db(greeting, [
        ['hello!'], 
        ['hello,', nice, to, meet, 'you.'], 
        [hi, 'there!']
        ]).

responses_db(change_topic, [
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

