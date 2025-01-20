import System.IO
import Control.Concurrent
import Text.Printf

putInfo :: IO Float
putInfo = ((*) atom <$> read <$> head . words <$> readFile tempPath :: IO Float)

main :: IO ()
main = do
  putInfo >>= printf "%.1f deg\n"
  hFlush stdout
  threadDelay 10000000
  main

tempPath = "/sys/class/hwmon/hwmon3/temp1_input"
atom = 1.0e-3
