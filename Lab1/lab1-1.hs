-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.


---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "λ: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

λ: succ 5
6
λ: succ 'd'
'e'
λ: succ False
True
λ: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
λ: succ Orange
Yellow
λ: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
λ: pred 6
5
λ: pred 'e'
'd'
λ: pred True
False
λ: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
λ: pred Orange
Red
λ: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
-- As one of your examples, try  (toEnum 3) :: Color --------------------------
{-
toEnum :: Enum a => Int -> a
fromEnum :: Enum a => a -> Int
enumFrom :: Enum a => a -> [a]
enumFromThen :: Enum a => a -> a -> [a]
enumFromTo :: Enum a => a -> a -> [a]
enumFromThenTo :: Enum a => a -> a -> a -> [a]

toEnum returns the element at the specified index under the derived Enum type. 
Not specifying an Enum type returns an error. fromEnum returns the index of 
the specified element within its Enum type. enumFrom returns a list of elements
beginning from the specified element, up till the last element in its Enum type.
Similar to enumFrom, enumFromThen returns a list of elements but in a pattern
according to the specified parameters. Ex: <enumFromThen Red Yellow> starts the
list from Red, then Yellow and the rest following the odd index pattern.
enumFromTo however returns a list of elements in a range from the first
parameter to the second parameter. Floating-points does not work well, and 
providing the parameters in a reverse order will return an empty list.
enumFromThenTo combines the features of enumFromThen and enumFromTo by taking in
3 parameters. Floating-points again does not work well.

ghci> (toEnum 3) :: Color
Green
ghci> (toEnum 3) :: Num

<interactive>:25:15: error:
    * Expecting one more argument to `Num'
      Expected a type, but `Num' has kind `* -> Constraint'
    * In an expression type signature: Num
      In the expression: (toEnum 3) :: Num
      In an equation for `it': it = (toEnum 3) :: Num
ghci> (toEnum 3) :: Int
3

ghci> fromEnum Yellow
2
ghci> fromEnum 3
3
ghci> fromEnum 'r'
114

ghci> enumFrom Orange
[Orange,Yellow,Green,Blue,Violet]
ghci> enumFrom 8
[8,9,10,11,12,13,...] //goes on until max int is reached
ghci> enumFrom False
[False,True]

ghci> enumFromThen Yellow Green
[Yellow,Green,Blue,Violet]
ghci> enumFromThen Red Yellow
[Red,Yellow,Blue]
ghci> enumFromThen Red Green
[Red,Green]

ghci> enumFromTo Orange Blue
[Orange,Yellow,Green,Blue]
ghci> enumFromTo 6 12
[6,7,8,9,10,11,12]
ghci> enumFromTo 0.1 1.0
[0.1,1.1]
ghci> enumFromTo 0.12 1.0
[0.12,1.12]

ghci> enumFromThenTo 2 4 20
[2,4,6,8,10,12,14,16,18,20]
ghci> enumFromThenTo 0.1 0.5 2.0
[0.1,0.5,0.9,1.3000000000000003,1.7000000000000002,2.1]
ghci> enumFromThenTo 'a' 'd' 'm'
"adgjm"
-}

-- ==, /= ---------------------------------------------------------------------
{-
(==) :: Eq a => a -> a -> Bool
(/=) :: Eq a => a -> a -> Bool

== is the isEqualTo operator and /= is the notEqualTo to operator. Both
operators compare 2 parameters of the same type and returns a Bool. They will
return an error if the 2 parameters are non-compatible types.

ghci> 8 == 9
False
ghci> Red == Red
True
ghci> 4 == 4
True

ghci> 5 /= 3
True
ghci> Red /= Blue
True
ghci> Red /= Red
False
ghci> 5 /= Red

<interactive>:60:1: error:
    * No instance for (Num Color) arising from the literal `5'
    * In the first argument of `(/=)', namely `5'
      In the expression: 5 /= Red
      In an equation for `it': it = 5 /= Red
-}

-- quot, div (Q: what is the difference? Hint: negative numbers) --------------
{-
quot :: Integral a => a -> a -> a
div :: Integral a => a -> a -> a

quot and div both takes in 2 parameters that derives from the Integral type, with
the first input being the dividend and the second being the divisor, and returns
the resulted quotient on the same type. The difference between the two is that quot
rounds the result towards zero whereas div rounds the result towards negative infinity.
The Integral type is used by Word, Integer, and Int in Haskell.

ghci> :info Integral
type Integral :: * -> Constraint
class (Real a, Enum a) => Integral a where
  quot :: a -> a -> a
  rem :: a -> a -> a
  div :: a -> a -> a
  mod :: a -> a -> a
  quotRem :: a -> a -> (a, a)
  divMod :: a -> a -> (a, a)
  toInteger :: a -> Integer
  {-# MINIMAL quotRem, toInteger #-}
        -- Defined in `GHC.Real'
instance Integral Word -- Defined in `GHC.Real'
instance Integral Integer -- Defined in `GHC.Real'
instance Integral Int -- Defined in `GHC.Real'

ghci> quot 20 3
6
ghci> quot (-20) 3
-6
ghci> quot 20 (-3)
-6
ghci> quot (-20) (-3)
6

ghci> div 20 3
6
ghci> div (-20) 3
-7
ghci> div 20 (-3)
-7
ghci> div (-20) (-3)
6
-}

-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------
{-
rem :: Integral a => a -> a -> a
mod :: Integral a => a -> a -> a

rem and mod both takes in 2 parameters that derives from the Integral type, with
the first input being the dividend and the second being the divisor, and returns
the resulted remainder on the same type. The difference between the two is that rem
rounds the quotient towards zero whereas mod rounds the quotient towards negative infinity.
The return value for rem and mod is the difference between the dividend and the product of
the divisor with their respective quotient. The Integral type is used by Word, 
Integer, and Int in Haskell.

ghci> :info Integral
type Integral :: * -> Constraint
class (Real a, Enum a) => Integral a where
  quot :: a -> a -> a
  rem :: a -> a -> a
  div :: a -> a -> a
  mod :: a -> a -> a
  quotRem :: a -> a -> (a, a)
  divMod :: a -> a -> (a, a)
  toInteger :: a -> Integer
  {-# MINIMAL quotRem, toInteger #-}
        -- Defined in `GHC.Real'
instance Integral Word -- Defined in `GHC.Real'
instance Integral Integer -- Defined in `GHC.Real'
instance Integral Int -- Defined in `GHC.Real'

ghci> rem 20 3
2
ghci> rem (-20) 3
-2
ghci> rem 20 (-3)
2
ghci> rem (-20) (-3)
-2

ghci> mod 20 3
2
ghci> mod (-20) 3
1
ghci> mod 20 (-3)
-1
ghci> mod (-20) (-3)
-2
-}

-- quotRem, divMod ------------------------------------------------------------
{-
quotRem :: Integral a => a -> a -> (a, a)
divMod :: Integral a => a -> a -> (a, a)

quotRem combines the functionality of the quot and rem functions above and returns 
both the quotient and remainder as a tuple (in that order) of the same type as 
the parameters. It takes in 2 parameters that derives from the Integral type, 
with the first input being the dividend and the second being the divisor. divMod 
is similar to quotRem but combines the functionality of the div and mod functions 
instead. Both quotRem and divMod retain the return behaviors of the functions

ghci> quotRem 20 3
(6,2)
ghci> quotRem (-20) 3
(-6,-2)
ghci> quotRem 20 (-3)
(-6,2)
ghci> quotRem (-20) (-3)
(6,-2)

ghci> divMod 20 3
(6,2)
ghci> divMod (-20) 3
(-7,1)
ghci> divMod 20 (-3)
(-7,-1)
ghci> divMod (-20) (-3)
(6,-2)
-}

-- &&, || ---------------------------------------------------------------------
{-
(&&) :: Bool -> Bool -> Bool
(||) :: Bool -> Bool -> Bool

The && and || are the AND and OR operators that evaluate a boolean expression 
between 2 Bool parameters and return a Bool type of either True or False. && has
higher precedence than || and will be evaluated first. 

ghci> True && False
False
ghci> True && True
True
ghci> True && 7 < 2
False
ghci> True && 7 > 2
True

ghci> True || False
True
ghci> False || False
False
ghci> False || 3 < 7
True
ghci> False || 3 > 7
False

ghci> False || True && False
False
-}

-- ++ -------------------------------------------------------------------------
{-
(++) :: [a] -> [a] -> [a]

The ++ operator is used for joining 2 lists. The list on the right side of the 
expression will be joined towards the end of the list on the left side, and the 
function will return this new list with elements from both the list arguments.

ghci> [1..4] ++ [5..8]
[1,2,3,4,5,6,7,8]
ghci> [1,2,3] ++ [2,4,8]
[1,2,3,2,4,8]
ghci> [1,2,3] ++ [4]
[1,2,3,4]
-}

-- compare --------------------------------------------------------------------
{-
compare :: Ord a => a -> a -> Ordering

The compare function takes in 2 parameters that derives the Ord type and returns
an Ordering which could contain either LT, EQ, or GT (less-than, equal, greater-than).
Some examples of types that derives the Ord type includes Int, Double, Ordering, and Bool.

ghci> :i Ordering
type Ordering :: *
data Ordering = LT | EQ | GT
        -- Defined in `GHC.Types'
instance Eq Ordering -- Defined in `GHC.Classes'
instance Monoid Ordering -- Defined in `GHC.Base'
instance Ord Ordering -- Defined in `GHC.Classes'
instance Semigroup Ordering -- Defined in `GHC.Base'
instance Enum Ordering -- Defined in `GHC.Enum'
instance Show Ordering -- Defined in `GHC.Show'
instance Read Ordering -- Defined in `GHC.Read'
instance Bounded Ordering -- Defined in `GHC.Enum'
ghci> compare 2 4
LT
ghci> compare 2 2
EQ
ghci> compare 4 2
GT
ghci> compare False True
LT
ghci> compare Red Yellow
LT
ghci> compare LT EQ
LT
-}

-- <, > -----------------------------------------------------------------------
{-
(<) :: Ord a => a -> a -> Bool
(>) :: Ord a => a -> a -> Bool

The < and > operators (is-less-than, is-greater-than) takes in 2 parameters 
deriving the Ord type and returns a Bool by checking if the given parameters 
accurately reflects the ordering condition of the expression.

ghci> 3 < 4
True
ghci> 4 < 4
False
ghci> 3 > 3
False
ghci> 4 > 3
True
-}

-- max, min -------------------------------------------------------------------
{-
(max) :: Ord a => a -> a -> a
(min) :: Ord a => a -> a -> a

The max and min functions take in 2 parameters deriving the Ord type and returns
the maximum (or minimum) value between the 2. Passing in parameters of the same 
value will instead just return that value.

ghci> max 4 6
6
ghci> max 6 4
6
ghci> max 6 6
6
ghci> min 4 6
4
ghci> min 6 4
4
ghci> min 6 6
6
-}

-- ^ --------------------------------------------------------------------------
{-
(^) :: (Num a, Integral b) => a -> b -> a

The ^ operator takes in a Num type on the left side, and an Integral type for the
exponent on the right side and returns a Num type. It calculates 'a' to the power 
of 'b'. Passing in a negative value or a floating-point as the exponent will result
in an error.

ghci> 5 ^ 2
25
ghci> 2 ^ 3
8
ghci> 9 ^ 2
81
ghci> 6 ^ 3
216
ghci> 4 ^ (-1)
*** Exception: Negative exponent
ghci> (-3) ^ 5
-243
-}

-- concat ---------------------------------------------------------------------
{-
concat :: Foldable t => t [a] -> [a]

ghci> :i Foldable
type Foldable :: (* -> *) -> Constraint
class Foldable t where
  Data.Foldable.fold :: Monoid m => t m -> m
  foldMap :: Monoid m => (a -> m) -> t a -> m
  Data.Foldable.foldMap' :: Monoid m => (a -> m) -> t a -> m
  foldr :: (a -> b -> b) -> b -> t a -> b
  Data.Foldable.foldr' :: (a -> b -> b) -> b -> t a -> b
  foldl :: (b -> a -> b) -> b -> t a -> b
  Data.Foldable.foldl' :: (b -> a -> b) -> b -> t a -> b
  foldr1 :: (a -> a -> a) -> t a -> a
  foldl1 :: (a -> a -> a) -> t a -> a
  Data.Foldable.toList :: t a -> [a]
  null :: t a -> Bool
  length :: t a -> Int
  elem :: Eq a => a -> t a -> Bool
  maximum :: Ord a => t a -> a
  minimum :: Ord a => t a -> a
  sum :: Num a => t a -> a
  product :: Num a => t a -> a
  {-# MINIMAL foldMap | foldr #-}
        -- Defined in `Data.Foldable'
instance Foldable [] -- Defined in `Data.Foldable'
instance Foldable Solo -- Defined in `Data.Foldable'
instance Foldable Maybe -- Defined in `Data.Foldable'
instance Foldable (Either a) -- Defined in `Data.Foldable'
instance Foldable ((,) a) -- Defined in `Data.Foldable'

ghci> concat [[1..4], [5..8]]
[1,2,3,4,5,6,7,8]
ghci> concat [2, 3]

<interactive>:114:1: error:
    * No instance for (Num [()]) arising from a use of `it'
    * In the first argument of `print', namely `it'
      In a stmt of an interactive GHCi command: print it
ghci> concat [[1,2],[3,4]]
[1,2,3,4]
-}

-- const ----------------------------------------------------------------------
{-
const :: a -> b -> a

The const function takes in 2 parameters and returns the first, discarding the 
second. However, a dummy function can be created (example below) to return the 
desired value in situations that takes functions as parameters.

ghci> const 3 4
3
ghci> f = const 5
ghci> f 3
5
ghci> f

<interactive>:136:1: error:
    * No instance for (Show (b0 -> Integer))
        arising from a use of `print'
        (maybe you haven't applied a function to enough arguments?)
    * In a stmt of an interactive GHCi command: print it
-}

-- cycle ----------------------------------------------------------------------
{-
cycle :: [a] -> [a]

The cycle function takes in a list as parameter and returns a list that is infinitely
concatenating the input list to repeat the pattern. Since Haskell uses lazy evaluation,
the infinite list will only be generated as much as the program requires it to. Passing
in an empty list will return an exception.

ghci> cycle [1..3]
[1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,...] //goes on forever
ghci> cycle ["hi", "!"]
["hi","!","hi","!","hi","!","hi","!","hi","!",...] //goes on forever
ghci> a = cycle [1..4]
ghci> a!!6
3
ghci> cycle []
*** Exception: Prelude.cycle: empty list
-}

-- drop, take -----------------------------------------------------------------
{-
drop :: Int -> [a] -> [a]
take :: Int -> [a] -> [a]

The drop and take functions take in an Int and a list as their parameters and
returns another list of the same type. With n as the given Int parameter, drop 
will remove n elements from the beginning of the list and returns a list of the
remaining elements, whereas take will return only a list of n elements from the 
beginning of the list.

ghci> drop 3 [1..6]
[4,5,6]
ghci> drop 5 [1..6]
[6]
ghci> take 3 [1..6]
[1,2,3]
ghci> take 5 [1..6]
[1,2,3,4,5]
-}

-- elem -----------------------------------------------------------------------
{-
elem :: (Foldable t, Eq a) => a -> t a -> Bool

The elem function takes in an Eq type and a Foldable of Eq as parameters, where a 
list derives the Foldable type. elem returns a Bool type by checking if the given 
input value exists as an element in the given list.

ghci> elem 2 [1..5]
True
ghci> elem 6 [1..5]
False
ghci> elem 'b' ['a'..'e']
True
ghci> elem 'f' ['a'..'e']
False
-}

-- even -----------------------------------------------------------------------
{-
even :: Integral a => a -> Bool

The even function takes in a parameter of type Integral and returns a Bool on 
whether if the given input is an even number.

ghci> even 5
False
ghci> even 8
True
ghci> even (-8)
True
ghci> even (-7)
False
ghci> even 0
True
-}

-- fst ------------------------------------------------------------------------
{-
fst :: (a, b) -> a

The fst function takes in a tuple of 2 elements as its parameter and returns the 
value of the first element. Using a differently sized tuple will return an error.

ghci> fst (1,2,3)

<interactive>:174:5: error:
    * Couldn't match expected type: (a, b0)
                  with actual type: (a0, b1, c0)
    * In the first argument of `fst', namely `(1, 2, 3)'
      In the expression: fst (1, 2, 3)
      In an equation for `it': it = fst (1, 2, 3)
    * Relevant bindings include it :: a (bound at <interactive>:174:1)
ghci> fst (1,2)
1
ghci> fst ("hi", "bye")
"hi"
-}

-- gcd ------------------------------------------------------------------------
{-
gcd :: Integral a => a -> a -> a

The gcd function takes in 2 parameters of the Integral type, and returns the 
greatest common divisor between the inputs as the same type.

ghci> gcd 3 9
3
ghci> gcd 11 7
1
ghci> gcd 5 25
5
-}

-- head -----------------------------------------------------------------------
{-
head :: [a] -> a

The head function takes in a list as its parameter and returns the first element
of the list. Passing in an empty list will return an exception.

ghci> head [1..5]
1
ghci> head []
*** Exception: Prelude.head: empty list
ghci> head [5..7]
5
-}

-- id -------------------------------------------------------------------------
{-
id :: a -> a

The id function takes in one parameter and returns back its value. It can be used
in situations that takes functions as parameters.

ghci> id 4
4
ghci> id 't'
't'
ghci> id True
True
-}

-- init -----------------------------------------------------------------------
{-
init :: [a] -> [a]

The init function takes in a list as its parameter and returns the list without
the last element. Passing in an empty list will return an exception.

ghci> init [1..4]
[1,2,3]
ghci> init [1..8]
[1,2,3,4,5,6,7]
ghci> init ['a'..'h']
"abcdefg"
ghci> init []
*** Exception: Prelude.init: empty list
-}

-- last -----------------------------------------------------------------------
{-
last :: [a] -> a

The last function takes in a list as its parameter and returns the last element
of the list. Passing in an empty list will return an exception.

ghci> last [1..4]
4
ghci> last [1..8]
8
ghci> last []
*** Exception: Prelude.last: empty list
-}

-- lcm ------------------------------------------------------------------------
{-
lcm :: Integral a => a -> a -> a

The lcm function takes in 2 parameters of the Integral type, and returns the 
lowest common multiple between the inputs as the same type.

ghci> lcm 3 7
21
ghci> lcm 2 24
24
ghci> lcm 8 6
24
-}

-- length ---------------------------------------------------------------------
{-
length :: Foldable t => t a -> Int

The length function takes in a Foldable (list) as its parameter and returns the 
length of the list as an Int. Trying to get the length of an infinite list will
freeze the terminal in a never-ending computation.

ghci> length [2..8]
7
ghci> length [2,4..12]
6
ghci> length []
0
ghci> a = repeat 'a'
ghci> length a //no result
-}

-- null -----------------------------------------------------------------------
{-
null :: Foldable t => t a -> Bool

The null function takes in a Foldable (list) as its parameter and returns a Bool
on whether if the list is empty or contains no element.

ghci> null []
True
ghci> null [1..4]
False
ghci> null [1]
False
ghci> null [[]]
False
-}

-- odd ------------------------------------------------------------------------
{-
odd :: Integral a => a -> Bool

The odd function takes in a parameter of type Integral and returns a Bool on 
whether if the given input is an odd number.

ghci> odd 5
True
ghci> odd 8
False
ghci> odd (-8)
False
ghci> odd (-7)
True
ghci> odd 0
False
-}

-- repeat ---------------------------------------------------------------------
{-
repeat :: a -> [a]

The repeat function takes in a parameter of any type and returns an infinitely 
sized list containing the given input as all its elements. Since Haskell uses 
lazy evaluation, the infinite list will only be generated as much as the program 
requires it to.

ghci> repeat 8
[8,8,8,8,8,...] //goes on forever
ghci> repeat True
[True,True,True,True,...] //goes on forever
ghci> a = repeat 'a'
ghci> a!!8
'a'
ghci> repeat [1]
[[1],[1],[1],[1],...] //goes on forever
-}

-- replicate ------------------------------------------------------------------
{-
replicate :: Int -> a -> [a]

The replicate function works similarly to repeat, but with an additional first 
parameter of type Int to specify the length of the list returned.

ghci> replicate 8 5
[5,5,5,5,5,5,5,5]
ghci> replicate 0 5
[]
ghci> replicate 8 'a'
"aaaaaaaa"
ghci> replicate 0 'a'
""
-}

-- reverse --------------------------------------------------------------------
{-
reverse :: [a] -> [a]

The reverse function takes in a list as its parameter and returns the list in a 
reversed order.

ghci> reverse [1..4]
[4,3,2,1]
ghci> reverse "hello"
"olleh"
ghci> reverse [4,3..1]
[1,2,3,4]
ghci> reverse []
[]
-}

-- snd ------------------------------------------------------------------------
{-
snd :: (a, b) -> b

The snd function takes in a tuple of 2 elements as its parameter and returns the 
value of the second element. Using a differently sized tuple will return an error.

ghci> snd (1,2,3)

<interactive>:13:5: error:
    * Couldn't match expected type: (a0, b)
                  with actual type: (a1, b0, c0)
    * In the first argument of `snd', namely `(1, 2, 3)'
      In the expression: snd (1, 2, 3)
      In an equation for `it': it = snd (1, 2, 3)
    * Relevant bindings include it :: b (bound at <interactive>:13:1)
ghci> snd (1,2)
2
ghci> snd ("hi","bye")
"bye"
-}

-- splitAt --------------------------------------------------------------------
{-
splitAt :: Int -> [a] -> ([a], [a])

The splitAt function takes in parameters of an Int for an index and a list, and 
returns a tuple of 2 lists. The function splits the input list before the specified 
index into 2 lists. If there are no elements before or after the given index, the 
respective resulted list will be empty.

ghci> splitAt 3 [1..8]
([1,2,3],[4,5,6,7,8])
ghci> splitAt 5 [1..8]
([1,2,3,4,5],[6,7,8])
ghci> splitAt 5 []
([],[])
ghci> splitAt (-1) []
([],[])
-}

-- zip ------------------------------------------------------------------------
{-
zip :: [a] -> [b] -> [(a, b)]

The zip function takes in 2 lists as its parameters, and returns a list of tuple
that is based on the parameters. Each tuple in the output list will contain the
values from both input lists at the same index. The output list will only contain
as many elements as the smallest input list.

ghci> zip [1..3] [4..6]
[(1,4),(2,5),(3,6)]
ghci> zip [1..3] [4..8]
[(1,4),(2,5),(3,6)]
ghci> zip [1..6] [4..6]
[(1,4),(2,5),(3,6)]
ghci> zip [] []
[]
ghci> zip [] [1..3]
[]
-}


-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------
{-
all :: Foldable t => (a -> Bool) -> t a -> Bool
any :: Foldable t => (a -> Bool) -> t a -> Bool

The all function takes in a function that returns a Bool and a Foldable (list) as
its parameters, and returns a Bool on whether if all elements in the list satisfies
the provided condition. The any function works similarly but checks if any element 
satisfies the provided condition instead. Both all and any uses a flag in its 
algorithm to return early when the condition failed (all) or when the condition is 
met (any). This resulted in them returning the initial value of their flag when given
a list of no element, and the flag value is unchanged.

ghci> all (3 >) [1..7]
False
ghci> all (8 >) [1..7]
True
ghci> all (8 >) []
True
ghci> any (3 <) [1..7]
True
ghci> any (8 <) [1..7]
False
ghci> any (8 <) []
False
-}

-- break ----------------------------------------------------------------------
{-
break :: (a -> Bool) -> [a] -> ([a], [a])

The break function takes in a function that returns a Bool and a list as
its parameters, and returns a tuple of 2 lists. The function splits the input list
before the first element that satisfies the provided condition into 2 lists.

ghci> break (3 <) [1..7]
([1,2,3],[4,5,6,7])
ghci> break (3 ==) [1..7]
([1,2],[3,4,5,6,7])
ghci> break (3 /=) [1..7]
([],[1,2,3,4,5,6,7])
ghci> break (3 ==) []
([],[])
-}

-- dropWhile, takeWhile -------------------------------------------------------
{-
dropWhile :: (a -> Bool) -> [a] -> [a]
takeWhile :: (a -> Bool) -> [a] -> [a]

The dropWhile and takeWhile functions take in a function that returns a Bool and
a Foldable (list) as their parameters, and returns another list of the same type. 
dropWhile will remove elements from the beginning of the list until the provided 
condition is not satisfied and returns a list of the remaining elements, whereas 
takeWhile will return only a list of elements from the beginning of the input list
until the provided condition is not satisfied.

ghci> dropWhile (3 >) [1..7]
[3,4,5,6,7]
ghci> dropWhile (3 >) ([1..5]++[1..5])
[3,4,5,1,2,3,4,5]
ghci> takeWhile (3 >) [1..7]
[1,2]
ghci> takeWhile (3 >) ([1..5]++[1..5])
[1,2]
-}

-- filter ---------------------------------------------------------------------
{-
filter :: (a -> Bool) -> [a] -> [a]

The filter function takes in a function that returns a Bool and a Foldable (list)
as its parameters and returns another list based on the input list, but removes all
the elements that did not satisfy the provided condition.

ghci> filter odd [1..10]
[1,3,5,7,9]
ghci> filter even [1..10]
[2,4,6,8,10]
ghci> filter (5 <) [1..10]
[6,7,8,9,10]
ghci> filter even []
[]
-}

-- iterate --------------------------------------------------------------------
{-
iterate :: (a -> a) -> a -> [a]

The iterate function takes in a function that can translate a variable to a different
value and an initial value as its parameters, and returns an infinitely sized list. 
This output list will has its first element as the second parameter value, its 
following elements will be the output of the translating function. Since Haskell uses 
lazy evaluation, the infinite list will only be generated as much as the program 
requires it to.

ghci> iterate (5 +) 3
[3,8,13,18,23,28,33,...] //goes on forever
ghci> iterate (5 *) 3
[3,15,75,375,1875,9375,46875,...] //goes on forever
ghci> iterate not False
[False,True,False,True,False,...] //goes on forever
-}

-- map ------------------------------------------------------------------------
{-
map :: (a -> b) -> [a] -> [b]

The map functions takes in a function and a list as its parameters, and returns
another list by mapping each element from the input list through the provided 
function.

ghci> map odd [1..5]
[True,False,True,False,True]
ghci> map even [1..5]
[False,True,False,True,False]
ghci> map (2*) [1..5]
[2,4,6,8,10]
ghci> map (2*) []
[]
-}

-- span -----------------------------------------------------------------------
{-
span :: (a -> Bool) -> [a] -> ([a], [a])

The span function takes in a function that returns a Bool and a list as its parameters, 
and returns a tuple of 2 lists. It works similarly to break, but instead splits the input list
before the first element that does not satisfy the provided condition into 2 lists.

ghci> span (3 >) [1..7]
([1,2],[3,4,5,6,7])
ghci> span (5 >) [1..7]
([1,2,3,4],[5,6,7])
ghci> span (5 >) []
([],[])
-}
