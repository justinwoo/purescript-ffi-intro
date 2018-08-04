module Main
  -- we choose explicitly what to export here
  ( main
  , log
  , __log
  , callback
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried as EU

foreign import _log :: String -> Effect Unit

foreign import __log :: EU.EffectFn1 String Unit

-- expose a normal PureScript function for the uncurried function
log :: String -> Effect Unit
log = EU.runEffectFn1 __log

main :: Effect Unit
main = do
  _log "Hello from PureScript"
  log "Hello from PureScript 2"

callback :: EU.EffectFn1 (EU.EffectFn1 Int Unit) Unit
callback = EU.mkEffectFn1 \effectFn -> do
  EU.runEffectFn1 effectFn 1
