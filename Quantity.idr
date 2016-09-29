module Quantity
import public Dimension

%access public export
%default total

Quantity : Dimensions -> Type
Quantity = Dimensioned Double

baseUnit : (n : String) -> Quantity [(Dim n 1)]
baseUnit n = WithDim 1 (makeDimension n)

dimensionless : Double -> Quantity []
dimensionless n = WithDim n []

asNumber : Quantity [] -> Double
asNumber (WithDim n []) = n

infixr 10 # 
infixr 7 ??

(#) : Double -> Quantity n -> Quantity n
(#) a (WithDim b n) = WithDim (a*b) n

(??) : Quantity n -> Quantity n -> Double
(??) (WithDim a _) (WithDim b _) = a / b

(+) : Quantity n -> Quantity n -> Quantity n
(+) {n} (WithDim a _) (WithDim b _) = WithDim (a + b) n

(-) : Quantity n -> Quantity n -> Quantity n
(-) {n} (WithDim a _) (WithDim b _) = WithDim (a - b) n

(*) : Quantity a -> Quantity b -> Quantity (a * b)
(*) (WithDim x a) (WithDim y b) = WithDim (x * y) (a * b)

(/) : Quantity a -> Quantity b -> Quantity (a / b)
(/) (WithDim x a) (WithDim y b) = WithDim (x / y) (a / b)