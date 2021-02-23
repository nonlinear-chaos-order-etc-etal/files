#! /usr/bin/env sh

for d in $(find ./releases -type d); do
  if [ $d = "download.i2p2.de" ]; then
    break
  fi
  rm $d/index.md $d/index.html $d/README.md -fv
  for f in $(ls $d); do
    echo " - [$f]($f)" >> $d/README.md 
    markdown $d/README.md > $d/index.html
  done
done

markdown README.md > index.html
cat index.html >> index.html
