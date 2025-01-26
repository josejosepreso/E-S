import Network.Info
import System.Environment
import Text.Printf
import Control.Concurrent
import System.IO

putInfo :: [String] -> [NetworkInterface] -> String
putInfo [] [] = []
putInfo a [] = "No interface " ++ (head a)
putInfo args (x:xs)
  | args == [] = printf "%s %s%c%s" (show $ name x) (show $ ipv4 x) char (putInfo [] xs)
  | interface == name x = printf "N%s %s" interface (show $ ipv4 x)
  | otherwise = putInfo args xs
    where
      interface = head args
      char = if length xs == 0 then '\0' else '\n'

main :: IO ()
main = do
  putInfo <$> getArgs <*> getNetworkInterfaces >>= putStrLn
  hFlush stdout
  threadDelay 10000000
  main

