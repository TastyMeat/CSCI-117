same as static scoping
declaration is in some statement (part of ⟨s⟩ or not) that textually surrounds (i.e., encloses) the occurrence
Identifiers can be 2 types:
1. bound: with respect to a statement ⟨s⟩ if it is declared inside ⟨s⟩
	1. textual reference (reference to a variable name) to a variable name declared within a certain construct
	2. ex: in local statement, in case statement, or as argument of a procedure declaration
3. free: statements cannot run, is in incomplete program  
Bound identifier != Bound variable
- bound identifier does not exist in runtime
- bound variable is a dataflow variable

**program1** (unable to run)
```
local Arg1 Arg2 in 
	Arg1=111*111 
	Arg2=999*999 
	Res=Arg1+Arg2
end
```
- since Res is a free identifier, Arg1 and Arg2 are bound identifiers

**program2** (able to run)
```
local Res in  
	local Arg1 Arg2 in
	         Arg1=111*111
	         Arg2=999*999
	         Res=Arg1+Arg2	
	end
	{Browse Res}
end
```
