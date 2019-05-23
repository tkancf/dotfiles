main = do
    a <- readLn
    [b,c] <- map read . words <$> getLine
    s <- getLine
    putStrLn $ unwords [show (a + b + c), s]
