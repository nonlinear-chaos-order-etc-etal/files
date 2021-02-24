#! /usr/bin/env sh

for d in $(find ./releases -type d); do
  if [ $d = "download.i2p2.de" ]; then
    break
  fi
  rm $d/index.md $d/index.html $d/README.md -fv
  for f in $(ls $d); do
    echo " - [$f]($f)" >> $d/README.md 
    pandoc $d/README.md -o $d/index.html
    if [ -f $d/shasums.txt ]; then
      echo '<pre><code>' >> $d/index.html
      cat $d/shasums.txt >> $d/index.html
      echo '</code></pre>' >> $d/index.html
    fi
  done
  git add $d/index.html
  rm $d/README.md
done

rm index.md
for f in $(ls); do
  if [ $f = "download.i2p2.de" ]; then
    break
  fi
  if [ -d $f ]; then
    g=$f/
    f=$g
  fi
  echo " - [$f]($f)" >> index.md 
  markdown index.md > index.html
done

mv index.html index2.html
pandoc README.md -o index.html
cat index2.html >> index.html
rm index2.html
