%['C:/Users/adeel/OneDrive/KTH/Årskurs 2/HT-20/Logik För Dataloger/DD1351/Labb 1/uppgift3.pl'].


select(X,[X|T],T).
select(X,[Y|T],[Y|R]) :- select(X,T,R).

member(X,L) :- select(X,L,_).

appendEl(X, [], [X]).             %Basecase only runs when list is empty
appendEl(X, [H | T], [H | Y]) :-  %Out of recursive loop appends back
           appendEl(X, T, Y).     %Recursivly appends tail until tail is []

remove_duplicates(Input, Output) :-
     check_duplicates(Input, [], Output).

check_duplicates([], Acc, Acc).   %Basecase when Acc is equal to Acc (Program finished)

check_duplicates([H|T], Acc, Output) :-
     member(H,Acc),
     check_duplicates(T,Acc,Output).

check_duplicates([H|T],Acc,Output) :-
     \+member(H,Acc),
     appendEl(H,Acc,List),
     check_duplicates(T,List,Output).


%remove_duplicates([1,2,3,2,4,1,3,4], E).








