module StateExample () where
import Control.Monad.State
--  these are equivalent

manipState = do
  popState
  popState
  pushState 3

manipStateBind = popState >>= \_ -> popState >>= \_ -> pushState 3

type Stack = [Int]

--  non monad versions
pop :: Stack -> (Int,Stack)
pop (first:rest) = (first, rest)

push :: Int -> Stack -> ((),Stack)
push item stack = ((),item:stack)

popState :: State Stack Int
popState = state $ \(x:xs) -> (x,xs)

pushState :: Int -> State Stack ()
pushState a = state $ \xs -> ((),a:xs)

main :: IO ()
main = do
  putStrLn $ unwords ["pop!", show (runState popState [1..5])]
  putStrLn $ unwords ["push!", show (runState (pushState 10) [1..5])]
