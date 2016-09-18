module Main
( main
) where

import Control.Monad.Aff (launchAff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (log)
import Database.PG (connect, queryType)
import Wortel.Prelude

main = launchAff do
  client <- connect "postgres://postgres@localhost/wortel"
  type_ <- queryType client "VALUES ('a', 1, true)"
  liftEff $ log $ show type_
