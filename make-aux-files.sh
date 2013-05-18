#!/bin/bash

rm -f lfs-systemd-units*.tar.bz2

# Get base file name and move bootscripts directory to that name
version=`grep "ENTITY lfs-systemd-units-version" packages.ent |cut -d'"' -f2`
mv systemd-units lfs-systemd-units-$version

# Create the tarball and clean up
tar -cjf lfs-systemd-units-$version.tar.bz2 --exclude .svn lfs-systemd-units-$version
mv lfs-systemd-units-$version systemd-units
