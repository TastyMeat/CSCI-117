-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = (x:zs, ys) where (ys,zs) = deal xs
{-
ghci> deal []
([],[])
ghci> deal [1]
([1],[])
ghci> deal [1,4,3,6,2,5]
([1,3,2],[4,6,5])
-}

-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys
{-
ghci> merge [] []
[]
ghci> merge [1,3,2] []
[1,3,2]
ghci> merge [] [4,6,5]
[4,6,5]
ghci> merge [1,3,2] [4,6,5]
[1,3,2,4,6,5]
-}

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
-- general case: deal, recursive call, merge
ms xs = merge (ms ys) (ms zs) where (ys, zs) = deal xs
{-
ghci> ms []
[]
ghci> ms [1]
[1]
ghci> ms [1,4,3,6,2,5]     
[1,2,3,4,5,6]
-}


-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons a Nil = Snoc Nil a
cons a (Snoc Nil x) = Snoc (cons a Nil) x
cons a (Snoc xs x) = Snoc (cons a xs) x
{-
ghci> a = Nil
ghci> b = cons 1 a
ghci> b
Snoc Nil 1
ghci> c = cons 2 b
ghci> c
Snoc (Snoc Nil 2) 1
ghci> d = cons 3 c
ghci> d
Snoc (Snoc (Snoc Nil 3) 2) 1
-}

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil
toBList [x] = Snoc Nil x
toBList (x:xs) = cons x (toBList xs)
{-
ghci> toBList []
Nil
ghci> toBList [1]   
Snoc Nil 1
ghci> toBList [1..4]
Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4
-}

-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc [] a = [a]
snoc [x] a = x : snoc [] a
snoc (x:xs) a = x : snoc xs a
{-
ghci> snoc [] 5
[5]
ghci> snoc [1] 5
[1,5]
ghci> snoc [1..4] 5
[1,2,3,4,5]
-}

-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc Nil x) = [x]
fromBList (Snoc xs x) = snoc (fromBList xs) x
{-
ghci> fromBList (toBList [])  
[]
ghci> fromBList (toBList [1])
[1]
ghci> fromBList (toBList [1..5])
[1,2,3,4,5]
-}


-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node _ treeA treeB) = num_empties treeA + num_empties treeB
{-
ghci> num_empties Empty
1
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> num_empties a
4
ghci> a = Node 2 (Node 3 (Node 5 Empty Empty) Empty) (Node 4 Empty Empty)
ghci> num_empties a
5
-}

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node _ treeA treeB) = 1 + num_nodes treeA + num_nodes treeB
{-
ghci> num_nodes Empty 
0
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> num_nodes a
3
ghci> a = Node 2 (Node 3 (Node 5 Empty Empty) Empty) (Node 4 Empty Empty)
ghci> num_nodes a
4
-}

-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left a Empty = Node a Empty Empty
insert_left a (Node value treeA treeB) = Node value (insert_left a treeA) treeB
{-
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> b = insert_left 8 a
ghci> b
Node 2 (Node 3 (Node 8 Empty Empty) Empty) (Node 4 Empty Empty)
ghci> b = insert_left 8 Empty
ghci> b
Node 8 Empty Empty
-}

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right a Empty = Node a Empty Empty
insert_right a (Node value treeA treeB) = Node value treeA (insert_right a treeB)
{-
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> b = insert_right 8 a
ghci> b
Node 2 (Node 3 Empty Empty) (Node 4 Empty (Node 8 Empty Empty))
ghci> b = insert_right 8 Empty
ghci> b
Node 8 Empty Empty
-}

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty = 0
sum_nodes (Node value treeA treeB) = value + sum_nodes treeA + sum_nodes treeB
{-
ghci> sum_nodes Empty
0
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> sum_nodes a
9
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> sum_nodes a
22
-}

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node value treeA treeB) = inorder treeA ++ [value] ++ inorder treeB
{-
ghci> inorder Empty
[]
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> inorder a
[3,2,4]
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> inorder a
[3,5,2,8,4]
-}


-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf _) = 1
num_elts (Node2 _ treeA treeB) = 1 + num_elts treeA + num_elts treeB
{-
ghci> num_elts (Leaf 1)
1
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> num_elts a
3
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> num_elts a
7
-}

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf value) = value
sum_nodes2 (Node2 value treeA treeB) = value + sum_nodes2 treeA + sum_nodes2 treeB
{-
ghci> sum_nodes2 (Leaf 1)
1
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> sum_nodes2 a
9
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> sum_nodes2 a
33
-}

-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf value) = [value]
inorder2 (Node2 value treeA treeB) = inorder2 treeA ++ [value] ++ inorder2 treeB
{-
ghci> inorder2 (Leaf 1)
[1]
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> inorder2 a       
[3,2,4]
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> inorder2 a
[6,3,7,2,8,4,3]
-}

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf value) = Node value Empty Empty
conv21 (Node2 value treeA treeB) = Node value (conv21 treeA) (conv21 treeB)
{-
ghci> conv21 (Leaf 1)
Node 1 Empty Empty
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> conv21 a
Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> conv21 a
Node 2 (Node 3 (Node 6 Empty Empty) (Node 7 Empty Empty)) (Node 4 (Node 8 Empty Empty) (Node 3 Empty Empty))
-}


---- Part 2: Iteration and Accumulators ----------------


-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
toBList' :: [a] -> BList a
toBList' xs = go xs Nil where
  go :: [a] -> BList a -> BList a
  go [] bList = bList
  go (x:xs) bList = go xs (Snoc bList x)
{-
ghci> toBList' []
Nil
ghci> toBList' [1]
Snoc Nil 1
ghci> toBList' [1..4]
Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4
-}

fromBList' :: BList a -> [a]
fromBList' bList = go bList [] where
  go :: BList a -> [a] -> [a]
  go Nil xs = xs
  go (Snoc bList x) xs = go bList (x:xs)
{-
ghci> fromBList' (toBList [])
[]
ghci> fromBList' (toBList [1])
[1]
ghci> fromBList' (toBList [1..5])
[1,2,3,4,5]
-}

-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' tree = sum_nodes_it [tree] 0 where
  sum_nodes_it :: Num a => [Tree a] -> a -> a
  sum_nodes_it [] sum = sum
  sum_nodes_it (Empty:trees) sum = sum_nodes_it trees sum
  sum_nodes_it (Node value treeA treeB : trees) sum = sum_nodes_it (treeA:treeB:trees) (value + sum)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' tree = go [tree] 0 where
  go :: [Tree a] -> Int -> Int
  go [] count = count
  go (Empty:trees) count = go trees (count + 1)
  go (Node _ treeA treeB : trees) count = go (treeA:treeB:trees) count 
{-
ghci> num_empties' Empty
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> num_empties' a
4
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> num_empties' a
6
-}

num_nodes' :: Tree a -> Int
num_nodes' tree = go [tree] 0 where
  go :: [Tree a] -> Int -> Int
  go [] count = count
  go (Empty:trees) count = go trees count
  go (Node _ treeA treeB : trees) count = go (treeA:treeB:trees) (count + 1) 
{-
ghci> num_nodes' Empty
0
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> num_nodes' a    
3
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> num_nodes' a
5
-}

sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' tree = go [tree] 0 where
  go :: Num a => [Tree2 a] -> a -> a
  go [] sum = sum
  go (Leaf value : trees) sum = go trees (sum + value)
  go (Node2 value treeA treeB : trees) sum = go (treeA:treeB:trees) (sum + value)
{-
ghci> sum_nodes2' (Leaf 1)
1
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> sum_nodes2' a       
9
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> sum_nodes2' a
33
-}

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' tree = go tree [] where
  go :: Tree2 a -> [a] -> [a]
  go (Leaf value) list = value : list
  go (Node2 value treeA treeB) list = go treeA (value : go treeB list)
{-
ghci> inorder2' (Leaf 1)
[1]
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> inorder2' a       
[3,2,4]
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> inorder2' a
[6,3,7,2,8,4,3]
-}


---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map _ [] = []
my_map f (x:xs) = f x : my_map f xs
{-
ghci> my_map even []    
[]
ghci> my_map even [1..4]
[False,True,False,True]
ghci> my_map (3+) [1..4]
[4,5,6,7]
-}

my_all :: (a -> Bool) -> [a] -> Bool
my_all _ [] = True
my_all f (x:xs) | not (f x) = False
                | otherwise = my_all f xs
{-
ghci> my_all even []
True
ghci> my_all even [1..4]
False
ghci> my_all even [2,4..8]
True
-}

my_any :: (a -> Bool) -> [a] -> Bool
my_any _ [] = False
my_any f (x:xs) | f x = True
                | otherwise = my_any f xs
{-
ghci> my_any even []
False
ghci> my_any even [1..4]
True
ghci> my_any even [1,3..7]
False
-}

my_filter :: (a -> Bool) -> [a] -> [a]
my_filter _ [] = []
my_filter f (x:xs) | f x = x : my_filter f xs
                   | otherwise = my_filter f xs
{-
ghci> my_filter even []
[]
ghci> my_filter even [1..8]
[2,4,6,8]
ghci> my_filter even [1]   
[]
-}

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile _ [] = []
my_dropWhile f (x:xs) | f x = my_dropWhile f xs
                      | otherwise = x:xs
{-
ghci> my_dropWhile (3 >) []    
[]
ghci> my_dropWhile (3 >) [1..5]
[3,4,5]
ghci> my_dropWhile (3 <) [1..5]
[1,2,3,4,5]
-}

my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile _ [] = []
my_takeWhile f (x:xs) | f x = x : my_takeWhile f xs
                      | otherwise = []
{-
ghci> my_takeWhile (3 <) []    
[]
ghci> my_takeWhile (3 <) [1..5]
[]
ghci> my_takeWhile (3 >) [1..5]
[1,2]
-}

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break _ [] = ([], [])
my_break f (x:xs) | not (f x) = (x:ys , zs) where (ys,zs) = my_break f xs
                  | otherwise = ([], x:xs)
{-
ghci> my_break (3 <) []    
([],[])
ghci> my_break (3 <) [1..5]
([1,2,3],[4,5])
ghci> my_break (3 >) [1..5]
([],[1,2,3,4,5])
-}

-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and xs = foldr (&&) True xs
{-
ghci> my_and []
True
ghci> my_and [True,True,True]
True
ghci> my_and [True,True,False]
False
-}

my_or :: [Bool] -> Bool
my_or xs = foldr (||) False xs
{-
ghci> my_or []
False
ghci> my_or [False,False,False]
False
ghci> my_or [False,False,True] 
True
-}

my_concat :: [[a]] -> [a]
--my_concat [] = []
my_concat xs = foldr (++) [] xs
{-
ghci> my_concat [[1..3],[4..6]]
[1,2,3,4,5,6]
ghci> my_concat []             
[]
ghci> my_concat [[],[]]
[]
ghci> my_concat [[1..3],[]]
[1,2,3]
ghci> my_concat [[],[4..6]]
[4,5,6]
-}

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum xs = foldl (+) 0 xs
{-
ghci> my_sum []    
0
ghci> my_sum [33]
33
ghci> my_sum [1..4]
10
-}

my_product :: Num a => [a] -> a
my_product xs = foldl (*) 1 xs
{-
ghci> my_product []
1
ghci> my_product [33]
33
ghci> my_product [1..4]
24
-}

my_reverse :: [a] -> [a]
my_reverse xs = foldl (\ys y -> y:ys) [] xs
{-
ghci> my_reverse []
[]
ghci> my_reverse [1]
[1]
ghci> my_reverse [1..4]
[4,3,2,1]
-}


---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
conv12 :: Tree a -> Maybe (Tree2 a)
conv12 Empty = Nothing
conv12 (Node x Empty Empty) = Just (Leaf x)
conv12 (Node _ Empty (Node _ _ _)) = Nothing
conv12 (Node _ (Node _ _ _) Empty) = Nothing
conv12 (Node x t1 t2) = case (conv12 t1, conv12 t2) of
                          (Just t1', Just t2') -> Just (Node2 x t1' t2')
                          _ -> Nothing


-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst t = go t NegInf PosInf where
  go :: Tree Int -> ExtInt -> ExtInt -> Bool
  go Empty _ _ = True
  go (Node x t1 t2) low high = low < fx && fx < high && go t1 low fx && go t2 fx high where fx = Fin x
    
bst2 :: Tree2 Int -> Bool
bst2 = undefined