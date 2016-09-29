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

makeDimension : Index -> Dimensions
makeDimension n = [Dim n 1]

-- This has a pre-requisite that the list of dimensions is ordered by the index. I should add that to the types....
mergeDimensions : (Power -> Power -> Power) -> Dimensions -> Dimensions -> Dimensions
mergeDimensions _ [] [] = []
mergeDimensions f [] ((Dim dy ny) :: ys) = (Dim dy (f 0 ny)) :: (mergeDimensions f [] ys)
mergeDimensions f ((Dim dx nx) :: xs) [] = (Dim dx (f nx 0)) :: (mergeDimensions f xs [])
mergeDimensions f ((Dim dx nx) :: xs) ((Dim dy ny) :: ys) with (compare dx dy)
  | LT = (Dim dx (f nx 0)) :: (mergeDimensions f xs ((Dim dy ny) :: ys))
  | EQ = if (f nx ny) == 0
            then mergeDimensions f xs ys
            else (Dim dx (f nx ny)) :: (mergeDimensions f xs ys)
  | GT = (Dim dy (f ny 0)) :: (mergeDimensions f ((Dim dx nx) :: xs) ys)

(*) : Dimensions -> Dimensions -> Dimensions
(*) = mergeDimensions (+)
(/) : Dimensions -> Dimensions -> Dimensions
(/) = mergeDimensions (-)

data Dimensioned : Type -> Dimensions -> Type where
  WithDim : a -> (d : Dimensions) -> Dimensioned a d

infixr 0 &

(&) : (Dimensioned (a -> b) d) -> (Dimensioned (b -> c) d') -> (Dimensioned (a -> c) (d * d'))
(&) (WithDim f d) (WithDim g d') = (WithDim (g . f) (d * d'))
