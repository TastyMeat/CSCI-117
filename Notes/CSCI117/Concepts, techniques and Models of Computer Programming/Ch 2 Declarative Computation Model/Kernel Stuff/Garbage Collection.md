memory reclaiming done by system, no dangling reference, less memory leak

while garbage collector runs, the program does not fullfill its tasks (pausing)
other type of garbage collector: real-time garbage collector, used in hard real-time programming

##### garbage collector has 2 phases:
1) determines what the active memory is
	- finds all data structures starting from *root set* (initial set of pointers)
	- currently root set refers to semantic stack, but has other properties
2) compacts memory
	- collects all active memory into 1 big block
	- collecrs all free memory into 1 big block
##### 2 cases that is the developers responsibility:
1) **avoiding memory leaks**
	- if program keeps referencing a data structure that it does not need, the data structures memory cant be recovered
	```
	Program with memory leak:
	
	L=[1 2 3 ... 1000000]
		fun {Sum X L1 L}  
		case L1 of Y|L2 then {Sum X+Y L2 L} else X end
	end
	{Browse {Sum 0 L L}}
	```
	- still referencing L even though it is not needed
	```
	Program with no memory leak:
	
	L=[1 2 3 ... 1000000]
		fun {Sum X L1}  
		case L1 of Y|L2 then {Sum X+Y L2} else X end
	end
	{Browse {Sum 0 L}}
	```
	- reference to L is removed

2) **managing external resources**
	- program might need data structures that are external or vice versa
	- 2 situation: 
		- **data structures needs external resources**
			- using *finalization* 
		- **external resources need data structures**
			- proxy, create its own thread. Keeps a reference of the data structure as long as it is needed

##### Mozart's Garbage Collector
- has local and distributed garbage collector
- uses copying dual space algorithm
	- splits in half and utilizes it when there are no free memory in there, copies all root set to other half
- more on pg 79-80