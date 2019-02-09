{-# LANGUAGE OverloadedStrings #-}
module OrderTypes (
  getOrderTypes
) where
import Network.Wreq (get, responseBody)
import Control.Lens ((^?))

url = "http://localhost:3000/orderTypes"

getOrderTypes = do
  response <- (get url)
  -- return response
  return $ response ^? responseBody
