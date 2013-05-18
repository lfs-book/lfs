#!/bin/bash

# Boot scripts
for s in network-scripts/lfs/lib/services/* \
         network-scripts/lfs/sbin/*         \
         network-scripts/lfs/tmpfiles/*     \
         network-scripts/lfs/units/*
do
  script=$(basename $s)

  # Skip directories
  [ $script == 'network-devices' ] && continue

  sed  -e 's/\&/\&amp\;/g' -e 's/</\&lt\;/g'   -e 's/>/\&gt\;/g' \
       -e "s/'/\&apos\;/g" -e 's/"/\&quot\;/g' -e 's/\t/    /g'  \
       $s > appendices/${script}.script
done
