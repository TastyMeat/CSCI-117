Set of variables that can only be bound to one value
- **Declarative Variables** are variables in the single assignment store
- **Value Store** is a store where all variables are bound
	- used by functional languages
	- a persistent mapping from var -> val
	- OOP languages uses cell store (able to be modified)

- Reasons for using SAS
	1) compute partial values
		- procs can return an output by binding an unbound variable argument
	2) [[Declarative Concurrency]]
	3) Essential when extending model for relational (logic) & constraint programming
	4) Efficiency
		- tail recursion
		- difference list

- **Value Creation**(in store)
	- x = value
	- x is a variable in the store, not the variables textual name
	- some variable that you assign to a value in the store 
- **Variable Identifiers**(outside store)
	- a textual name that refers to a store entity(value) from outside
	 ![[variable identifier.png]]
 - **Value Creation with identifiers**(outside -> inside)
	 - How a programmer would write
	 - dereferencing = following the links of bound variables to get the value
	 - some variable identifier that assigns itself to another variable in the store that references to a value
 - **Variable-variable binding**
	 - a variable binding to another variable
	 - ![[variable-variable binding.png]]
 - **Dataflow Variables**
	 - Declerative variables that cause program to wait until they are bound
	 - Useful for concurrent programming([[Declarative Concurrency]])
	 - Variable Use Error possibilities(1-4, 1 very bad, 4 less bad)
		 1) execution continues, undefined garbage (C++)
		 2) execution continues, but initialized to default ex: 0 (Java)
		 3) execution stops with error message/ exception (Prolog arithmetic operations)
		 4) execution waits until var is bound, then continues