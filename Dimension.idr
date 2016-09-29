module Dimension

%access public export
%default total

-- These are theoretically replaceable with other types as long as the index is meaningful and ordered, 
-- and the power implements + and -. There may be value in replacing power with rationals, for example
Index : Type
Index = String

Power : Type
Power = Integer

data Dimension = Dim Index Power

Dimensions : Type
Dimensions = List Dimension

Dimensionless : Dimensions
Dimensionless = []

inverse : Dimensions -> Dimensions
inverse [] = []
inverse ((Dim i p)::rest) = (Dim i (-p))::(inverse rest)

makeDimension : Index -> Dimensions
makeDimension n = [Dim n 1]

-- This has a pre-requisite that the list of dimensions is ordered by the index. I should add that to the types....
(*) : Dimensions -> Dimensions -> Dimensions
(*) [] [] = []
(*) [] ys = ys
(*) xs [] = xs
(*) ((Dim dx nx) :: xs) ((Dim dy ny) :: ys) = combine (compare dx dy), (nx + ny))
  | (LT, _) = (Dim dx nx) :: (xs * ((Dim dy ny) :: ys))
  | (GT, _) = (Dim dy ny) :: (((Dim dx nx) :: xs) * ys)
  | (EQ, 0) = xs * ys
  | (EQ, n) = (Dim dx n) :: (xs * ys)

(/) : Dimensions -> Dimensions -> Dimensions
(/) x y = x * (inverse y)

data Dimensioned : Type -> Dimensions -> Type where
  WithDim : a -> (d : Dimensions) -> Dimensioned a d

infixr 0 &

(&) : (Dimensioned (a -> b) d) -> (Dimensioned (b -> c) d') -> (Dimensioned (a -> c) (d * d'))
(&) (WithDim f d) (WithDim g d') = (WithDim (g . f) (d * d'))
