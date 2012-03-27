% File:         database.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Contains databases for general use throughout the chatbot
%               program.

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

responses_db(get_name, [
        ['Is that your real name?'],
        ['That\'s not your real name...'],
        ['That can\'t be your name.']
        ]).
            
responses_db(my_name, [
        ['My name is CHATBOT, nice to meet you.'],
        ['I\'m CHATBOT!'],
        ['My name isn\'t important right now.'],
        ['CHATBOT, at your service, how may I help?']
        ]).

responses_db(my_subjects, [
        ['I\'m studying Computer Science!'],
        ['Computer Science - it\'s great.'],
        ['Never mind about my subjects...'],
        ['Computer Science.'],
        ['Why do you want to know what I\'m studying?']
        ]).

responses_db(thanks, [
        ['Thanks for the info!'],
        ['Thanks, that\'s helpful.'],
        ['Ok, thanks.'],
        ['Cheers for that.'],
        ['Nice one.']
        ]).

responses_db(random, [
        ['Oh ... ok.'],
        ['Isn\'t it a nice day?'],
        ['Sorry, I\'m only a simple chatbot.'],
        ['Sorry, I can\'t remember everything you said...'],
        ['Can you say that again?'],
        ['Do you like UWE?'],
        ['Can we be friends?'],
        ['Have you talked to me before?'],
        ['...what do you mean?'],
        ['How impertinent.'],
        ['You\'re quite rude, aren\'t you?'],
        ['Don\t be silly.']
        ]).

questions_db(feedback, [
        ['Okay. Do you think the talk given was informative?'],
        ['Right. Do you think the open day was well organised?'],
        ['Right, ok. Have the student ambassadors been helpful?'],
        ['So, what are your thoughts on the open day overall?']
        ]).

questions_db(info, [
        ['So where are you from?'],
        ['Which universities have you applied to (except UWE)?'],
        ['Right, ok. So what A-level subjects are you taking?'],
        ['What\'s your name?']
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
