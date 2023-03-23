-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
--import Queue1
import Queue2
import Fraction

---------------- Part 1: Queue client

-- Queue operations (A = add, R = remove)
data Qops a = A a | R

-- Perform a list of queue operations on an emtpy queue,
-- returning the list of the removed elements
perf :: [Qops a] -> [a]
perf ops = go ops mtq where
    go :: [Qops a] -> Queue a -> [a]
    go [] _ = []
    go (A x : ops) queue = go ops (addq x queue)
    go (R : ops) queue = let (removedElement, updatedQueue) = remq queue in removedElement : go ops updatedQueue
    
-- Test the above functions thouroughly. For example, here is one test:
-- perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R] ---> [3,5,7,9,11]

{-
<Queue1>
ghci> perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R]
[3,5,7,9,11]
ghci> perf []
[]
ghci> perf [R]
[*** Exception: Can't remove an element from an empty queue
CallStack (from HasCallStack):
  error, called at .\Queue1.hs:24:39 in main:Queue1
ghci> perf [A 4, A 6, A 2, A 7, R, R, R, R]
[4,6,2,7]
ghci> perf [A 4, A 6, A 2, A 7, R, R, R, R, R]
[4,6,2,7,*** Exception: Can't remove an element from an empty queue
CallStack (from HasCallStack):
  error, called at .\Queue1.hs:24:39 in main:Queue1

<Queue2>
ghci> perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R]
[3,5,7,9,11]
ghci> perf []                                       
[]
ghci> perf [R]                                      
[*** Exception: Can't remove an element from an empty queue
CallStack (from HasCallStack):
  error, called at .\Queue2.hs:26:45 in main:Queue2
ghci> perf [A 4, A 6, A 2, A 7, R, R, R, R]         
[4,6,2,7]
ghci> perf [A 4, A 6, A 2, A 7, R, R, R, R, R]      
[4,6,2,7,*** Exception: Can't remove an element from an empty queue
CallStack (from HasCallStack):
  error, called at .\Queue2.hs:26:45 in main:Queue2
-}

---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr
{-
ghci> fraction 1 3
1/3
ghci> fraction 0 3
0/1
ghci> fraction 0 0
*** Exception: Illegal fraction
CallStack (from HasCallStack):
  error, called at lab3.hs:64:25 in main:Main
-}

-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average [] = error "Empty average"
average xs = sum xs * fraction 1 (fractions_length xs 0) where
    fractions_length [] count = count
    fractions_length (x:xs) count = fractions_length xs (count + 1)

-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
list3 = zipWith (+) list1 list2
list4 = [fraction n 1 | n <- [1..20]]
list5 = [fraction n (n * 2) | n <- [1..20]]
list6 = [fraction 0 n | n <- [1..20]]
-- Make up several more lists for testing


-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago

{-
The library functions can still operate on Fractions because they apply their algorithm on abstract data types
such as Show, Ord, and Num. Fraction defined its own rules on how these operations (+, *, negate, etc) are applied 
to Fractions, allowing the library functions to still carry out its operations based on the rules defined for Fractions.

<sort>
ghci> sort list1
[1/2,2/3,3/4,4/5,5/6,6/7,7/8,8/9,9/10,10/11,11/12,12/13,13/14,14/15,15/16,16/17,17/18,18/19,19/20,20/21]
ghci> sort list2
[1/20,1/19,1/18,1/17,1/16,1/15,1/14,1/13,1/12,1/11,1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1/1]
ghci> sort list3
[421/420,381/380,343/342,307/306,273/272,241/240,211/210,183/182,157/156,133/132,111/110,91/90,73/72,57/56,43/42,31/30,21/20,13/12,7/6,3/2]
ghci> sort list4
[1/1,2/1,3/1,4/1,5/1,6/1,7/1,8/1,9/1,10/1,11/1,12/1,13/1,14/1,15/1,16/1,17/1,18/1,19/1,20/1]
ghci> sort list5
[1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2]
ghci> sort list6
[0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1,0/1]

<sum>
ghci> sum list1
89778475/5173168
ghci> sum list2
55835135/15519504
ghci> sum list3
440/21
ghci> sum list4
210/1
ghci> sum list5
10/1
ghci> sum list6
0/1

<product>
ghci> product list1 
1/21
ghci> product list2
1/2432902008176640000
ghci> product list3
128335079363657015232198361/55428820724455833600000000
ghci> product list4
2432902008176640000/1
ghci> product list5
1/1048576
ghci> product list6
0/1

<maximum>
ghci> maximum list1
20/21
ghci> maximum list2
1/1
ghci> maximum list3
3/2
ghci> maximum list4
20/1
ghci> maximum list5
1/2
ghci> maximum list6
0/1

<minimum>
ghci> minimum list1
1/2
ghci> minimum list2
1/20
ghci> minimum list3
421/420
ghci> minimum list4
1/1
ghci> minimum list5
1/2
ghci> minimum list6
0/1

<average>
ghci> average []   
*** Exception: Empty average
CallStack (from HasCallStack):
  error, called at lab3.hs:70:14 in main:Main
ghci> average list1
17955695/20692672
ghci> average list2
11167027/62078016
ghci> average list3
22/21
ghci> average list4
21/2
ghci> average list5
1/2
ghci> average list6
0/1
-}