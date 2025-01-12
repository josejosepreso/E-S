module Battery
  ( battery
  ) where

import Util
import Config
import Text.Printf

getInfo :: [[String]] -> String
getInfo [] = []
getInfo (x:xs)
  | head x == batCapacityKey = (last x)
  | head x == batStatusKey = printf "%s " (last x) ++ getInfo xs
  | otherwise = getInfo xs

battery :: IO String
battery = getInfo
          <$> map (\x -> split '=' x)
          <$> lines
          <$> readFile batPath
