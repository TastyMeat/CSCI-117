:- use_module(library(clpfd)).

add([], [], CarryIn, [H3]) :- H3 #= CarryIn.
add([H1|L1], [H2|L2], CarryIn, [H3|L3]) :-
    H3 #= (H1 + H2 + CarryIn) mod 10,
    CarryOut #= (H1 + H2 + CarryIn) div 10,
    add(L1, L2, CarryOut, L3).

crypt1([H1|L1], [H2|L2], [H3|L3], L4) :- 
    % Give constraints on variable values in L4
    L4 ins 0..9,
    
    % Heads cannot have value 0
    H1 #\= 0, H2 #\= 0, H3 #\= 0,
    
    % Variable values are distinct in L4
    all_different(L4),
    
    % Reverse the 3 input words
    reverse([H1|L1], L1_Reversed),
    reverse([H2|L2], L2_Reversed),
    reverse([H3|L3], L3_Reversed),
    
    % Call to helper function that does the sum with reversed words one iteration at a time
	add(L1_Reversed, L2_Reversed, 0, L3_Reversed).