import Data.Time.Format
import Data.Time.Clock
import Data.Time
import System.IO
import Control.Concurrent

clock :: IO String
clock = getZonedTime >>= return . formatTime defaultTimeLocale "%Y %b %d (%a) %I:%M%p"

main :: IO ()
main = do
  clock >>= putStrLn
  hFlush stdout
  threadDelay 50000000
  main
