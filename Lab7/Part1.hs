data Gen a = G (() -> (a, Gen a))

generate :: Int -> Gen Int
generate n = G (\_ -> (n, generate (n+1)))

times n (G f) = let (h, hs) = f() in G (\_ -> (n * h, times n hs))

merge g1@(G f1) g2@(G f2) | x < y = G (\_ -> (x, merge xs g2))
                          | y < x = G (\_ -> (y, merge g1 ys))
                          | otherwise = G (\_ -> (x, merge xs ys))
                          where (x, xs) = f1() 
                                (y, ys) = f2()

generateHamming hs = G (\_ -> (1, merge (times 2 hs) (merge (times 3 hs) (times 5 hs))))

gen_take :: Int -> Gen a -> [a]
gen_take 0 _ = []
gen_take n (G f) = let (x,g) = f () in x : gen_take (n-1) g    -- What's the type of f here?