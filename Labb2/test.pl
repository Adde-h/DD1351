:- discontiguous check_rule/3.
% ['C:/Users/tonac/Desktop/Prolog/Labb2/beviskoll2.pl'].
% ['C:/Users/tonac/Documents/GitHub/DD1351/Labb2/beviskoll4.pl'].
% ['C:/Users/adeel/OneDrive/KTH/Årskurs 2/HT-20/Logik För Dataloger/DD1351/Labb 2/beviskoll2.pl'].
% ['test.pl'].
%test



verify(InputFileName) :- see(InputFileName),
	read(Prems), read(Goal), read(Proof),
	seen,
	valid_proof(Prems, Goal, Proof).

valid_proof(Prems, Goal, Proof):- 
	checkGoal(Goal, Proof),
	checkProof(Prems, Proof, []), !,
	write('predikatet uppfyll!').

% Steg 1: kontrollera att slutsatsen goal i HL (sekventen) står på sista raden

checkGoal(Goal, Proof):- 
	last(Proof, LastRow),
	nth1(2, LastRow, Goal).
	
% Steg 2: Kontrollera beviset rad för rad

checkProof(_, [], _).
checkProof(Prems, [H|T], CheckedList):- 
    check_rule(Prems, H, CheckedList),
    addToList(H, CheckedList, NewList),
    checkProof(Prems, T, NewList).

%% Kollar om det är en premiss
check_rule(Prems, [_, Atom, premise], _):-
	member(Atom, Prems).

% Kollar andint(X,Y)
check_rule(_, [_, and(X2,Y2), andint(X,Y)], CheckedList):-
	member([X, X2, premise], CheckedList),
	member([Y, Y2, premise], CheckedList).

% Kollar orint1(X)
check_rule(_,[_,or(X,_), orint1(Z)], CheckedList):-
	member([Z,X,_], CheckedList).

% Kollar orint2(X)
check_rule(_,[_,or(_,Y), orint2(Z)], CheckedList) :-
	member([Z,Y,_], CheckedList).

% Kollar regel andel1
check_rule(_, [_, Atom, andel1(X)],_):-
	member([X, and(X2,_), _], CheckedList).

% Kollar regel andel2
check_rule(_, [_, Atom, andel2(X)],_):-
	member([X, and(_,X2), _], CheckedList).

% Kollar regel Implikations Elemenering (impel(x,y))
check_rule(_, [_, Atom, impel(X,Y)], CheckedList):-
    member([X, X2,_], CheckedList),
    member([Y, imp(X2,Atom),_], CheckedList).

% Kollar regel lem
check_rule(_, or(Atom, neg(Atom), lem)):-
	true.

% Kollar regel Copy(x)
check_rule(_,[_,Atom, copy(X)], CheckedList):- 
	member([X,Atom,_], CheckedList).

%Kollar regel Negations Eleminering (negel)
check_rule(_,[_,cont, negel(X,Y)], CheckedList):-
	member([X, X2,_], CheckedList),
	member([Y, neg(X2),_], CheckedList).

% Kollar regel mt(x,y) (ska lägga in resternade tre scenario till)
check_rule(_,[_, neg(Atom), mt(X,Y)], CheckedList):-
	member([X,imp(Atom,neg(Atom2)),_], CheckedList),
	member([Y,neg(neg(Atom2)),_], CheckedList).

% Kollar regel dubbelnegation introduktion negnegint(x)
check_rule(_,[_, neg(neg(Atom)), negnegint(X)], CheckedList):-
	member([X, Atom,_], CheckedList).

% Kollar regel Dubbelnegations Eleminering (negnegel)
%check_rule(_,_,_).



% Lägger till ny lista
addToList(H, CheckedList, NewList):-
    appendEl(H, CheckedList, NewList).
     
% Lägger in längst bak i nya listan
appendEl(X, [], [X]).
appendEl(X, [H | T], [H | Y]):-
	appendEl(X, T, Y).