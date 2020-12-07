% Adeel Hussain & Philip Tonaczew
% Labb 3
%
%
%
% cd C:/Users/tonac/Documents/GitHub/DD1351/Labb3/
% swipl
% ['modelchecker.pl'].



% check(T, L, S, U, F)
% T - The transitions in form of adjacency lists
% L - The labeling
% S - Current state
% U - Currently recorded states
% F - CTL Formula to check.
%


verify(Input) :-
    see(Input), read(T), read(L), read(S), read(F), seen,
    check(T, L, S, [], F).

% Literals
check(_, L, S, [], X).
check(_, L, S, [], neg(X)).

% And
check(T, L, S, [], and(F,G)).


% Or

% AX

% EX

% AG

% EG

% EF

% AF
