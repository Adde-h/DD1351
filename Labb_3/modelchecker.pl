% Adeel Hussain & Philip Tonaczew
% Labb 3
%
%
%
% cd C:/Users/tonac/Documents/GitHub/DD1351/Labb_3/
% swipl
% consult('modelchecker.pl').


% check(T, L, S, U, F)
% T - The transitions in form of adjacency lists
% L - The labeling
% S - Current state
% U - Currently recorded states
% F - CTL Formula to check.
%


% T = [s2, [s0]]
% L = [s2, [q]]
% S = s2.

verify(Input) :-
    see(Input), read(T), read(L), read(S), read(F), seen,
    check(T, L, S, [], F).

% Literals
check(_, L, S, [], X):-
    member([S,Q], L),
    member(X,Q),
    write('Literals!\n').

check(_, L, S, [], neg(X)):-
    member([S,Q], L),
    \+ member(X,Q),
    write('Neg Literals!\n').

% And - Valid 087
check(T, L, S, [], and(X1,X2)):-
    check(T, L, S, [], X1),
    check(T, L, S, [], X2),
    write('And!\n').

% Or - valid 035
check(T, L, S, [], or(X1,X2)):-
    check(T, L, S, [], X1);
    check(T, L, S, [], X2),
    write('Or!\n').

% AX - Alla nästa väg gäller fi - valid175
check(T, L, S, [], ax(X)):-
    member([S,Q], T),
    checkALL(T, L, Q, [], X),
    write('AX\n').




/*
check(T, L, S, [], ax(X)):-
    member([S,Q],T),
    checkAX(L,X,Q),
    write('Ax!\n').

checkAX(_,_,[]).
checkAX(L,X,[Q|Tail]):-
    member([Q,L2],L),
    member(X,L2),
    checkAX(L,X,Tail).
*/

% EX - I något av nästa vägarna gäller fi - valid 005
check(T, L, S, [], ex(X)):-
    member([S,Q], T),
    checkSOME(T, L, Q, [], X),
    write('EX\n').



/*
check(T, L, S, [], ex(X)):-
    member([S,Q],T),
    checkEX(L,X,Q),
    write('Ex!\n').

checkEX(_,_,[]).
checkEX(L,X,[Q|Tail]):-
    member([Q,L2],L),
    member(X,L2), 
    checkEX(L,X,Tail).
*/

    
% AG - För alla vägar gäller fi alltid - valid151
check(T, L, S, U, ag(X)).
    
    




% EG - Det finns en väg där alltid fi gäller - valid016

% EF - Det finns en väg där så småningom fi gäller - valid023

% AF - Över alla vägar gäller fi så småningom - valid004


% predikat för att kolla alla vägar 'A'
checkALL(_, _, [], _, _).
checkALL(T, L, [Q1|Tail], [], X):-
    check(T, L, Q1, [], X),
    checkALL(T, L, Tail, [], X).

% predikat för att kolla någon väg 'E'
checkSOME(T, L, [Q1|Tail], [], X):-
    check(T, L, Q1, [], X);
    checkSOME(T, L, Tail, [], X).