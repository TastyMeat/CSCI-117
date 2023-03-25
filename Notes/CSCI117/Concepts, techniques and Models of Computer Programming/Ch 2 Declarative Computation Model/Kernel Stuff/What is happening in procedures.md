![[procedure (non syntactic sugar).png]]
- >1 variable in local decleration creates a nested local decleration
- in-line values are just shortcut
	- `{ P 3 } == local X in X=3 {P X} end`
- nested operations
	- `if X>=Y`
1. initial same as [[What is happening in variable identifiers and static scoping]]
2. after 4 local 
	- `( [(⟨s⟩1,{Max→ m,A→ a,B→ b,C→ c})], {m,a,b,c} )`
	- environment `⟨s⟩1` maps to m, a, b, c in store
3. after bind Max, A, B
	- `( [({Max A B C},{Max→ m,A→ a,B→ b,C→ c})], {m=(proc{$XYZ}⟨s⟩3 end, φ), a=3,b=5,c})`
	- contextual environment Max is empty (no free identifiers), m, a, b are bound
4. executing procedure
	- `( [(⟨s⟩3,{X→a,Y→b,Z→c})], {m=(proc{$XYZ}⟨s⟩3 end, φ),a=3,b=5,c} )`
	- `⟨s⟩3` environment has X,Y,Z mappings
5. after executing X>=Y
	-  `( [(⟨s⟩4,{X→ a,Y→ b,Z→ c,T→ t})], {m = (proc {$ X Y Z}⟨s⟩3 end, φ),a = 3,b = 5,c,t =false} )`
	- creates identifier T and variable t bound to *false*
6. after `⟨s⟩4`
	- `([],{m=(proc{$XYZ}⟨s⟩3end, φ),a=3,b=5,c=5,t=false})`
	- c bound to 5, statement stack empty