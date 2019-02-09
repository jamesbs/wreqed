{-# LANGUAGE OverloadedStrings #-}

module OrderTypes (
    getOrderTypes
  , postOrderTypes
) where
import Network.Wreq
import Control.Lens
import Data.Aeson
import Data.Aeson.Lens

url = "http://localhost:3000/orderTypes"

getOrderTypes = fmap (preview responseBody) (get url)

postOrderTypes = post url [ "id" := ("LIMIT_EXPLOSION" :: String) ]
