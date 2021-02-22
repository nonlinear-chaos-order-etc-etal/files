#! /usr/bin/env sh

RELEASELISTING=$(lynx -listonly -nonumbers -dump https://download.i2p2.de/releases/ | sed 's|https://download.i2p2.de/||g' )

SCHEME='https://'

SITE='download.i2p2.de/'

for f in $RELEASELISTING; do
#  echo $()
#  lynx -listonly -nonumbers -dump $f
  wget -r -np -c $SCHEME$SITE$f
  mkdir -p $f/
  cp -rv $SITE$f/* $f/
  git add $f*
  git commit -am "$f"
  echo git push
  exit
done
