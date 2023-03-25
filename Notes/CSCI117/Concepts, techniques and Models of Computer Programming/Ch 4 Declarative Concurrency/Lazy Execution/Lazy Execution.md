Statement only executed when needed
lazy functions will create "stopped execution" ()
```
	fun lazy {F1 X} 1+X*(3+X*(3+X)) end
	fun lazy {F2 X} Y=X*X in Y*Y end
	fun lazy {F3 X} (X+1)*(X+1) end
	A={F1 10}
	B={F2 20}
	C={F3 30}
	D=A+B
```
- C is never needed so it will not run

Trigger Creation: `{ByNeed ⟨x⟩ ⟨y⟩}`

##### Demand Driven Concurrent Model
[[By-need Trigger]]

