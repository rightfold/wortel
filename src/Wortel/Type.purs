module Wortel.Type
( Type(..)
, Schema
) where

import Control.Monad.Aff (Aff)
import Data.Map (Map)
import Data.Map as Map
import Database.PG (PG, Client)
import Wortel.Prelude

data Type
  = VarT String
  | AppT Type Type
  | DatabaseT Schema

newtype Schema = Schema Client

pgTypes :: Map Int Type
pgTypes = Map.empty
  # Map.insert 16 (VarT "prim::bool")
  # Map.insert 25 (VarT "prim::text")

queryType
  :: forall eff
   . Schema
  -> String
  -> List Type
  -> Aff (pg :: PG | eff) (Either String Type)
queryType (Schema client) query args = do
  pure (Left "NYI")
