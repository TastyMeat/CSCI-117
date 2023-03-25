##### 2.4.1, 2.4.5 Basic Concepts
- **simple execution**
	```
	local A B C D in A=11
	  B=2
	  C=A+B
	  D=C*C
	end
	```
	- creates 4 local identidiers and
	- creates 4 new variable in store
- **variable identifiers and static scoping**
	```
	local X in        //statement start, first scope start
		X=1
		local X in       //statement 1 start, second scope start
			X=2
			{Browse X}
		end              //statement 1 end, second scope end
		{Browse X}             //statement 2
	end.             //statement end, first scope end
	```
	- static scoping/ [[Lexical Scoping]], is how you are able to easily see the scope of a variable
	- [[What is happening in variable identifiers and static scoping]]
		
- **procedures**
	```
	proc {Max X Y ?Z}  
		//unidentified identifiers/ free identifiers
		//does not work outside of proc
		if X>=Y then Z=X else Z=Y end 
	end
	
	run: {Max 3 5 C}
	C: 5
	```
	- note: `?` is not present in hoz
	- passing parameters using *call by reference* 
	- Procedures output results by being passed references to unbound variables, which are bound inside the procedure
	- [[What is happening in procedures]]
- **procedures with external references**
	```
	local Y LB in 
		Y=10
		proc {LB X ?Z}  
			if X>=Y then Z=X else Z=Y end
		end  
		local Y=15 Z in   //Y=15 ignored
			{LB 5 Z}
		end 
	end
	```
	- Y=15 is ignored because the binding on procedure decleration is the one that is important
- **dynamic vs static scoping**
	```
	local P Q in  //P definition
		proc {Q X} {Browse stat(X)} end 
		proc {P X} {Q X} end  
		local Q in
			proc {Q X} {Browse dyn(X)} end
			{P hello}  //P call
		end 
	end
	```
	- static scoping: stat(hello)
		- uses Q that exists in P's definition
	- dynamic scoping: dyn(hello)
		- uses Q that exists in P's call
		- ex: using libraries
- **procedural abstraction**
	- [[procedural abstraction definitions]]
- **dataflow behavior**
	- variables that are unbound but need to be used will cause the program to stop its execution

##### 2.4.2 Abstract Machine
- **Single Assignment Store**
	- partitioned into
		1) sets of variables that are equal but unbound
		2) variables that are bound to a number, record, procedure
- **Environment**
	- mapping to variable identifiers to store entities 
- **Semantic Statement**
	- (`<s>`,E), `<s>` is statement, E is environment
	- relates to a statement it references in the store
- **Statement Stack**
- **Execution State**
	- (ST, SAS), ST is a stack of *semantic statement* (Semantic Stack), SAS is *single assignment store*
	- ![[execution state.png]]
- **Computation**
	- sequence of execution states
	- (ST0, SAS0) -> (ST1, SAS1)
	- computation step
		- Atomic = step is done all at once
	- squential = all execution state contains only 1 statement stack

- **Program Execution**
	- program = statement
	- initial execution state: `([(⟨s⟩, φ)], φ)`
	- `(⟨s⟩, φ)` is semantic statement, `φ` is empty environment, `[]` is stack (ST)
		- each step ST is popped and proceeds
		- final execution state is semantic stack empty
	- 3 runtime states for semantic stack ST
		- runnable: can do computation step
		- terminated: empty
		- suspended: not empty, but cant do computation step

- **Calculating With Environments**
	- an environment E that maps variable identifiers `<x>` to store entities (unbound var, val)
	- E`<x>` retrieves entity associated with identifier `<x>` in store
	- 2 operations
		- adjunctions
			- new environment, adds mapping to existing one
			- `E′(⟨x⟩) = E + {⟨x⟩ → x}`  (``E′(X) = E + {⟨X → x}``)
				- `E′(⟨x⟩)` = x
		- restriction
			- new environment, domain is a subset of an existing one

##### 2.4.3 Non-Suspendable Statements
[[Types of Non-Suspendable Statements]]
[[Lexical Scoping]]
[[Closures(Procedure Values)]]

##### 2.4.4 Suspendable Statements
[[Types of Suspendable Statements]]

##### 2.4.6 Last Call Optimization
last call in procedure body is recursive (tail recursive)
- efficient way to program loop in declerative model (invoking in the last call)
```
proc {Loop10 I}  
	if I==10 then skip 
	else
		{Browse I}
		{Loop10 I+1}
	end 
end
```
[[What is happening in Last Call Optimization]]

##### 2.4.7 Active Memory and Memory Management
- semantic stack is bounded by constant size, store grows
- semantic stack and reachable parts of the store is *active memory*
- ![[memory block life cycle.png]]
- [[Memory Use Cycle]]
- [[Garbage Collection]]