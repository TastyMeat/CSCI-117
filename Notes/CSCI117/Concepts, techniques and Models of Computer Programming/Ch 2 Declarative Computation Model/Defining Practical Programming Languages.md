Toolbox for experienced mechanic, all of the tools are purposefully made and are unique
- Syntax = grammar
- Semantics = meaning
- Statement = sentences
- Tokens = words

##### Syntax
Defines what are the legal programs that are executable
- **Grammar**
	- statement = sequence of tokens
	- token = sequence of char
	- Context Free Grammar (With Extended Backus Naur Form)
		- easy to read and understand
		- defines a superset of the language
	- Set of extra condition
		- makes grammar
- **Ambiguity**
	- Use Precedence and associativity to solve ambiguity
		- Precedence: expression1 **binds tighter** than expression2
			- ` ex: * > +`
			- `res: (1*2)+3`
		- Associativity: expression associativity is **Direction** it binds to that **Direction** first
			- `ex: + binds right`
			- `res: 1+(2+3)`
- Rule
	- no other rules will invalidate the grammar creaeted
	- partial definition end with ...
##### Language Semantics
Defines what a program does when it executes, it should be defined in a simple mathematical structure that lets us reason about the program(correctness, execution time, memory use)
Using [[Kernel Language Approach]] helps provide a solution
![[kernel language approach to semantics.png]]
There are 4 [[Formal Semantics]] but the first will only be used by programmers normally
The 2 types of language translation found in the [[Kernel Language Approach]]
In language design, we would first define it then if we find it to be useful we would give it linguistic support(linguistic abstraction), if it is succesfull  it becomes part of the language
There are also 2 [[Other Translation Approach]] asside from the [[Kernel Language Approach]]
An alternative to the translation approach is the [[Interpreter Approach]]
