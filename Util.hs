module Util
  ( split
  ) where

split :: Char -> String -> [String]
split _ [] = []
split c xs = words $ map (\x -> if x == c
                                then
                                  ' '
                                else
                                  x
                         ) xs
