module Main where

import Lib
import OrderTypes (getOrderTypes)
-- import Stately
import Control.Monad.State
import Control.Monad.Trans.Maybe
import Control.Monad.Trans.State

-- appState = AppState { counter = 0 }


-- runCounter :: String -> IO ()
-- runCounter "add" = do
--   print 10
--   main
-- runCounter "subtract" = do
--   print 8
--   main
-- runCounter "quit" = putStrLn "exiting"
-- runCounter _ = do
--   putStrLn "invalid input"
--   main

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
