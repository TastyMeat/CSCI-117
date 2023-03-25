##### Data Driven Kernel Language
![[data driven kernel language.png]]
First step is to add threads make it a data driven concurrent model.
Second, add *triggers* ex: {ByNeed P X}, to make it demand-driven or [[Class Notes - Lazy Execution]]

##### Basic Concepts
Allowing more than 1 executing statement to reference the store. 
"statements are executing at the same time"
- **Interleaving**
	- What is Interleaving ("at the same time")
	- Language Viewpoint:
		- Letting threads do interleaving execution
		- Take turns doing computation
		- It does not overlap, it is atomic
	- Implementation Viewpoint:
		- How multiple threads are implemented on hardware
		- If done on a single processor interleaving is possible
		- If done on multiple processor parallelism, working simultaneously is possible

- **Causal Order**
	- Computation steps, 
	- In a sequential program computation steps are ordered
	- In a concurrent program computation steps of a **THREAD** are ordered

![[casual order of sequential and concurrent executions.png]]

- **Nondeterminism**
	- An execution steps where there is an choice on what to do next
	- `ex: which thread to execute`

- **Scheduling**
	- Scheduler chooses which step to execute next
		-  it only chooses steps that are runnable
		- all information is ready in that statement to execute at least 1 step
	- Threads that are not ready are *suspended*
	- System is fair when all ready threads are executed eventually

