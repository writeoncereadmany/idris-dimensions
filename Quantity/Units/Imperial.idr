module Quantity.Units.Imperial

import Quantity
import Quantity.Prefix
import Quantity.Units

%access public export
%default total

Dimensionless : Dimensions
Dimensionless = []

-- Units of length

inches : Quantity Length
inches = 25.4 # milli metres

feet : Quantity Length
feet = 12 # inches

yards : Quantity Length
yards = 3 # feet

rods : Quantity Length
rods = 5.5 # feet

chains : Quantity Length
chains = 22 # yards

furlongs : Quantity Length
furlongs = 10 # chains

miles : Quantity Length
miles = 8 # furlongs

leagues : Quantity Length
leagues = 3 # miles

-- Units of area

perches : Quantity Area
perches = square rods

roods : Quantity Area
roods = furlongs * rods

acres : Quantity Area
acres = furlongs * chains

-- Units of volume

fluidOunces : Quantity Volume
fluidOunces = 28.4130625 # milli litres

gills : Quantity Volume
gills = 5 # fluidOunces

pints : Quantity Volume
pints = 4 # gills

quarts : Quantity Volume
quarts = 2 # pints

gallons : Quantity Volume
gallons = 4 # quarts

pecks : Quantity Volume
pecks = 2 # gallons

bushels : Quantity Volume
bushels = 4 # pecks

-- Mass

pounds : Quantity Mass
pounds = 453.59237 # grams

ounces : Quantity Mass
ounces = pounds / (dimensionless 16)

stone : Quantity Mass
stone = 14 # pounds

quarter : Quantity Mass
quarter = 2 # stone

hundredweight : Quantity Mass
hundredweight = 8 # stone

tons : Quantity Mass
tons = 20 # hundredweight