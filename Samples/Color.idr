module Samples.Color
import Dimension

data Color : Type where
  RGB : (red: Nat) -> (green: Nat) -> (blue: Nat) -> (name: Maybe String) -> (pantone: Bool) -> (webSafe: Bool) -> Color

Red : Dimensions
Red = makeDimension "red"

Green : Dimensions
Green = makeDimension "green"

Blue : Dimensions
Blue = makeDimension "blue"

buildColor : (Dimensioned (Color -> Color) (Red * Green * Blue)) -> Color
buildColor (WithDim f _) = f (RGB 0 0 0 Nothing False False) 

red : Nat -> Dimensioned (Color -> Color) Red
red r = WithDim setRed Red where
          setRed (RGB _ g b n p w) = RGB r g b n p w

green : Nat -> Dimensioned (Color -> Color) Green
green g = WithDim setGreen Green where
          setGreen (RGB r _ b n p w) = RGB r g b n p w

blue : Nat -> Dimensioned (Color -> Color) Blue
blue b = WithDim setBlue Blue where
          setBlue (RGB r g _ n p w) = RGB r g b n p w

named : String -> Dimensioned (Color -> Color) []
named n = WithDim setName [] where
           setName (RGB r g b _ p w) = RGB r g b (Just n) p w

pantone : Dimensioned (Color -> Color) []
pantone = WithDim setPantone [] where
           setPantone (RGB r g b n _ w) = RGB r g b n True w

websafe : Dimensioned (Color -> Color) []
websafe = WithDim setWebsafe [] where
           setWebsafe (RGB r g b n p _) = RGB r g b n p True
