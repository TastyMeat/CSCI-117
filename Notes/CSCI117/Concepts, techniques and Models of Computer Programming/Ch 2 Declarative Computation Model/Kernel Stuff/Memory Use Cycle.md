Memory is just blocks of words that stores language entities and the blocks will cycle throught the 3 states (Active, Inactive, Free)
##### Determining if memory is needed      (ex: Loop10)
- if determined directly, deallocates memory(free again) 
	- happens in memory managing control flow (Semantic Stack)
- if cannot determine directly, becomes **Inactive** (not reachable by program)
	- happens in memory used for data structure (Store) 

##### Inactive memory must be reclaimed or else 2 types of error would occur:
1) Dangling Reference
	- block reclaimed when still reachable, data structures corrupts
	- hard to debug, the error is far away from the cause
1) Memory Leak
	- when unreachable block is considered reachable (memory not reclaimed)
	- memory grows till resources exhausted, runs for some time until forced to stop(error)
