 - **skip**
	- semantic statement: `(skip, E)`
	- execution complete after pair is popped from semantic stack
- **sequential composition**
	- semantic statement: `(⟨s⟩1 ⟨s⟩2,E)`
	- 2 following actions: (push `(⟨s⟩2,E)`)**->**  (push `(⟨s⟩1,E)` onto stack)
- **variable decleration (local statement)**
	- semantic statement: `(local ⟨x⟩ in ⟨s⟩ end, E)`
	- 3 following actions: (create new var x in store) **->** (`LetE′ beE+{⟨x⟩→x},i.e.`, `E′` = E but with ⟨x⟩ to x mapping) **->** (Push `(⟨s⟩, E′)` on the stack)
- **variable-variable binding**
	- semantic statement: `(⟨x⟩1 =⟨x⟩2,E)`
	- following action: Bind `E(⟨x⟩1)` and `E(⟨x⟩2)` in the store.
- **value creation**
	- semantic statement: `(⟨x⟩ = ⟨v⟩, E)`
	- `⟨v⟩` partially constructed value (record, number, procedure)
	- 3 following action: (create new var x in store) **->** (construct value `<v>` in store and let x reference it, store contents in E *replaces* identifiers in `<v>`)  **->** (bind `E(⟨x⟩)` and x in store)

- **d**
	- semantic statement
	- x