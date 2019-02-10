{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}

module OrderTypes (
    getOrderTypes
  , postOrderTypes
) where
import Network.Wreq
import Control.Lens
import Data.Aeson
import Env (Env(..))
import Data.ByteString.Lazy (ByteString)
import Control.Monad.Reader

class HasEndpoint t where
  getEndpoint :: t -> String

instance HasEndpoint String where
  getEndpoint = id

instance HasEndpoint Env where
  getEndpoint = endpoint

getOrderTypes :: (MonadReader env m, HasEndpoint env, MonadIO m) => m (Maybe ByteString)
getOrderTypes = do
  env <- ask
  liftIO $ fmap (preview responseBody) (get $ (getEndpoint env) ++ "/orderTypes")

-- example post body
-- [ "id" := ("LIMIT_EXPLOSION" :: String) ]
postOrderTypes :: (MonadReader env m, HasEndpoint env, MonadIO m) => [FormParam] -> m (Response ByteString)
postOrderTypes body = do
  env <- ask
  liftIO $ post ((getEndpoint env) ++ "/orderTypes") body
