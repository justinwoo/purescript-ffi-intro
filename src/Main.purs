module Main
  -- we choose explicitly what to export here
  ( main
  , log
  , __log
  , callback
  ) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Uncurried as EU
import Foreign (Foreign, unsafeToForeign)
import Simple.JSON as JSON

foreign import _log :: String -> Effect Unit

foreign import _log2 :: String -> String -> Effect Unit

foreign import __log :: forall a. EU.EffectFn1 a Unit

foreign import __log2 :: EU.EffectFn2 String String Foreign

foreign import __log3 :: EU.EffectFn1 Foreign Unit

callLog3 :: forall a. a -> Effect Unit
callLog3 = EU.runEffectFn1 __log3 <<< unsafeToForeign

callLog2AndDecodeIt :: Effect Unit
callLog2AndDecodeIt = do
  blob <- EU.runEffectFn2 __log2 "asdf" "zxcv"
  case JSON.read blob of
    Right (x :: Int) -> log "Did this correctly"
    Left e -> log $ "Did this wrong: " <> show e

-- expose a normal PureScript function for the uncurried function
log :: String -> Effect Unit
log = EU.runEffectFn1 __log

main :: Effect Unit
main = do
  callLog2AndDecodeIt
  _log "Hello from PureScript"
  log "Hello from PureScript 2"

callback :: EU.EffectFn1 (EU.EffectFn1 Int Unit) Unit
callback = EU.mkEffectFn1 \effectFn -> do
  EU.runEffectFn1 effectFn 1
