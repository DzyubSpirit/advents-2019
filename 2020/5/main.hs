import Control.Monad (when)
import Data.Char (digitToInt)
import Numeric (readInt)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  when (length args /= 1) $
    fail $ "Expected one command line argument, got " ++ show args
  passes <- lines <$> readFile (head args)
  print $ maximum $ map (setID . rowCol) passes

toBin :: String -> String
toBin = map f
  where f 'B' = '1'
        f 'F' = '0'
        f 'L' = '0'
        f 'R' = '1'

setID :: (Int, Int) -> Int
setID (raw, col) = raw*8+col

rowCol :: String -> (Int, Int)
rowCol pass = (toInt row, toInt col)
  where (row, col) = splitAt 7 $ toBin pass
        toInt = fst . head . readInt 2 (`elem` "01") digitToInt
