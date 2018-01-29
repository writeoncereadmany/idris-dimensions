module Quantity
import public Dimension

%access public export
%default total

Quantity : Dimensions -> Type
Quantity = Dimensioned Double

interface Quantifiable val (dim : Dimensions) | val where
  quantify : val -> Quantity dim

baseUnit : (n : String) -> Quantity [(Dim n 1)]
baseUnit n = WithDim 1 (makeDimension n)

dimensionless : Double -> Quantity []
dimensionless n = WithDim n []

Quantifiable Double [] where
  quantify val = dimensionless val

Quantifiable Integer [] where
  quantify val = dimensionless (fromInteger val)

Quantifiable (Quantity dim) dim where
  quantify val = val

asNumber : Quantity [] -> Double
asNumber (WithDim n []) = n

infixr 10 #
infixr 7 ??

(??) : Quantity n -> Quantity n -> Double
(??) (WithDim a _) (WithDim b _) = a / b

syntax [quantity] "in" [units] = quantity ?? units

(+) : (Quantifiable t1 d, Quantifiable t2 d) => t1 -> t2 -> Quantity d
x + y = case (quantify x, quantify y) of
           ((WithDim a d), (WithDim b d)) => WithDim (a + b) d

(-) : (Quantifiable t1 d, Quantifiable t2 d) => t1 -> t2 -> Quantity d
x - y = case (quantify x, quantify y) of
          ((WithDim a d), (WithDim b d)) => WithDim (a - b) d

(*) : (Quantifiable t1 d1, Quantifiable t2 d2) => t1 -> t2 -> Quantity (d1 * d2)
x * y = case (quantify x, quantify y) of
          ((WithDim a d1), (WithDim b d2)) => WithDim (a*b) (d1*d2)

(/) : (Quantifiable t1 d1, Quantifiable t2 d2) => t1 -> t2 -> Quantity (d1 / d2)
x / y = case (quantify x, quantify y) of
          ((WithDim a d1), (WithDim b d2)) => WithDim (a / b) (d1 / d2)
