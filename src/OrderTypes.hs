{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ImpredicativeTypes #-}

module OrderTypes where
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
  liftIO $ pot (getEndpoint env) body

pot :: (MonadIO m) => String -> [FormParam] -> m (Response ByteString)
pot endpoint params = liftIO $ post (endpoint++ "/orderTypes") params

type GetOrderTypes m = (MonadIO m) => String -> m ByteString
got :: (MonadIO m) => String -> m ByteString
got endpoint = liftIO $ fmap (view responseBody) (get (endpoint ++ "/orderTypes"))

component :: (MonadReader (GetOrderTypes m) m) => m ByteString
component = do
  g <- ask
  g "string"
  -- liftIO $ g "blah"

