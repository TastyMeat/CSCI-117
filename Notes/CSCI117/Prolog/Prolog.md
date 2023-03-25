***Pro***gramming in ***Log***ic

Data = Terms
Terms = Arguments, Fields

##### Predicates
`f(term,term,term), 'arity' of functor f is 3`
- f = functor
- similar to records

##### How to read
- contrast(C1, C2) :- soft(C1), hard(C2)
- C1 and C2 are contrast id C1 is soft and C2 is hard
###### example1:
	soft(beige)
	soft(coral)
	hard(mauve)
	hard(ocre)
	contrast(C1, C2) :- soft(C1), hard(C2)
	contrast(C1, C2) :- hard(C1), soft(C2)
	suit(suit(Shirt, Pants, Socks)):-
		contrast(Shirt, Pants)
		contrast(Pants, Shirt)
		Shirt = != Socks
###### example2:
	append([], Ys, Ys).
	append([X|Xr], Ys, [X|Out])
		append[Xr, Ys, Out])