import Data.Time.Format
import Data.Time.Clock
import Data.Time
import System.IO
import Control.Concurrent

clock :: IO String
clock = getZonedTime >>= return . formatTime defaultTimeLocale "%Y %b %d (%a) %I:%M%p\n"

main :: IO ()
main = do
  clock >>= putStr
  hFlush stdout
  threadDelay 1000000
  main
