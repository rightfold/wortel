module Database.PG
( PG
, Client
, connect
, queryResultType
) where

import Control.Monad.Aff (Aff)
import Data.List as List
import Wortel.Prelude

foreign import data PG :: !

foreign import data Client :: *

foreign import connect
  :: forall eff
   . String
  -> Aff (pg :: PG | eff) Client

queryResultType
  :: forall eff
   . Client
  -> String
  -> Aff (pg :: PG | eff) (List (String * Int))
queryResultType client sql =
  _queryResultType client sql
  <#> map (\f -> f.name ~~> f.type)
      >>> List.fromFoldable

foreign import _queryResultType
  :: forall eff
   . Client
  -> String
  -> Aff (pg :: PG | eff) (Array {name :: String, type :: Int})
