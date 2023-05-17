% CSci 117, Lab 8:  Functional techniques and iterators/accumulators

% ---- Part 1: Basic structural recursion ----------------

% 1. Merge sort
deal([], ([],[])).
deal([X|Xs], ([X|Zs], Ys)) :- deal(Xs, (Ys,Zs)).
% mode(--) ?- deal(X,Y); X = [], Y = ([],[])
% mode(++) ?- deal([],([],[])); true
% mode(+-) ?- deal([1,2,3,4,5],X); X = ([1, 3, 5],[2, 4])
% mode(-+) ?- deal(X,([1, 3, 5],[2, 4])); X = [1, 2, 3, 4, 5]

merge([], Xs, Xs).
merge(Xs, [], Xs).
merge([X|Xs], [Y|Ys], [X|Out]) :- X =< Y, merge(Xs, [Y|Ys], Out).
merge([X|Xs], [Y|Ys], [Y|Out]) :- merge([X|Xs], Ys, Out).  
% mode(---) ?- merge(X,Y,Z); X = [], Y = Z
% mode(+++) ?- merge([], [1,2,3], [1,2,3]); true
% mode(++-) ?- merge([], [1,2,3], X); X = [1, 2, 3]
% mode(+-+) ?- merge([], X, [1,2,3]); X = [1, 2, 3]
% mode(-++) ?- merge(X, [], [1,2,3]); X = [1, 2, 3]     
% mode(+--) ?- merge([1,2,3], X, Y); X = [], Y = [1, 2, 3]
% mode(-+-) ?- merge(X, [1,2,3], Y); X = [], Y = [1, 2, 3]
% mode(--+) ?- merge(X, Y, [1,2,3]); X = [], Y = [1, 2, 3]
%                                    X = [1, 2, 3], Y = []

ms([], []).
ms([X], [X]).
ms(Xs, Out) :- deal(Xs, (Ys, Zs)),
               ms(Ys, Y_Sorted),
               ms(Zs, Z_Sorted),
               merge(Y_Sorted, Z_Sorted, Out).
% mode(--) ?- ms(X,Y); X = Y, Y = []
% mode(++) ?- ms([2,4,3,1],[1,2,3,4]); true
% mode(+-) ?- ms([2,4,3,1],X); X = [1, 2, 3, 4]


% 2. A backward list data structure 
cons(N, nil, snoc(nil, N)).
cons(N, snoc(X_List, X), snoc(Y_List, X)) :- cons(N, X_List, Y_List).
% mode(---) ?- cons(X,Y,Z); Y = nil, Z = snoc(nil,X)
% mode(+++) ?- cons(5,snoc(snoc(nil,3),4),snoc(snoc(snoc(nil,5),3),4)); true
% mode(++-) ?- cons(5,snoc(snoc(nil,3),4),X); X = snoc(snoc(snoc(nil,5),3),4)
% mode(+-+) ?- cons(5,X,snoc(snoc(snoc(nil,5),3),4)); X = snoc(snoc(nil,3),4)
% mode(-++) ?- cons(X,snoc(snoc(nil,3),4),snoc(snoc(snoc(nil,5),3),4)); X = 5
% mode(--+) ?- cons(X,Y,snoc(snoc(snoc(nil,5),3),4)); X = 5, Y = snoc(snoc(nil,3),4)

toBList([], nil). 
toBList([X|Xs], Out) :- toBList(Xs, Ys), 
                        cons(X, Ys, Out).
% mode(--) ?- toBList(X,Y); X = [], Y = nil
% mode(++) ?- toBList([1,2,3],snoc(snoc(snoc(nil,1),2),3)); true
% mode(+-) ?- toBList([1,2,3],X); X = snoc(snoc(snoc(nil,1),2),3)
% mode(-+) ?- toBList(X,snoc(snoc(snoc(nil,1),2),3)); X = [1, 2, 3]

snoc([], N, [N]). 
snoc([X|Xs], N, [X|Out]) :- snoc(Xs, N, Out).
% mode(---) ?- snoc(X,Y,Z); X = [], Z = [Y]
% mode(+++) ?- snoc([1,2,3],4,[1,2,3,4]); true
% mode(++-) ?- snoc([1,2,3],4,X); X = [1, 2, 3, 4]
% mode(+-+) ?- snoc([1,2,3],X,[1,2,3,4]); X = 4
% mode(-++) ?- snoc(X,4,[1,2,3,4]); X = [1, 2, 3]
% mode(+--) ?- snoc([1,2,3],X,Y); Y = [1, 2, 3, X]
% mode(-+-) ?- snoc(X,4,Y); X = [], Y = [4]
% mode(--+) ?- snoc(X,Y,[1,2,3,4]); X = [1, 2, 3], Y = 4

fromBList(nil, []).
fromBList(snoc(X_List, X), Out) :- fromBList(X_List, Y_List), 
                                   snoc(Y_List, X, Out). 
% mode(--) ?- fromBList(X,Y); X = nil, Y = []
% mode(++) ?- fromBList(snoc(snoc(snoc(nil,1),2),3),[1,2,3]); true
% mode(+-) ?- fromBList(snoc(snoc(snoc(nil,1),2),3),X); X = [1, 2, 3]
% mode(-+) ?- fromBList(X,[1,2,3]); X = snoc(snoc(snoc(nil,1),2),3)


% 3. A binary tree data structure
num_empties(empty, 1). 
num_empties(node(_, T1, T2), Out) :- num_empties(T1, Sum1), 
                                     num_empties(T2, Sum2), Out is Sum1 + Sum2.
% mode(--) ?- num_empties(X,Y); X = empty, Y = 1
% mode(++) ?- num_empties(node(1,node(2,empty,empty),empty),3); true
% mode(+-) ?- num_empties(node(1,node(2,empty,empty),empty),X); X = 3

num_nodes(empty, 0). 
num_nodes(node(_, T1, T2), Out) :- num_nodes(T1, Sum1), 
                                   num_nodes(T2, Sum2), Out is 1 + Sum1 + Sum2. 
% mode(--) ?- num_nodes(X,Y); X = empty, Y = 0
% mode(++) ?- num_nodes(node(1,node(2,empty,empty),empty),2); true
% mode(+-) ?- num_nodes(node(1,node(2,empty,empty),empty),X); X = 2

insert_left(N, empty, node(N, empty, empty)). 
insert_left(N, node(A, T1, T2), node(A, T1_1, T2)) :- insert_left(N, T1, T1_1).
% mode(---) ?- insert_left(X,Y,Z); Y = empty, Z = node(X,empty,empty)
% mode(+++) ?- insert_left(3,node(1,node(2,empty,empty),empty),node(1,node(2,node(3,empty,empty),empty),empty)); true
% mode(++-) ?- insert_left(3,node(1,node(2,empty,empty),empty),X); X = node(1,node(2,node(3,empty,empty),empty),empty)
% mode(+-+) ?- insert_left(3,X,node(1,node(2,node(3,empty,empty),empty),empty)); X = node(1,node(2,empty,empty),empty)
% mode(-++) ?- insert_left(X,node(1,node(2,empty,empty),empty),node(1,node(2,node(3,empty,empty),empty),empty)); X = 3
% mode(+--) ?- insert_left(3,X,Y); X = empty, Y = node(3,empty,empty)
% mode(-+-) ?- insert_left(X,node(1,node(2,empty,empty),empty),Y); Y = node(1,node(2,node(X,empty,empty),empty),empty)
% mode(--+) ?- insert_left(X,Y,node(1,node(2,node(3,empty,empty),empty),empty)); X = 3, Y = node(1,node(2,empty,empty),empty)

insert_right(N, empty, node(N, empty, empty)). 
insert_right(N, node(A, T1, T2), node(A, T1, T2_1)) :- insert_right(N, T2, T2_1). 
% mode(---) ?- insert_right(X,Y,Z); Y = empty, Z = node(X,empty,empty)
% mode(+++) ?- insert_right(3,node(1,node(2,empty,empty),empty),node(1,node(2,empty,empty),node(3,empty,empty))); true
% mode(++-) ?- insert_right(3,node(1,node(2,empty,empty),empty),X); X = node(1,node(2,empty,empty),node(3,empty,empty))
% mode(+-+) ?- insert_right(3,X,node(1,node(2,empty,empty),node(3,empty,empty))); X = node(1,node(2,empty,empty),empty)
% mode(-++) ?- insert_right(X,node(1,node(2,empty,empty),empty),node(1,node(2,empty,empty),node(3,empty,empty))); X = 3
% mode(+--) ?- insert_right(3,X,Y); X = empty, Y = node(3,empty,empty)
% mode(-+-) ?- insert_right(X,node(1,node(2,empty,empty),empty),Y); Y = node(1,node(2,empty,empty),node(X,empty,empty))
% mode(--+) ?- insert_right(X,Y,node(1,node(2,empty,empty),node(3,empty,empty))); X = 3, Y = node(1,node(2,empty,empty),empty)

sum_nodes(empty, 0). 
sum_nodes(node(N, T1, T2), Out) :- sum_nodes(T1, Sum1), 
                                   sum_nodes(T2, Sum2), Out is N + Sum1 + Sum2. 
% mode(--) ?- sum_nodes(X,Y); X = empty, Y = 0
% mode(++) ?- sum_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),6); true
% mode(+-) ?- sum_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),X); X = 6

inorder(empty, []). 
inorder(node(N, T1, T2), Out) :- inorder(T1, Order1), 
                                 inorder(T2, Order2), 
                                 append(Order1, [N|Order2], Out).
% mode(--) ?- inorder(X,Y); X = empty, Y = []
% mode(++) ?- inorder(node(1,node(2,empty,empty),node(3,empty,empty)),[2,1,3]); true
% mode(+-) ?- inorder(node(1,node(2,empty,empty),node(3,empty,empty)),X); X = [2, 1, 3]
% mode(-+) ?- inorder(X,[2,1,3]); X = node(2,empty,node(1,empty,node(3,empty,empty)))

num_elts(leaf(_), 1). 
num_elts(node2(_, T1, T2), Out) :- num_elts(T1, Sum1),
                                  num_elts(T2, Sum2),
                                  Out is 1 + Sum1 + Sum2. 
% mode(++) ?- num_elts(node2(1,leaf(2),leaf(3)),3); true
% mode(+-) ?- num_elts(node2(1,leaf(2),leaf(3)),X); X = 3

sum_nodes2(leaf(N), N). 
sum_nodes2(node2(N, T1, T2), Out) :- sum_nodes2(T1, Sum1),
                                    sum_nodes2(T2, Sum2), 
                                    Out is N + Sum1 + Sum2. 
% mode(--) ?- sum_nodes2(X,Y); X = leaf(Y)
% mode(++) ?- sum_nodes2(node2(1,leaf(2),leaf(3)),6); true
% mode(+-) ?- sum_nodes2(node2(1,leaf(2),leaf(3)),X); X = 6
% mode(-+) ?- sum_nodes2(X,6); X = leaf(6)

inorder2(leaf(N), [N]).
inorder2(node2(N, T1, T2), Out) :- inorder2(T1, Order1), 
                                  inorder2(T2, Order2), 
                                  append(Order1, [N|Order2], Out).
% mode(++) ?- inorder2(node2(1,leaf(2),leaf(3)),[2,1,3]); true
% mode(+-) ?- inorder2(node2(1,leaf(2),leaf(3)),Y); Y = [2, 1, 3]
% mode(-+) ?- inorder2(X,[2,1,3]); X = node2(1,leaf(2),leaf(3))

conv21(leaf(N), node(N, empty, empty)).
conv21(node2(N, T1, T2), node(N, T1_1, T2_1)) :- conv21(T1, T1_1), 
                                                 conv21(T2, T2_1).
% mode(++) ?- conv21(node2(1,leaf(2),leaf(3)),node(1,node(2,empty,empty),node(3,empty,empty))); true
% mode(+-) ?- conv21(node2(1,leaf(2),leaf(3)),X); X = node(1,node(2,empty,empty),node(3,empty,empty))
% mode(-+) ?- conv21(X,node(1,node(2,empty,empty),node(3,empty,empty))); X = node2(1,leaf(2),leaf(3))


% ---- Part 2: Iteration and Accumulators ----------------

toBList_it(Xs, Out) :- go_toBList(Xs, nil, Out).
go_toBList([], X_List, X_List).
go_toBList([X|Xs], X_List, Out) :- X_X_List = snoc(X_List, X),
    						       go_toBList(Xs, X_X_List, Out).
%mode (+,-)
% ?- toBList_it([1,2],O)

fromBlist_it(X_List, Out) :- go_fromBList(X_List, [], Out).
go_fromBlist(nil, Xs, Xs).
go_fromBlist(snoc(X_List, X), Xs, Out) :- go_fromBlist(X_List, [X|Xs], Out).
%mode (+,-)
% ?- fromBlist(snoc(snoc(snoc(nil,4),5),6),O)

sum_nodes_it(T1, Out) :- go_sum_nodes(T1, 0, Out).
go_sum_nodes([], Sum, Sum).
go_sum_nodes([empty|Ts], Sum, Out) :- go_sum_nodes(Ts, Sum, Out).
go_sum_nodes([node(N, T1, T2)|Ts], Sum, Out) :- Sum_1 is N + Sum,
                                                go_sum_nodes([T1,T2|Ts], Sum_1, Out).
%------


num_empties_it(T, Out) :- go_num_empties([T], 0, Out).
go_num_empties([], Count, Count).
go_num_empties([empty|Ts], Count, Out) :- Counter is Count+1, 
                                          go_num_empties(Ts, Counter, Out).
go_num_empties([node(_, T1, T2)|Ts], Count, Out) :- go_num_empties([T1,T2|Ts], Count, Out).
%mode (+,-)
% ?- num_empties_it((node(2,empty,empty)),Out)

num_nodes_it(T, Out) :- go_num_nodes_it([T], 0, Out).
go_num_nodes_it([], Count, Count).
go_num_nodes_it([empty|Ts], Count, Out) :- go_num_nodes_it(Ts, Count, Out).
go_num_nodes_it([node(_, T1, T2)|Ts], _, Out) :- Counter is _+1, 
                                                 go_num_nodes_it([T1,T2|Ts], Counter, Out).
%mode (+,-)
% ?- num_nodes((node(2,empty,empty)),Out)                                                 num_nodes_it_H(Ts, AP, Out1).                      

sum_nodes2_it(T, Out) :- go_sum_nodes2_it([T], 0, Out).
go_sum_nodes2_it([], Sum, Sum). 
go_sum_nodes2_it([leaf(Value)|Ts], Sum, Out) :- Sum_1 is Sum + Value, 
                                                go_sum_nodes2_it(Ts, Sum_1, Out).
go_sum_nodes2_it([node2(Value, T1, T2)|Ts], Sum, Out) :- Sum_1 is Sum + Value, 
                                                go_sum_nodes2_it([T1,T2|Ts], Sum_1, Out).
%mode (+,-)
% ? - sum_nodes2(leaf(2),X)
% X = 2
%mode (-,+)
% ? - sum_nodes2(X,2)
% X = leaf(2)

inorder2_it(T, Out) :- go_inorder2_it([T], [], Out).
go_inorder2_it([], Order1, Order1).
go_inorder2_it([leaf(Value)], List, [Value|List]).
go_inorder2_it([node2(Value, T1, T2)], List, Out) :- go_inorder2_it(T1, (Value|go_inorder2_it(T2, List, Out), Out)).
%mode (+,-)
% ?- inorder2_it_H([node(X,L,R)|Ts],A,X)             


% ---- Part 4: Extra Credit ----------------

bst(T) :- go_bst(T, -(inf), inf).             
go_bst(empty, _, _).
go_bst(node(N, T1, T2), Low, High) :- Low < N, N < High,
                                      go_bst(T1, Low, N),
                                      go_bst(T2, N, High).          
% mode(-) ?- bst(X); X = empty
% mode(+) ?- bst(node(1,empty,node(2,empty,node(3,empty,node(4,empty,node(5,empty,node(6,empty,empty))))))); true
% mode(+) ?- bst(node(9,empty,node(7,empty,node(8,empty,node(4,empty,node(5,empty,node(6,empty,empty))))))); false

%node((11, empty, node(12, empty, empty)), O).
%bst2(leaf(N), true).
bst2(T) :- go_bst2(T, -(inf), inf).
go_bst2(leaf(N), Low, High) :- Low < N, N > High.             
go_bst2(node2(N, T1, T2), Low, High) :- Low < N, N < High,
                                       go_bst2(T1, Low, N), 
                                       go_bst2(T2, N, High).
%mode(+,-)
% ?- bst2 node(10,node(8,empty,node(9,empty,empty)),

%bst2(node2(2,leaf(1),node2(4,leaf(3),leaf(5))))