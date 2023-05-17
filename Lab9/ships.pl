% Render the ship term as a nice table.
:- use_rendering(table,[header(s('Ship', 'Leaves at', 'Carries', 'Chimney', 'Goes to'))]).

% Each ship is represented a term, s(S,L,Ca,Ch,G). A list of 5 such terms is a solution.
goes_PortSaid(Goes) :-
	ships(S),
	member(s(Goes,_,_,_,portSaid), S).

carries_tea(Carries) :-
	ships(S),
	member(s(Carries,_,tea,_,_), S).
    
ships(S) :- 
    length(S,5),
    member(s(greek,6,coffee,_,_),S),
    S = [_,_,s(_,_,_,black,_),_,_],
    member(s(english,9,_,_,_),S),
    left(s(french,_,_,blue,_),s(_,_,coffee,_,_),S),
    left(s(_,_,cocoa,_,_),s(_,_,_,_,marseille),S),
    member(s(brazilian,_,_,_,manila),S),
    next(s(_,_,rice,_,_),s(_,_,_,green,_),S),
    member(s(_,5,_,_,genoa),S),
    left(s(_,_,_,_,marseille),s(spanish,7,_,_,_),S),
    member(s(_,_,_,red,hamburg), S),
    next(s(_,7,_,_,_),s(_,_,_,white,_),S),
    border(s(_,_,corn,_,_),S),
    member(s(_,8,_,black,_),S),
    next(s(_,_,corn,_,_),s(_,_,rice,_,_),S),
    member(s(_,6,_,_,hamburg),S),
    % ^ Rules 1 - 15
    member(s(_,_,_,_,portSaid),S),   % forces some ship to go to Port Said
    member(s(_,_,tea,_,_),S).        % forces some ship to carry tea

% Predicates for capturing relationships in a list of ships, Ls
next(A, B, Ls) :- left(A, B, Ls).  % A and B are next to one another (in some order)
next(A, B, Ls) :- left(B, A, Ls).
left(A, B, Ls) :- append(_,[A,B|_],Ls).  % A is immediately to the left of B (and thus B is to the right of A)
border(A, Ls) :- Ls = [A|_].   % A is on the border (either end of Ls)
border(A, Ls) :- last(Ls, A).
