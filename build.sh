#!/usr/bin/sh

[ ! -d "object" ] && mkdir object
[ ! -d "bin" ] && mkdir bin
[ ! -d "interface" ] && mkdir interface

for f in *.hs; do ghc -dynamic --make -odir ./object/ -hidir ./interface/ -o ./bin/"$(echo $f | sed 's/.hs//')" $f; done
