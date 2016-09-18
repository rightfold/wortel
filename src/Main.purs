module Main
( main
) where

import Control.Monad.Aff (launchAff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (log)
import Database.PG (connect, queryResultType)
import Wortel.Prelude

main = launchAff do
  client <- connect "postgres://postgres@localhost/wortel"
  type_ <- queryResultType client "VALUES ('a', 1, true)"
  liftEff $ log $ show type_
