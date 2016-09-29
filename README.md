#idris-dimensions

A library providing a system of dimensions in Idris, and a units-of-measure implementation built with it.

For example: it's reasonable to add two times:
```idris
*> 10 # minutes + 30 # seconds
WithDim 630.0 [Dim "seconds" 1] : Dimensioned Double [Dim "seconds" 1]
```
or two lengths:
```idris
*> 6 # feet + 3 # inches
WithDim 1.9049999999999998 [Dim "metres" 1] : Dimensioned Double [Dim "metres" 1]
```

but it's not reasonable to add a length to a time:
```idris
*> 20 # miles + 4 # hours
Can't disambiguate since no name has a suitable type:
        Prelude.Interfaces.+, Quantity.+
```

It is, however, reasonable to multiply or divide values of differing dimensions, and convert between different sets of units of the same dimensions:
```idris
*> 30 # metres / seconds
WithDim 30.0 [Dim "metres" 1, Dim "seconds" -1] : Dimensioned Double [Dim "metres" 1, Dim "seconds" -1]
*> it ?? miles / hours
67.10808876163208 : Double
```

