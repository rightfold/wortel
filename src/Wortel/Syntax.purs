module Wortel.Syntax
( Expr
, ExprF(..)
) where

import Wortel.Prelude
import Wortel.Type (Schema, Type)

type Expr = Cofree ExprF

data ExprF a
  = Var String
  | App a a
  | Abs String Type a
  | Sequence a a
  | Connect Schema a
  | Query a (List a) String
