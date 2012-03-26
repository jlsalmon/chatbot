% File:         database.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Contains databases for general use throughout the chatbot
%               program.

responses_db(random, [
        ['Hello!'],
        ['Hi there, this is not a Hello World program!'],
        ['Oh ... ok.'],
        ['Isn\'t it a nice day?'],
        ['Sorry, I\'m only a simple chatbot.'],
        ['Sorry, I can\'t remember everything you said...'],
        ['Can you say that again?'],
        ['Do you like UWE?'],
        ['Can we be friends?'],
        ['Have you taked to me before?'],
        ['...what do you mean?'] 
        ]).

responses_db(bye, [
        ['Bye!'], 
        ['Hope to see you again.'], 
        ['Have a nice day!']
        ]).

responses_db(greeting, [
        ['hello!'], 
        ['Hello, nice to meet you.'], 
        ['Hi there!']
        ]).

responses_db(change_topic, [
        ['Do you mind if I ask you some questions?']
        ]).

responses_db(get_location, [
        ['Sorry, I don\'t know where that is.'],
        ['Are you sure that\'s in Q block?'],
        ['That\'s not in Q block...'],
        ['Can you try that again?']
        ]).

responses_db(get_alevels, [
        ['Haven\'t heard of that one before!'],
        ['That\'s not a real subject...']
        ]).
            
responses_db(my_name, [
        ['My name is CHATBOT, nice to meet you.'],
        ['I\'m CHATBOT!'],
        ['My name isn\'t important right now.'],
        ['CHATBOT, at your service, how may I help?']
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
        psychology,
        english,
        french,
        spanish,
        german,
        music,
        computing
        ]).

