#!/bin/bash

rm -f lfs-network-scripts*.tar.bz2

# Get base file name and move bootscripts directory to that name
version=`grep "ENTITY lfs-network-scripts-version" packages.ent |cut -d'"' -f2`
mv network-scripts lfs-network-scripts-$version

# Create the tarball and clean up
tar -cjf lfs-network-scripts-$version.tar.bz2 --exclude .svn lfs-network-scripts-$version
mv lfs-network-scripts-$version network-scripts
