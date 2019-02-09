module Main where

import Lib
import OrderTypes (getOrderTypes)

main :: IO ()
main = do
  body <- getOrderTypes
  print body
