type(lastname, personal).
type(maidenname, personal).
type(firstpet, personal).
type(lasths, personal).
type(mombirthplace, personal).
type(numsiblings, personal).
type(jobtitle, usage).
type(homedirectory, usage).
type(lastlogin, usage).
type(bossname, usage).
type(officenum, usage).
type(securityclearance, usage).
type(season, presence).
type(timeofday, presence).
type(weatheryesterday, presence).
type(lastbigstormmonth, presence).
type(randomriddle, presence).
type(captcha, presence).

value(lastname, 1).
value(maidenname, 8).
value(firstpet, 3).
value(lasths, 5).
value(mombirthplace, 9).
value(numsiblings, 2).
value(jobtitle, 5).
value(homedirectory, 5).
value(lastlogin, 6).
value(bossname, 3).
value(officenum, 4).
value(securityclearance, 8).
value(season, 2).
value(timeofday, 1).
value(weatheryesterday, 3).
value(lastbigstormmonth, 6).
value(randomriddle, 8).
value(captcha, 7).

string(lastname, 'What is your last name?').
string(maidenname, 'What is your moms maiden name?').
string(firstpet, 'What was your first pets name?').
string(lasths, 'Where did you last attend High School?').
string(mombirthplace, 'Where was your mom born?').
string(numsiblings, 'How many siblings do you have?').
string(jobtitle, 'What is your job title?').
string(homedirectory, 'What is your home directory?').
string(lastlogin, 'When did you last login?').
string(bossname, 'What is your boss name?').
string(officenum, 'What number office do you work in?').
string(securityclearance, 'What is your level of security clearance?').
string(season, 'What season is it currently?').
string(timeofday, 'What is the time of day?').
string(weatheryesterday, 'What was the weather like yesterday?').
string(lastbigstormmonth, 'What month was the last big storm in?').
string(randomriddle, 'Randomly generated riddle here...').
string(captcha, 'Prove you are not a robot by solving this captcha...').

ind(lastname, 1).
ind(maidenname, 2).
ind(firstpet, 3).
ind(lasths, 4).
ind(mombirthplace, 5).
ind(numsiblings, 6).
ind(jobtitle, 7).
ind(homedirectory, 8).
ind(lastlogin, 9).
ind(bossname, 10).
ind(officenum, 11).
ind(securityclearance, 12).
ind(season, 13).
ind(timeofday, 14).
ind(weatheryesterday, 15).
ind(lastbigstormmonth, 16).
ind(randomriddle, 17).
ind(captcha, 18).

main :-
   ML = [],
  random_picker(X),
  ask_question(X, ML).
  % write('Continue generating lists? (Y/N)'),
  % read(A),
  % continue_gen(A, ML).

continue_gen(A, ML) :-
  A == 'Y',
  ask_question(X, ML).

continue_gen(A, ML) :-
  write('Thanks for using my program! Goodbye.'), nl,
  !.

ask_question(X, ML) :-
  ind(Y, X), % Determines what the variable(Y) of random number(X) is %
  string(Y,Z), % Gets the string(Z) of variable(Y) %
  value(Y,R),
  TL = [Z],
  type(Y,Q),
  check_start(Z, ML),
  append(ML, TL, L),
  add_question(TL, R, Q).

add_question(TL, R, Q) :-
  random_picker(X),
  ind(Z, X),
  type(Z,NQ),
  value(Z,NR),
  string(Z,S),
  mem_check(S, TL, R, Q, NR). % Is S already in temporary list?

add_question2(TL, R, Q) :-
  random_picker(X),
  ind(Z, X),
  type(Z,NQ),
  value(Z,NR),
  V is NR + R,
  string(Z,S),
   mem_check2(S, TL, V, Q). % Is S already in temporary list?

check_start(Z, L) :-
  member(Z, L),
  ask_question(X, ML).

check_start(Z, L) :-
  !.

random_picker(X) :-
  random(1, 18, X). % Gets a random number between 1 and max num of questions %

mem_check(Y, L, R, Q, NR) :-
  member(Y, L),
  add_question(L, R, Q).

mem_check(Y, L, R, Q, NR) :-
  type_check(Y, L, R, Q, NR).

mem_check2(Y, L, R, Q) :-
  member(Y, L),
  add_question(L, R, Q).

mem_check2(Y, L, R, Q) :-
  value_check(Y, L, R, Q).

type_check(Y, L, R, Q, NR) :-
  string(X, Y),
  type(X, NQ),
  NQ == Q,
  add_question(Y, L, R, Q).

type_check(Y, L, R, Q, NR) :-
  V is NR + R,
  TL = [Y],
  append(L, TL, NL),
  value_check(NL, V, Q).

value_check(Y, L, R, Q) :-
  R =< 9,
  add_question2(L, R, Q).

value_check(Y, L, R, Q) :-
  TL = [Y],
  append(L, TL, NL),
  print(NL),
  !.
