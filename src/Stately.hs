module Stately where

import Control.Monad.State

data AppState = AppState {
  counter :: Int
} deriving Show

appState = AppState { counter = 0 }

addOne :: State AppState Int
addOne = state $
  \s -> let added = counter s + 1 in
    (added, AppState { counter = added })
