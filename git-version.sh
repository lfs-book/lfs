#!/bin/bash

if [ "$1" = systemd ]; then
    SYSTEMD="INCLUDE"
    OPENRC="IGNORE"
    SYSV="IGNORE"
elif [ "$1" = openrc ]; then
    SYSTEMD="IGNORE"
    OPENRC="INCLUDE"
    SYSV="IGNORE"
elif [ "$1" = sysv ]; then
    SYSTEMD="IGNORE"
    OPENRC="IGNORE"
    SYSV="INCLUDE"
else
    echo You must provide \"systemd\", \"openrc\", or \"sysv\" as an argument
    exit 1
fi

echo "<!ENTITY % systemd \"$SYSTEMD\">"  >  conditional.ent
echo "<!ENTITY % openrc  \"$OPENRC\">"   >> conditional.ent
echo "<!ENTITY % sysv    \"$SYSV\">"     >> conditional.ent

if ! git status > /dev/null; then
    # Either it's not a git repository or git is unavailable.
    # Just workaround.
    echo "<!ENTITY version           \"unknown\">"   >  version.ent
    echo "<!ENTITY releasedate       \"unknown\">"   >> version.ent
    echo "<!ENTITY copyrightdate     \"1999-2023\">" >> version.ent
    exit 0
fi

export LC_ALL=en_US.utf8
export TZ=America/Chicago

commit_date=$(git show -s --format=format:"%cd" --date=local)

year=$(date --date "$commit_date" "+%Y")
month=$(date --date "$commit_date" "+%B")
month_digit=$(date --date "$commit_date" "+%m")
day=$(date --date "$commit_date" "+%d" | sed 's/^0//')

case $day in
    "1" | "21" | "31" ) suffix="st";;
    "2" | "22" ) suffix="nd";;
    "3" | "23" ) suffix="rd";;
    * ) suffix="th";;
esac

full_date="$month $day$suffix, $year"

sha="$(git describe --abbrev=1 --always --exclude '*')"
githash=$(echo -n "#" && echo -n "$sha")
version="$githash"

echo "<!ENTITY version           \"$version\">"            >  version.ent
echo "<!ENTITY releasedate       \"$full_date\">"          >> version.ent
echo "<!ENTITY copyrightdate     \"1999-$year\">"          >> version.ent
