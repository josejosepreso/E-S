import Util
import Text.Printf
import Control.Concurrent
import System.IO
import System.Environment

getInfo :: [[String]] -> String
getInfo [] = []
getInfo xs =
  let t = read $ last $ words $ values xs :: Float
      h = read $ head $ words $ values xs :: Float
  in printf "%.2f Gi / %.2f Gi\n" (t - h) t
    where
      values [] = []
      values (x:xs)
        | head x == memTotalKey = values xs ++ " " ++ show ((read $ last x) * oneGB)
        | head x == memAvailableKey = show $ read (last x) * oneGB
        | otherwise = values xs

putInfo :: [String] -> IO ()
putInfo [] = putInfo ["-i", "5"]
putInfo args = do
  getInfo
    <$> map (init . split ' ')
    <$> lines
    <$> readFile memPath
    >>= putStr
  hFlush stdout
  threadDelay 10000000
  putInfo args

main :: IO ()
main = getArgs >>= putInfo

oneGB :: Float
oneGB = 9.5367431640625e-7
memPath = "/proc/meminfo"
memTotalKey = "MemTotal:"
memAvailableKey = "MemAvailable:"
