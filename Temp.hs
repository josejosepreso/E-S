import System.IO
import Control.Concurrent
import Text.Printf

putInfo :: IO String
putInfo = show <$> ((*) 1.0e-3 <$> read <$> head . words <$> readFile tempPath :: IO Float)

main :: IO ()
main = do
  putInfo >>= printf "%s deg\n"
  hFlush stdout
  threadDelay 10000000
  main

tempPath = "/sys/class/hwmon/hwmon3/temp1_input"
