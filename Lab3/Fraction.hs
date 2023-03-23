module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving Eq


-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible (the case
-- where this is impossible is when m == 0).
frac :: Integer -> Integer -> Maybe Fraction
frac n m | m == 0 = Nothing
         | m < 0 = Just (reduce (Frac (-n) (-m)))
         | otherwise = Just (reduce (Frac n m))

reduce :: Fraction -> Fraction
reduce (Frac n m) | commonDivisor /= 1 = Frac (quot n commonDivisor) (quot m commonDivisor)
                  | otherwise = Frac n m
                  where commonDivisor = gcd n m

-- Show instance that outputs Frac n m as n/m
instance Show Fraction where
    show :: Fraction -> String
    show (Frac n m) = show n ++ "/" ++ show m
{-
ghci> show (Frac 1 3)
"1/3"
-}

-- Ord instance for Fraction
instance Ord Fraction where
    compare :: Fraction -> Fraction -> Ordering
    compare (Frac n1 m1) (Frac n2 m2) | m1 == m2 = compare n1 n2
                                      | otherwise = compare (n1 * m2) (n2 * m1)
{-
ghci> compare (Frac 1 2) (Frac 1 3)
GT
ghci> compare (Frac 1 2) (Frac 1 2)
EQ
ghci> compare (Frac 1 3) (Frac 1 2)
LT
-}

-- Num instance for Fraction
instance Num Fraction where
    (+) :: Fraction -> Fraction -> Fraction
    Frac n1 m1 + Frac n2 m2 = let result | m1 == m2 = Frac (n1 + n2) m1
                                         | otherwise = Frac (n1 * m2 + n2 * m1) (m1 * m2)
                              in reduce result

    (*) :: Fraction -> Fraction -> Fraction
    Frac n1 m1 * Frac n2 m2 = reduce (Frac (n1 * n2) (m1 * m2))

    negate :: Fraction -> Fraction
    negate (Frac n m) = Frac (-n) m

    abs :: Fraction -> Fraction
    abs (Frac n m) = Frac (abs n) m

    signum :: Fraction -> Fraction
    signum (Frac n m) | n > 0 = 1
                      | n < 0 = -1
                      | otherwise = 0
                      
    fromInteger :: Integer -> Fraction
    fromInteger x = Frac x 1
{-
ghci> Frac 1 3 + Frac 1 3
2/3
ghci> Frac 1 3 - Frac 1 3
0/1
ghci> Frac 1 3 * Frac 1 3
1/9

ghci> negate (Frac 1 2)
-1/2
ghci> -Frac 1 2
-1/2

ghci> abs (Frac 1 2)
1/2
ghci> abs (-Frac 1 2)
1/2

//fromInteger also at work here
ghci> signum (Frac 1 2)
1/1
ghci> signum (-Frac 1 2)
-1/1
-}
