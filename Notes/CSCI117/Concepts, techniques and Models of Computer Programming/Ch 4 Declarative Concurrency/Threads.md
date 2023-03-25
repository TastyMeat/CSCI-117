##### Idea:
[[Data Driven Concurrency]]
##### Syntax: 
	thread "<s1>..<sn>" end

##### Characteristics:
Multiple stacks/ threads will share the same Single Assignment Store(Memory)
##### Types:
[[Quantum Scheduling]]
##### Problems: 
1) Thread will stop when it hits a suspendable statement (data dependent statements)
2) Thread will stop when it hits an error
3) Deadlock will occur when Threads do not progress after 1 cycle of execution
