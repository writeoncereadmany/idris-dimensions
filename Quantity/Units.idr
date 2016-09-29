module Quantity.Units

import Quantity
import Quantity.Prefix

%access public export
%default total

-- SI Units and dimensions

Length : Dimensions
Length = makeDimension "metres"
metres : Quantity Length
metres = baseUnit "metres"

Time : Dimensions
Time = makeDimension "seconds"
seconds : Quantity Time
seconds = baseUnit "seconds"

Mass : Dimensions
Mass = makeDimension "kilograms"
kilograms : Quantity Mass
kilograms = baseUnit "kilograms"

Current : Dimensions
Current = makeDimension "amps"
amps : Quantity Current
amps = baseUnit "amps"

Temperature : Dimensions
Temperature = makeDimension "kelvin"
kelvin : Quantity Temperature
kelvin = baseUnit "kelvin"

Substance : Dimensions
Substance = makeDimension "moles"
moles : Quantity Substance
moles = baseUnit "moles"

Intensity : Dimensions
Intensity = makeDimension "candelas"
candelas : Quantity Intensity
candelas = baseUnit "candelas"


-- Derived time units

minutes : Quantity Time
minutes = 60 # seconds

hours : Quantity Time
hours = 60 # minutes

days : Quantity Time
days = 24 # hours

years : Quantity Time
years = 365.25 # days

-- Derived masses

grams : Quantity Mass
grams = milli kilograms

tonnes : Quantity Mass
tonnes = 1000 # kilograms

-- Derived units and dimensions

Angle : Dimensions
Angle = Dimensionless
radians : Quantity Angle
radians = dimensionless 1

SolidAngle : Dimensions
SolidAngle = Dimensionless
steradians : Quantity SolidAngle
steradians = dimensionless 1

Area : Dimensions
Area = Length * Length
hectares : Quantity Area
hectares = 100 # square metres

Volume : Dimensions
Volume = Length * Length * Length
litres : Quantity Volume
litres = cubic (deci metres)

Frequency : Dimensions
Frequency = inverse Time
hertz : Quantity Frequency
hertz = (dimensionless 1) / seconds

-- not Force, because that *really* messes with lazy evaluation
Weight : Dimensions
Weight = (Mass * Length) / (Time * Time)
newtons : Quantity Weight
newtons = (kilograms * metres) / (square seconds)

Pressure : Dimensions
Pressure = Weight / (Length * Length)
pascals : Quantity Pressure
pascals = newtons / (square metres)

Energy : Dimensions
Energy = Weight * Length
joules : Quantity Energy
joules = newtons * metres

Power : Dimensions
Power = Energy / Time
watts : Quantity Power
watts = joules / seconds

Charge: Dimensions
Charge = Current * Time
coulombs : Quantity Charge
coulombs = amps * seconds

Voltage : Dimensions
Voltage = Power / Current
volts : Quantity Voltage
volts = watts / amps

Capacitance : Dimensions
Capacitance = Charge / Voltage
farads : Quantity Capacitance
farads = coulombs / volts

Resistance : Dimensions
Resistance = Voltage / Current
ohms : Quantity Resistance
ohms = volts / amps

Conductance : Dimensions
Conductance = Current / Voltage
siemens : Quantity Conductance
siemens = amps / volts

MagneticFlux : Dimensions
MagneticFlux = Energy / Current
webers : Quantity MagneticFlux
webers = joules / amps

MagneticFluxDensity : Dimensions
MagneticFluxDensity = MagneticFlux / Area
teslas : Quantity MagneticFluxDensity
teslas = webers / (square metres)

Inductance : Dimensions
Inductance = Resistance * Time
henries : Quantity Inductance
henries = ohms * seconds

LuminousFlux : Dimensions
LuminousFlux = Intensity * SolidAngle
lumens : Quantity LuminousFlux
lumens = candelas * steradians

Illuminance : Dimensions
Illuminance = LuminousFlux / Area
lux : Quantity Illuminance
lux = lumens / (square metres)

Radioactivity : Dimensions
Radioactivity = inverse Time
becquerels : Quantity Radioactivity
becquerels = (dimensionless 1) / seconds

RadioactiveDose : Dimensions
RadioactiveDose = Energy / Mass
grays : Quantity RadioactiveDose
grays = joules / kilograms
sieverts : Quantity RadioactiveDose
sieverts = joules / kilograms

CatalyticActivity : Dimensions
CatalyticActivity = Substance / Time
katals : Quantity CatalyticActivity
katals = moles / seconds