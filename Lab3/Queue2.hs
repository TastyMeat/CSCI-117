module Queue2 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

--- Implementation -----------

{- In this implementation, a queue is represented as a pair of lists.
The "front" of the queue is at the head of the first list, and the
"back" of the queue is at the HEAD of the second list.  When the
second list is empty and we want to remove an element, we REVERSE the
elements in the first list and move them to the back, leaving the
first list empty. We can now process the removal request in the usual way.
-}

data Queue a = Queue2 [a] [a] deriving Show

mtq = Queue2 [] []
ismt (Queue2 xs ys) = null xs && null ys
addq x (Queue2 xs ys) = Queue2 (x:xs) ys
remq (Queue2 xs ys) | ismt (Queue2 xs ys) = error "Can't remove an element from an empty queue" 
                    | otherwise = case ys of [] -> (z, Queue2 [] zs) where (z:zs) = reverse xs 
                                             (z:zs) -> (z, Queue2 xs zs)

{-
ghci> mtq
Queue2 [] []

ghci> ismt mtq
True
ghci> ismt (Queue2 [] [])         
True
ghci> ismt (Queue2 [1..3] [])
False
ghci> ismt (Queue2 [] [6,5,4])
False
ghci> ismt (Queue2 [1..3] [6,5,4])
False

ghci> addq 3 mtq
Queue2 [3] []
ghci> a = addq 3 (Queue2 [1,2] [4,3])
ghci> a
Queue2 [3,1,2] [4,3]
ghci> b = addq 6 a
ghci> b
Queue2 [6,3,1,2] [4,3]

ghci> remq mtq
*** Exception: Can't remove an element from an empty queue
CallStack (from HasCallStack):
  error, called at Queue2.hs:26:45 in main:Queue2
ghci> (x, a) = remq (Queue2 [1,2] [4,3])
ghci> (x, a)
(4,Queue2 [1,2] [3])
ghci> (x, b) = remq a
ghci> (x, b)         
(3,Queue2 [1,2] [])
ghci> (x, c) = remq b
ghci> (x, c)         
(2,Queue2 [] [1])
-}