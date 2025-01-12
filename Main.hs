import System.IO
import Control.Concurrent
import Text.Printf
import Battery
import Memory

main :: IO ()
main = do
  memory >>= printf "%s |"
  battery >>= printf " %s\n"

  hFlush stdout

  threadDelay 1000000 

  main
