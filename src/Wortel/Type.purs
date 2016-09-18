module Wortel.Type
( Type(..)
, Schema
) where

import Control.Monad.Aff (Aff)
import Database.PG (PG, Client)
import Wortel.Prelude

data Type
  = VarT String
  | AppT Type Type
  | DatabaseT Schema

newtype Schema = Schema Client

queryType
  :: forall eff
   . Schema
  -> String
  -> List Type
  -> Aff (pg :: PG | eff) (Either String Type)
queryType (Schema client) query args = do
  pure (Left "NYI")
