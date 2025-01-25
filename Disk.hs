import System.Process
import Text.Printf
import System.Environment

putInfo :: [String] -> IO String
putInfo [] = putInfo ["/dev/sda3"]
putInfo args = getInfo (head args)
               <$> tail
               <$> map words
               <$> lines <$> readProcess "df" ["-h"] []
  where
    getInfo :: String -> [[String]] -> String
    getInfo a [] = "No partition " ++ a
    getInfo arg (x:xs)
      | arg == head x =
        let dev = drop 5 $ head x
            locat = last x
            used = x !! 2
            total = x !! 1
        in printf "%s (%s): %s / %s" dev locat used total
      | otherwise = getInfo arg xs

main :: IO ()
main = getArgs >>= putInfo >>= putStrLn
