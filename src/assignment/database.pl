% File:         database.pl
% Author:       Justin Lewis Salmon
% Student ID:   10000937
%
% Description:  Contains databases for general use throughout the Derek
%               program.

responses_db(bye, [
        ['Bye!'], 
        ['Hope to see you again.'], 
        ['Have a nice day!']
        ]).

responses_db(greeting, [
        ['Hello!'], 
        ['Hello, nice to meet you.'], 
        ['Hi there!'],
        ['Welcome!'],
        ['Good afternoon!']
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
        ['That can\'t be your name.'],
        ['Just tell me your name...'],
        ['This is silly.']
        ]).
            
responses_db(my_name, [
        ['My name is Derek, nice to meet you.'],
        ['I\'m Derek!'],
        ['My name isn\'t important right now.'],
        ['Derek, at your service, how may I help?']
        ]).

responses_db(my_subjects, [
        ['I\'m studying Computer Science!'],
        ['Computer Science - it\'s great.'],
        ['Never mind about my subjects...'],
        ['Computer Science.'],
        ['Why do you want to know what I\'m studying?'],
        ['Never mind that, what do you want?']
        ]).

responses_db(thanks, [
        ['Thanks for the info!'],
        ['Thanks, that\'s helpful.'],
        ['Ok, thanks.'],
        ['Cheers for that.'],
        ['Nice one.']
        ]).

responses_db(thanked, [
        ['You\'re welcome!'],
        ['Any time.'],
        ['Glad to be of service.'],
        ['No worries.'],
        ['No problem.']
        ]).

responses_db(random, [
        ['Oh ... ok.'],
        ['Isn\'t it a nice day?'],
        ['Sorry, I\'m only a simple Derek.'],
        ['Sorry, I can\'t remember everything you said...'],
        ['Can you say that again?'],
        ['Do you like UWE?'],
        ['Can we be friends?'],
        ['Have you talked to me before?'],
        ['...what do you mean?'],
        ['How impertinent.'],
        ['You\'re quite rude, aren\'t you?'],
        ['Don\'t be silly.']
        ]).

questions_db(feedback, [
        ['Okay. Do you think the talk given was informative?'],
        ['Hmm. Do you think the open day was well organised?'],
        ['Ok, thanks. Have the student ambassadors been helpful?'],
        ['So, what are your thoughts on the open day overall?']
        ]).

questions_db(info, [
        ['Okay, so where are you from?'],
        ['Haha, fair enough. Which universities have you applied to (except UWE)?'],
        ['Nice to meet you. So what A-level subjects are you taking?'],
        ['What\'s your name?']
        ]).

greeting_db([
        hello, 
        hi, 
        hey
        ]).

thanks_db([
        thanks,
        thankyou,
        thank,
        cheers
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
