1. initial execution state
	- `( [({Loop10 0}, E0 )], σ)`
2. executing if
	- `( [({Browse I}, {I→ i0}) ({Loop10 I+1}, {I → i0})], {i0 = 0} ∪ σ )`
3. executing Browse, reaches recursive call
	- `( [({Loop10 I+1}, {I → i0})], {i0 = 0} ∪ σ )`
4. executing if 
	- `([({Browse I},{I→ i1}) ({Loop10 I+1},{I→ i1})], {i0= 0,i1= 1}∪ σ)`
5. Nth recursive call
	- `[({Loop10 I+1}, {I → iN−1})]`
	- 