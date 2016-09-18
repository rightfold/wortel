module Database.PG
( PG
, Client
, connect
, queryType
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

queryType
  :: forall eff
   . Client
  -> String
  -> Aff (pg :: PG | eff) (List (String * Int))
queryType client sql =
  List.fromFoldable <<< (map \f -> f.name ~~> f.type) <$> _queryType client sql

foreign import _queryType
  :: forall eff
   . Client
  -> String
  -> Aff (pg :: PG | eff) (Array {name :: String, type :: Int})
