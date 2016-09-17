module Wortel.Type
( Type(..)
, Schema
) where

data Type
  = VarT String
  | AppT Type Type
  | DatabaseT Schema

foreign import data Schema :: *
