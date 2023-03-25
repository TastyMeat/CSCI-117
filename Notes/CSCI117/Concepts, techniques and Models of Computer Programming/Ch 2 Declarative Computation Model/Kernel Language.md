##### Syntax
a subset and valid statements of the full language syntax

- Statement Syntax
	- eight `<s>`  statements in total
	- ![[declerative kernel language.png]]
 - Variable Identifier Syntax
	 - uses nonterminals `<x>`, `<y>`, `<z>` to denote variable identifier
	 - all new variable are unbound before any statement is executed
	 - VI must be declared explicitly
	 - 2 ways of writing variable identifier:
		 1) uppercase letter followed by zero or more alphanumeric characters
		 2) printable char must be enclosed with ``
 -  Value Syntax
	 - `<v>` value, there are 3 kinds:
		 1) numbers
		 2) records (a rguments must all be distinct identifiers)
		 3) procedures
 - ![[value expression in DKL.png]]
##### Values and Types
set of alues together = type/ data type
The 3 basic properties of types and values:
1) [[Basic Types]]
	- numbers (integers and floats), records (atoms, booleans, tuples, lists, and strings), and procedures
1) Dynamic typing
	- 2 basic approaches
		1) dynamic typing: variable type is known only when bound
		2) static typing: all variable are known at compile time
1) Type hierarchy
	- ![[type hierarchy.png]]
	- ordered by set inclusion, all children are also the parents value
	- ex: all list are tuple, all tuple are records
	- all operations on the parents are usable for the children
##### Basic Types
there are 8 [[Basic Types]]

##### Records and Procedures
- **Records**
	- Building Blocks for data structures: lists, queues, trees, etc
	- Records are a key building block for
		1) Object Oriented Programming
			- record represent messages and method heads that are used by objects to communicate
		2) Graphical User Interface Design
			- record represent "widgets" that are the basic building blocks of UI
		3) Component Based Programming
			- record represent modules, which group together related operations.

- **Procedures**
	- Advantages:
		- Flexible, doesnt make assumptions about the number of inputs/ outputs
		- Can have any number of inputs and outputs
			- ex: Functions only has 1 output
		- Simpler than objects

##### Basic Operations
- ![[basic operations.png]]
- syntactic sugar will be utilized for many of the basic operations
- ex: {Number. '`*`' A B X} is X = A * B 
	- Number. '`*`' is a procedure**
- other ex: Value. '==' ,    Value. '<',    Int. 'div',    Float. '/'

- **Brief Summary of the operations**
	1) Arithmetic
		- floating point has: `+, -, *, /`
		- integer has: `+, -, *, div, mod`
			- div truncates the fractional parts
			- mod returns the remainder
	2) Record Operations
		- 3 basic operations: `Arity, Label, "."`
		- Arity: Integer > Atom
		- ex: X=person(name:"George" age:25)
			- {Arity X}=[age name]
			- {Label X}=person
			- X.age=25
	3) Comparisons
		- boolean comparison: `==, \=`
			- compares for equality
		- numeric comparison: `=<, <, >=, >`
			- for integer, floats, atoms
			- atoms are compared to the lexicographic order of their print representation
	4) Procedure Operations
		- 3 basic operations: `proc, {}, IsProcedure`
			- `proc` defines it
			- `{}` calls it
			- `IsProcedure` test if the value is procedure
				- if it is, return true else false

[[Kernel Language Semantics]]
[[Kernel to Practical Language]]