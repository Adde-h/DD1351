% ['C:/Users/tonac/Desktop/Prolog/Labb2/beviskoll2.pl'].
% ['C:/Users/adeel/OneDrive/KTH/Årskurs 2/HT-20/Logik För Dataloger/DD1351/Labb 2/beviskoll2.pl'].
% ['beviskoll2.pl'].
%
% [1, p, impel(2,1)]


verify(InputFileName) :- see(InputFileName),
	read(Prems), read(Goal), read(Proof),
	seen,
	valid_proof(Prems, Goal, Proof).

% Steg 1: kontrollera att slutsatsen goal i HL (sekventen) stör på sista raden

valid_proof(Prems, Goal, Proof) :-
	checkGoal(Goal, Proof),
	checkProof(Proof, []), !,
	write('predikatet uppfyllt!').

checkGoal(Goal, Proof) :-
	last(Proof, LastRow),
	nth1(2, LastRow, Goal).

% Steg 2: Kontrollera beviset rad för rad

checkProof([], _).
checkProof([H|T], CheckedList):-
	check_rule(H),
	checkProof(T, CheckedList).

% Kollar om det är en premiss

check_rule([_, Atom, premise]):-
	member(Atom, Prems).



%Kollar för varje regel check_rule

%Impel
%check_rule([_,Prems, impel(X,Y)],

%check_rule([_,Prems, and(X,Y)],




