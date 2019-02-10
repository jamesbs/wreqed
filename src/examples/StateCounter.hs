module StateCounter where

import Control.Monad.Trans.State (StateT(..))

type CounterState = Int
data Outcome = Success Int | Quit | BadInput

runCounter :: String -> StateT CounterState IO Outcome
runCounter "add" = StateT $ \count -> return (Success (count + 1), count + 1)
runCounter "subtract" = StateT $ \count -> return (Success (count -1), count -1)
runCounter "quit" = StateT $ \count -> return (Quit, count)
runCounter _ = StateT $ \count -> return (BadInput, count)

initialState = 0

runApp :: CounterState -> IO ()
runApp count = do
  input <- getLine
  (result, current) <- runStateT (runCounter input) count

  case result of
    Quit -> putStrLn "ok. exiting"
    BadInput -> putStrLn "invalid input, please try again." >> runApp current
    Success c -> print c >> runApp current

main :: IO ()
main = do
  runApp initialState
