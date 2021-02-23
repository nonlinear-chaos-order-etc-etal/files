#! /usr/bin/env sh

for d in $(find . -type d); do
  if [ $d = "download.i2p2.de" ]; then
    break
  fi
  rm $d/index.md $d/index.html -fv
  for f in $(ls $d); do
    echo "[$f]($f)" >> $d/index.md
    markdown $d/index.md > $d/index.html
  done
done
