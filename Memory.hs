import Util
import Text.Printf
import Control.Concurrent
import System.IO
import System.Environment

getInfo :: [[String]] -> String
getInfo [] = []
getInfo xs =
  let f = map (\n -> read n :: Float) . words $ values xs
      total = last f
      used = total - head f
      units = if used < (1.048576e+6) then oneMiB else oneGiB
      str = if units == oneMiB then "Mi" else "Gi"
  in printf "M%.2f %s / %.2f Gi\n" (used * units) str (total * oneGiB)
    where
      values [] = []
      values (x:xs)
        | head x == memTotalKey = values xs ++ " " ++ (last x)
        | head x == memAvailableKey = last x
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

oneGiB :: Float
oneGiB = 9.5367431640625e-7
oneMiB :: Float
oneMiB = 9.77e-4
memPath = "/proc/meminfo"
memTotalKey = "MemTotal:"
memAvailableKey = "MemAvailable:"
