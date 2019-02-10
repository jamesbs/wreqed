module DoExample () where
-- the following functions are equivalent
-- func = getLine >>= \input -> return [input]

-- funcDo = do
--   input <- getLine
--   return [input]

-- popState :: State Stack Int
-- popState = state $ \(x:xs) -> (x,xs)

-- pushState :: Int -> State Stack ()
-- pushState a = state $ \xs -> ((),a:xs)

-- manipState = do
--   popState
--   popState

-- manipStateBind = popState >>= \x -> popState x
