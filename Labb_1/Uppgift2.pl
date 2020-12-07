% We want to achieve a failure in some cases, in this case french_car
% should return fail. We do this by defining all car models and then
% defining what categories of cars should fail, there after we write a
% case including a cut and a fail where when the fail is compiled, it
% wont be able to backtrack due to the cut and will therefore show an
% output as negative. Thereby creating a negation by failure


car(mercedes).
car(volvo).
car(tesla).
car(bmw).
car(audi).
car(renault).
car(citroen).

french_car(renault).
french_car(citroen).

likes(adde,X) :- french_car(X), !, fail.

likes(adde,X) :- car(X).

