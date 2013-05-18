#!/bin/bash

# Boot scripts
for s in systemd-units/lfs/lib/services/* \
         systemd-units/lfs/sbin/*         \
         systemd-units/lfs/tmpfiles/*     \
         systemd-units/lfs/units/*
do
  script=$(basename $s)

  # Skip directories
  [ $script == 'network-devices' ] && continue

  sed  -e 's/\&/\&amp\;/g' -e 's/</\&lt\;/g'   -e 's/>/\&gt\;/g' \
       -e "s/'/\&apos\;/g" -e 's/"/\&quot\;/g' -e 's/\t/    /g'  \
       $s > appendices/${script}.script
done
