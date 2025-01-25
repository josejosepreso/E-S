import Util
import System.IO
import Control.Concurrent

getInfo :: [[String]] -> String
getInfo [] = []
getInfo (x:xs)
  | head x == batCapacityKey = last x ++ "%\n"
  | head x == batStatusKey = (last x) ++ " " ++ getInfo xs
  | otherwise = getInfo xs

battery :: IO String
battery = getInfo
          <$> map (split '=')
          <$> lines
          <$> readFile batPath

main :: IO ()
main = do
  battery >>= putStr
  hFlush stdout
  threadDelay 10000000
  main

batPath = "/sys/class/power_supply/BAT0/uevent"
batCapacityKey = "POWER_SUPPLY_CAPACITY"
batStatusKey = "POWER_SUPPLY_STATUS"
