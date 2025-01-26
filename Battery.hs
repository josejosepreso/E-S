import Util
import System.IO
import System.Process
import Control.Concurrent
import Control.Exception (catch, SomeException)
import Data.List (intercalate)

getInfo :: [[String]] -> [String]
getInfo [] = []
getInfo (x:xs)
  | head x == batCapacityKey = [last x]
  | head x == batStatusKey = [last x] ++ getInfo xs
  | otherwise = getInfo xs

battery :: IO [String]
battery = getInfo
          <$> map (split '=')
          <$> lines
          <$> readFile batPath

loop :: Bool -> IO ()
loop notified = do
  output <- battery
  putStrLn $ "B" ++ intercalate " " output
  hFlush stdout
  threadDelay 10000000

  let capacity = read $ last output :: Int
  if batLow < capacity then
    loop False
  else if and [batLow > capacity,
               head output == "Discharging",
               not notified] then
    do
      callCommand "herbe \"Low battery\""
        `catch`
        (\(e :: SomeException) -> pure ())
      loop True
  else
    loop notified

main = loop False

batLow = 10
batPath = "/sys/class/power_supply/BAT0/uevent"
batCapacityKey = "POWER_SUPPLY_CAPACITY"
batStatusKey = "POWER_SUPPLY_STATUS"
