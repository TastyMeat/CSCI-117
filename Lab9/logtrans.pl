determiner([every|X], X, Subject, Predicate, RelativeClause, all(Subject, imply(RelativeClause, Predicate))).
determiner([a|X], X, Subject, Predicate, RelativeClause, exists(Subject, and(RelativeClause, Predicate))).

noun([man|X], X, Subject, man(Subject)).
noun([woman|X], X, Subject, woman(Subject)). 
noun([child|X], X, Subject, child(Subject)).

name([john|X], X, john).
name([mary|X], X, mary).
name([marcus|X], X, marcus).
name([isaac|X], X, isaac).

transverb([loves|X], X, Subject, Object, loves(Subject, Object)).
transverb([knows|X], X, Subject, Object, knows(Subject, Object)).

intransverb([lives|X], X, Subject, lives(Subject)).
intransverb([runs|X], X, Subject, runs(Subject)).

sentence(X0, X, Sentence):-
    nounphrase(X0, X1, Subject, VerbPhrase, Sentence),
    verbphrase(X1, X, Subject, VerbPhrase).

nounphrase(X0, X, Subject, Predicate, Phrase):-
    determiner(X0, X1, Subject, Predicate, RelativeClause, Phrase),
    noun(X1, X2, Subject, Noun),
    relclause(X2, X, Subject, Noun, RelativeClause). 
nounphrase(X0, X, Name, Phrase, Phrase):- 
    name(X0, X, Name). 

verbphrase(X0, X, Subject, VerbPhrase):-
    transverb(X0, X1, Subject, Object, Predicate),
    nounphrase(X1, X, Object, Predicate, VerbPhrase).
verbphrase(X0, X, Subject, VerbPhrase):-
    intransverb(X0, X, Subject, VerbPhrase).

relclause([who|X1], X, Subject, Premise, and(Subject, VerbPhrase)):-
    verbphrase(X1, X, Subject, VerbPhrase).
relclause([who|X1], X, Subject, Premise, and(Subject, ReverseVerbPhrase)):-
    nounphrase(X1, X2, Subject, Predicate, ReverseVerbPhrase),
    transverb(X2, X, Subject2, Subject, Predicate).
relclause(X, X, _, Phrase, Phrase).

