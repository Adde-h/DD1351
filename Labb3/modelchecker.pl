% Adeel Hussain & Philip Tonaczew
% Labb 3
%
%
%
% cd C:/Users/tonac/Documents/GitHub/DD1351/Labb3/
% swipl
% ['modelchecker.pl'].

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
