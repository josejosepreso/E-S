module Memory
  ( memory
  )
  where

import Util
import Config
import Text.Printf

getInfo :: [[String]] -> String
getInfo [] = []
getInfo xs =
  let w = words $ values xs
      t = read $ last w :: Float
      h = read $ head w :: Float
  in printf "%.2f Gi / %.2f Gi" (t - h) (t)
    where
      values [] = []
      values (x:xs)
        | head x == memTotalKey = values xs ++ " " ++ show ((read $ last x) * oneGB)
        | head x == memAvailableKey = show $ read (last x) * oneGB
        | otherwise = values xs

memory :: IO String
memory = getInfo
         <$> map (\x -> init $ split ' ' x)
         <$> lines
         <$> readFile memPath
