:-style_check(-singleton).

type(lastname, personal).
type(maidenname, personal).
type(firstpet, personal).
type(lasths, personal).
type(mombirthplace, personal).
type(numsiblings, personal).
type(nameofelemschool, personal).
type(favoritefood, personal).
type(jobtitle, usage).
type(homedirectory, usage).
type(lastlogin, usage).
type(bossname, usage).
type(officenum, usage).
type(securityclearance, usage).
type(carmake, usage).
type(toolbrand, usage).
type(season, presence).
type(timeofday, presence).
type(weatheryesterday, presence).
type(lastbigstormmonth, presence).
type(randomriddle, presence).
type(captcha, presence).
type(dayofweekbday, presence).
type(typeoftree, presence).

value(lastname, 1).
value(maidenname, 8).
value(firstpet, 3).
value(lasths, 5).
value(mombirthplace, 9).
value(numsiblings, 2).
value(nameofelemschool, 6).
value(favoritefood, 4).
value(jobtitle, 5).
value(homedirectory, 5).
value(lastlogin, 6).
value(bossname, 3).
value(officenum, 4).
value(securityclearance, 8).
value(carmake, 2).
value(toolbrand, 7).
value(securityclearance, 8).
value(season, 2).
value(timeofday, 1).
value(weatheryesterday, 3).
value(lastbigstormmonth, 6).
value(randomriddle, 8).
value(captcha, 7).
value(dayofweekbday, 4).
value(typeoftree, 5).

string(lastname, 'What is your last name?').
string(maidenname, 'What is your moms maiden name?').
string(firstpet, 'What was your first pets name?').
string(lasths, 'Where did you last attend High School?').
string(mombirthplace, 'Where was your mom born?').
string(numsiblings, 'How many siblings do you have?').
string(nameofelemschool, 'What is the name of the elementary school you attended?').
string(favoritefood, 'What is your favorite food?').
string(jobtitle, 'What is your job title?').
string(homedirectory, 'What is your home directory?').
string(lastlogin, 'When did you last login?').
string(bossname, 'What is your boss name?').
string(officenum, 'What number office do you work in?').
string(securityclearance, 'What is your level of security clearance?').
string(carmake, 'What is the make/model of your current car?').
string(toolbrand, 'What is the tool brand you own the most of?').
string(season, 'What season is it currently?').
string(timeofday, 'What is the time of day?').
string(weatheryesterday, 'What was the weather like yesterday?').
string(lastbigstormmonth, 'What month was the last big storm in?').
string(randomriddle, 'Randomly generated riddle here...').
string(captcha, 'Prove you are not a robot by solving this captcha...').
string(dayofweekbday, 'What day of the week does your birthday fall on this year?').
string(typeoftree, 'What type of trees are in your neighborhood?').

ind(lastname, 1).
ind(maidenname, 2).
ind(firstpet, 3).
ind(lasths, 4).
ind(mombirthplace, 5).
ind(numsiblings, 6).
ind(nameofelemschool, 7).
ind(favoritefood, 8).
ind(jobtitle, 9).
ind(homedirectory, 10).
ind(lastlogin, 11).
ind(bossname, 12).
ind(officenum, 13).
ind(securityclearance, 14).
ind(carmake, 15).
ind(toolbrand, 16).
ind(season, 17).
ind(timeofday, 18).
ind(weatheryesterday, 19).
ind(lastbigstormmonth, 20).
ind(randomriddle, 21).
ind(captcha, 22).
ind(dayofweekbday, 23).
ind(typeoftree, 24).

main :- % Runs the program
  random_picker(X),
  ask_question(X, ML),
  !.

ask_question(X, ML) :- % Generates first question
  ind(Y, X), % Determines what the variable(Y) of random number(X) is %
  string(Y,Z), % Gets the string(Z) of variable(Y)
  value(Y,R),
  TL = [Z],
  type(Y,Q),
  append(ML, TL, L), % Combining the lists
  add_question(TL, R, Q). % Adds second question to the list

random_picker(X) :- % Gets a random number between 1 and max num of questions
  random(1, 24, X).

mem_check(Y, L, R, Q, NR) :- % Checks if Y is member of L, if so, generate a new question
  member(Y, L),
  add_question(L, R, Q).

mem_check(Y, L, R, Q, NR) :- % Y wasnt a member, check its type
  type_check(Y, L, R, Q, NR).

type_check(Y, L, R, Q, NR) :- % Y is the same type of question as the question in the list... generate new question
  string(X, Y),
  type(X, NQ),
  NQ == Q,
  add_question(L, R, Q).

type_check(Y, L, R, Q, NR) :- % Y is a different type! Check its value to see if we need more questions to reach >= 9
  TL = [Y],
  append(L, TL, NL),
  V is NR + R, % Keeps track of value
  value_check(Y, NL, V, Q).

mem_check2(Y, L, R, Q) :- % For the case with 2 or more questions in the list, skips type checking, but if its a member, get a new question
  member(Y, L),
  add_question(L, R, Q).

mem_check2(Y, L, R, Q) :- % Dont care about type, not a member of the list, append and check value
  TL = [Y],
  append(L, TL, NL),
  value_check(Y, NL, R, Q).

value_check(Y, NL, R, Q) :- % Value is less than or equal to 9, need another question
  R =< 9,
  add_question2(NL, R, Q).

value_check(Y, NL, R, Q) :- % Y is > 9! We can print!
  print(NL).

add_question(TL, R, Q) :- % Handles the case if you have one other question in the list, worries about type
  random_picker(X),
  ind(Z, X),
  type(Z,NQ),
  value(Z,NR),
  string(Z,S),
  mem_check(S, TL, R, Q, NR). % Is S already in temporary list?

add_question2(TL, R, Q) :- % Handles the case if there are 2 or more questions in the list, doesnt care about type
  random_picker(X),
  ind(Z, X),
  type(Z,NQ),
  value(Z,NR),
  V is NR + R,
  string(Z,S),
  mem_check2(S, TL, V, Q). % Is S already in temporary list?
