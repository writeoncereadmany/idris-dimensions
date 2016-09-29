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

## Dimensions

Most of the time we encounter numbers, they're not just representing pure numbers: they're quantities of *something*. In physics, that's represented by a system of units of measure, which incorporates both units and dimensionality. Multiple units of the same dimensionality exist - for example, seconds, minutes and hours are all units of time, and feet and metres are both units of length. Two values with different units can be considered the same type (although unit conversion is required), but two values with different dimensionality cannot.

However, dimensionality types have relationships between them: it's possible to generate new dimensionality types algebraically from existing types. For example, multiplying a length by a length gives an area (of dimensionality length<sup>2</sup>). Representing this in traditional type systems is a challenge, but it's relatively straightforward in idris' dependent type system.

In this library, dimensions are represented by the type `Dimensions`. A `Dimensions` is an ordered list of `Dimension` (note: ordering is not enforced, but is maintained by the API provided), and a `Dimension` is a name and a power. For example, a length is represented by:
```idris
[Dim "metres" 1]
```
An area is represented by:
```idris
[Dim "metres" 2]
```
A frequency can be represented by:
```idris
[Dim "seconds" -1]
```
And a speed by:
```idris
[(Dim "metres" 1), (Dim "seconds" -1)]
```

It is not recommended that `Dimensions` be created directly, but instead use the `makeDimension` constructor, which creates `Dimensions` containing just that named dimension with power 1. From here, `Dimensions` can be combined using `*` and `/`:
```idris
*Dimension> :let Length = makeDimension "metres"
*Dimension> :let Time = makeDimension "seconds"
*Dimension> Length / Time
[Dim "metres" 1, Dim "seconds" -1] : List Dimension
*Dimension> (Length * Length * Time)
[Dim "metres" 2, Dim "seconds" 1] : List Dimension
*Dimension> inverse Time
[Dim "seconds" -1] : List Dimension
```

## Dimensioned

Once you have a `Dimensions`, you can then create a `Dimensioned`, which is a wrapper for a type parameterised by `Dimensions`.

```idris
*Dimension> WithDim 4 Length
WithDim 4 [Dim "metres" 1] : Dimensioned Integer [Dim "metres" 1]
```

There are no restrictions on what you can apply `Dimensioned` to: one other obvious use case is 2D vectors, but it also turns out that `Dimensioned` functions are very useful for applications which aren't dimensioned in the physics sense: see the Dimensioned Typesafe Builder Pattern section below for an example.

`Dimensioned` functions have some special support: composition using `.` is supported, as well as chaining using `&` (this is just function composition with the parameters reversed). However, this is simply because I can't get them working properly with partial application: hopefully these will become redundant soon.

Other than that, no operations on `Dimensioned` are defined, as these (and their impact on dimensions) will depend on exactly what you're representing.

## Quantity

The most common and obvious use case for a system of dimensions is `Quantity`, which is a `Dimensioned Double`. This implements addition and subtraction (of like-dimensioned quantities only), and multiplication and division. 

### `#`
The `#` operator multiplies a regular `Double` with a `Dimensioned Double` (without changing the dimensions): this allows a term like "3 metres" to be represented with the expression
```idris
*> 3 # metres
WithDim 3.0 [Dim "metres" 1] : Dimensioned Double [Dim "metres" 1]
```

### `??`
The `??` operator takes two `Quantity` values of like dimensions and returns the size of the first in terms of the size of the second. This should be the only way used to extract a `Double` from a `Quantity`: a dimensionless number is only derivable from a quantity if you specify the units you want. It should be read as "in", eg x **in** miles per hour is represented as follows:
```idris
*> 100 # metres / 9.58 # seconds
WithDim 10.438413361169102 [Dim "metres" 1, Dim "seconds" -1] : Dimensioned Double [Dim "metres" 1, Dim "seconds" -1]
*> it ?? miles / hours
23.350065679064745 : Double
```

### `baseUnit`
`baseUnit` constructs a new unit measure in a given dimension, and should be the only way a dimension is introduced. For example:
```idris
*> baseUnit "metres"
WithDim 1.0 [Dim "metres" 1] : Dimensioned Double [Dim "metres" 1]
```
Any derived units should then be defined in terms of the base unit:
```idris
*> :let miles = 1609.344 # metres
*> miles
WithDim 1609.344 [Dim "metres" 1] : Dimensioned Double [Dim "metres" 1]
*> :let footballField = square (100 # metres)
*> footballField
WithDim 10000.0 [Dim "metres" 2] : Dimensioned Double [Dim "metres" 2]
```
This then allows different units in like dimensions to be used equivalently, with any unit conversions taking place automatically.

### `Quantity.Units`
This defines all the SI units and dimensions, and a number of derived units and dimensions. Note that the dimensions of newtons are defined here as `Weight`, not `Force`, as defining `Force` does very confusing things to Idris' laziness implementation.

### `Quantity.Prefix`
This defines all the SI prefixes as functions which scale units by the appropriate factor. For example:
```idris
*> 132 # centi metres
WithDim 1.32 [Dim "metres" 1] : Dimensioned Double [Dim "metres" 1]
*> 200 # milli grams
WithDim 1.9999999999999998e-4 [Dim "kilograms" 1] : Dimensioned Double [Dim "kilograms" 1]
*> 20 # mega tonnes
WithDim 2.0e10 [Dim "kilograms" 1] : Dimensioned Double [Dim "kilograms" 1]
```

Note that as the base unit of mass is the kilogram, and gram has been defined for convenience, both `kilograms` and `kilo grams` are valid. Blame the French for that one.

### `Quantity.Units.Imperial`
Defines a number of imperial units (in terms of metric units).

