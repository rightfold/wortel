module Wortel.Type
( Type(..)
, Schema
) where

import Control.Monad.Aff (Aff)
import Data.Map (Map)
import Data.Map as Map
import Database.PG (Client, PG, queryResultType)
import Wortel.Prelude

data Type
  = VarT String
  | AppT Type Type
  | DatabaseT Schema
  | RecordT (List (String * Type))

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
  -- TODO: args
  columns <- queryResultType client query
  fields <- for columns \(name ~~> pgType) ->
    case Map.lookup pgType pgTypes of
      Just type_ -> pure $ Right (name ~~> type_) -- TODO: how to deal with NULL values?
      Nothing -> pure $ Left $ "unknown PostgreSQL type: " <> show pgType
  pure $ RecordT <$> sequence fields
