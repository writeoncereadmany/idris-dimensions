module Samples.UnsafeColor

data Color : Type where
  RGB : (red: Nat) -> (green: Nat) -> (blue: Nat) -> (name: Maybe String) -> (pantone: Bool) -> (webSafe: Bool) -> Color

buildColor : (Color -> Color) -> Color
buildColor f = f (RGB 0 0 0 Nothing False False) 

red : Nat -> Color -> Color
red r (RGB _ g b n p w) = RGB r g b n p w

green : Nat -> Color -> Color
green g (RGB r _ b n p w) = RGB r g b n p w

blue : Nat -> Color -> Color
blue b (RGB r g _ n p w) = RGB r g b n p w

named : String -> Color -> Color
named n (RGB r g b _ p w) = RGB r g b (Just n) p w

pantone : Color -> Color
pantone (RGB r g b n _ w) = RGB r g b n True w

websafe : Color -> Color
websafe (RGB r g b n p _) = RGB r g b n p True