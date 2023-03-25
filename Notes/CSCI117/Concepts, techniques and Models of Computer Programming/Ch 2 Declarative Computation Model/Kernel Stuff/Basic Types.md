1) **Numbers: (int/ float)**
	- ex: 1, ~1.1

2) **Atoms: (symbolic constant, can also be printable enclosed with '')**
	- ex: atom, 'atom'

3) **Booleans: (true/ false)**
	- ex: true, false

4) **Records: (compound data structure, has label, a pair of features and variable identifier )**
	- features = atoms, ints, bools
	- ex: person(age:X1 name:X2)
	- feature = age, name

5) **Tuples: (basically records but features are int)**
	- ex: person(1:X1 2:X2)/ person(X1 X2)

6) **Lists: (either atom nil or tuple '|'(H T))**
	- T can be bound/ unbound to another list
	- associates to the right, lists that end with nil can be written with [...]
	- ex: 1| 2| 3| nil =   1|(2|(3|nil))

7) **Strings: (list of character codes)**
	- ex: "E=mcˆ2" = [69 61 109 99 94 50]

8) **Procedures: (a value of the procedure type)**
	- `⟨x⟩=proc {$ ⟨y⟩1 ... ⟨y⟩n } ⟨s⟩ end` 
		- `<x>` bound to a new procedure value
		- $ means that the proc value is anonymous
	- `proc { ⟨x⟩ ⟨y⟩1 ... ⟨y⟩n } ⟨s⟩ end`
		- `<x>` is immediately bound
		- the second is a syntactic sugar shortcut