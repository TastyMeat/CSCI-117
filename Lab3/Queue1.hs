module Queue1 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

---- Implementation -----------

{- In this implementation, a queue is represented as an ordinary list.
The "front" of the queue is at the head of the list, and the "back" of
the queue is at the end of the list.
-}

data Queue a = Queue1 [a] --deriving Show

mtq = Queue1 []
ismt (Queue1 xs) = null xs
addq x (Queue1 xs) = Queue1 (x:xs)
remq (Queue1 xs) | ismt (Queue1 xs) = error "Can't remove an element from an empty queue"
                 | otherwise = let (y, ys) = split xs in (y, Queue1 ys)

split :: [a] -> (a, [a])
split [x] = (x, [])
split (x:xs) = let (y, ys) = split xs in (y, x:ys)

{-
ghci> mtq
Queue1 []

ghci> ismt mtq
True
ghci> ismt (Queue1 [])    
True
ghci> ismt (Queue1 [1..5])
False

ghci> addq 3 mtq    
Queue1 [3]
ghci> a = addq 3 (Queue1 [1..4])
ghci> a
Queue1 [3,1,2,3,4]
ghci> b = addq 6 a
ghci> b
Queue1 [6,3,1,2,3,4]

ghci> remq mtq
*** Exception: Can't remove an element from an empty queue
CallStack (from HasCallStack):
  error, called at Queue1.hs:26:30 in main:Queue1
ghci> (x, a) = remq (Queue1 [1..4])
ghci> (x, a)
(4,Queue1 [1,2,3])
ghci> (x, b) = remq a
ghci> (x, b)
(3,Queue1 [1,2])
-}