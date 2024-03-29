% ['C:/Users/tonac/Desktop/Prolog/Labb2/beviskoll2.pl'].
% ['C:/Users/tonac/Documents/GitHub/DD1351/Labb2/beviskoll4.pl'].
% ['C:/Users/adeel/OneDrive/KTH/Årskurs 2/HT-20/Logik För Dataloger/DD1351/Labb 2/beviskoll2.pl'].
% 
% cd C:/Users/tonac/Documents/GitHub/DD1351/Labb2/
% swipl
% ['beviskoll4.pl'].
% test

%premise Klart
%assumption	
%copy(x) Klart
%andint(x,y) Klart
%andel1(x) Klart
%andel2(x) Klart
%orint1(x) Klart
%orint2(x) Klart
%orel(x,y,u,v,w)
%impint(x,y) 
%impel(x,y)	Klart
%negint(x,y) 
%negel(x,y) Klart
%contel(x) 
%negnegint(x) Klart
%negnegel(x) Klart
%mt(x,y) Klart
%pbc(x,y) 
%lem Klart


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
	member([X, X2, _], CheckedList),
	member([Y, Y2, _], CheckedList).

% Kollar orint1(X)
check_rule(_,[_,or(X,_), orint1(Z)], CheckedList):-
	member([Z,X,_], CheckedList).

% Kollar orint2(X)
check_rule(_,[_,or(_,Y), orint2(Z)], CheckedList) :-
	member([Z,Y,_], CheckedList).

% Kollar regel andel1         
check_rule(_, [_, Atom, andel1(X)],CheckedList):-
	member([X, and(Atom,_), _], CheckedList).

% Kollar regel andel2 
check_rule(_, [_, Atom, andel2(X)],CheckedList):-
	member([X, and(_,Atom), _],CheckedList).

% Kollar regel Implikations Elemenering (impel(x,y))
check_rule(_, [_, Atom, impel(X,Y)],CheckedList):-
    member([X, X2,_],CheckedList),
    member([Y, imp(X2,Atom),_],CheckedList).

% Kollar regel lem
check_rule(_, [_,or(Atom, neg(Atom)), lem],_).

% Kollar regel Copy(x)
check_rule(_,[_,Atom, copy(X)],CheckedList):-
	member([X,Atom,_],CheckedList).

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
check_rule(_,[_,Atom, negnegel(X)], CheckedList):-
	member([X, neg(neg(Atom)),_], CheckedList).

% Kollar regel assumption
%check_rule(Prems, [_, Atom, assumption], _):-
%	member(Atom, Prems). %EJ KLARTÄNKT

%Boxhantering

%Kollar boxen och kallar checkProof som sedan rekursivt itererar igenom boxen
check_rule(_, [[_, _, assumption]|T], CheckedList):-
	checkProof(_,T,CheckedList).


% Kollar regel Impint
%check_rule(_, [_, imp(X,Y), impint(X1,Y1)], CheckedList):-
%	member([X1, X, assumption], BoxList)

% Lägger till ny lista
addToList(H, CheckedList, NewList):-
    appendEl(H, CheckedList, NewList).
     
% Lägger in längst bak i nya listan
appendEl(X, [], [X]).
appendEl(X, [H | T], [H | Y]):-
	appendEl(X, T, Y).
	
	
	




