#!/usr/bin/sh

[ ! -d "object" ] && mkdir object
[ ! -d "build" ] && mkdir bin
[ ! -d "interface" ] && mkdir interface

ghc --make -odir ./object/ -hidir ./interface/ -o ./bin/battery Battery.hs
ghc --make -odir ./object/ -hidir ./interface/ -o ./bin/clock Clock.hs
ghc --make -odir ./object/ -hidir ./interface/ -o ./bin/memory Memory.hs
