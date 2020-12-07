appendEl(X, [], [X]).
appendEl(X, [H | T], [H | Y]) :-
           appendEl(X, T, Y).











