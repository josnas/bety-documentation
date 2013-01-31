#!/bin/bash

for i in {'yields','traits','species','sites','treatments'}
do
    cutycapt --url=http://ebi-forcast.igb.uiuc.edu/bety/$i/new --out=$i\_new.png
done
