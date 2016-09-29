module Quantity.Prefix
import Quantity

%access public export
%default total

yotta : Quantity n -> Quantity n
yotta q = 1e24 # q

zetta : Quantity n -> Quantity n
zetta q = 1e21 # q

exa : Quantity n -> Quantity n
exa q = 1e18 # q

peta : Quantity n -> Quantity n
peta q = 1e15 # q

tera : Quantity n -> Quantity n
tera q = 1e12 # q

giga : Quantity n -> Quantity n
giga q = 1e9 # q

mega : Quantity n -> Quantity n
mega q = 1e6 # q

kilo : Quantity n -> Quantity n
kilo q = 1e3 # q

hecto : Quantity n -> Quantity n
hecto q = 100 # q

deca : Quantity n -> Quantity n
deca q = 10 # q

deci : Quantity n -> Quantity n
deci q = 1e-1 # q

centi : Quantity n -> Quantity n
centi q = 1e-2 # q

milli : Quantity n -> Quantity n
milli q = 1e-3 # q

micro : Quantity n -> Quantity n
micro q = 1e-6 # q

nano : Quantity n -> Quantity n
nano q = 1e-9 # q

pico : Quantity n -> Quantity n
pico q = 1e-12 # q

femto : Quantity n -> Quantity n
femto q = 1e-15 # q

atto : Quantity n -> Quantity n
atto q = 1e-18 # q

zepto : Quantity n -> Quantity n
zepto q = 1e-21 # q

yocto : Quantity n -> Quantity n
yocto q = 1e-24 # q

square : Quantity n -> Quantity (n*n)
square x = x * x

cubic : Quantity n -> Quantity (n*n*n)
cubic x = x * x * x