module Wortel.Type
( Type(..)
) where

import Wortel.Schema (Schema)

data Type
  = VarT String
  | AppT Type Type
  | DatabaseT Schema
