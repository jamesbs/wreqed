{-# LANGUAGE OverloadedStrings #-}
{-# Language GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}

module Main where
import Control.Monad.Reader
import OrderTypes
import Env
import Network.Wreq
import Data.String

env = Env { endpoint = "http://localhost:8888" }

newtype EP = EP String deriving newtype Show

-- instance Show EP where
--   show (EP s) = s

e = EP "http://localhost:3000"

main :: IO()
main = do
  print e
  m <- runReaderT getOrderTypes ("http://localhost:8888" :: String)
  print m

