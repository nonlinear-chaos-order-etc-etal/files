#! /usr/bin/env sh

RELEASELISTING=$(lynx -listonly -nonumbers -dump https://download.i2p2.de/releases/ | sed 's|https://download.i2p2.de/||g' )

SCHEME='https://'

SITE='download.i2p2.de/'

for f in $RELEASELISTING; do
  wget -r -np -c $SCHEME$SITE$f
  mkdir -p $f/
  cp -rv $SITE$f/* $f/
  git add $f*
  git commit -am "$f"
  git push
done
