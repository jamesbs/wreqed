{-# LANGUAGE OverloadedStrings #-}

module Main where
import Control.Monad.Reader
import OrderTypes
import Env
import Network.Wreq

env = Env { endpoint = "http://localhost:3000" }

main :: IO()
main = do
  m <- runReaderT (postOrderTypes [ "id" := ("LIMIT_11" :: String) ]) env
  print m

