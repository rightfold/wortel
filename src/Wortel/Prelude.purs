module Wortel.Prelude
( module Control.Comonad.Cofree
, module Data.Either
, module Data.List
, module Data.Maybe
, module Data.Traversable
, module Data.Tuple
, module Prelude
, type (*)
, (~~>)
) where

import Control.Comonad.Cofree ((:<), Cofree, head, tail)
import Data.Either (Either(..))
import Data.List ((:), List(..))
import Data.Maybe (fromMaybe, Maybe(..), maybe)
import Data.Traversable (for, for_, sequence, sequence_, traverse, traverse_)
import Data.Tuple (curry, fst, snd, Tuple(..), uncurry)
import Prelude

infixl 7 type Tuple as *

infixl 7 Tuple as ~~>
