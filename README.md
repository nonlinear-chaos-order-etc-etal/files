# git clone i2p-release-mirror

This repository holds a complete copy of all the I2P Desktop releases from 
`0.9.10` to `0.9.49`, making it possible to set up a complete mirror of the
I2P releases by cloning it into the document root of a web server.

For example, In the case an I2P user install, it allows you to automatically
mirror the whole I2P release repository inside I2P with a single command:

`git clone https://github.com/eyedeekay/files $HOME/.i2p/eepsite/docroot/files`

Or, for a Debian-style operating system with a package install:

`sudo -u i2psvc git clone https://github.com/eyedeekay/files  /var/lib/i2p/i2p-config/eepsite/docroot/files`

It can also be cloned and mirrored automatically with eephttpd, using the terminal:

`eephttpd -b https://github.com/eyedeekay/files`

or the GUI:

![eephttpd](eephttpd.png)

Adapt these examples to the web server of your choice to instantly mirror all
the I2P software.

#scripts

You can also use the scripts to generate a mirror of I2P releases without
cloning the repository from github.

```sh
#! /usr/bin/env sh



SCHEME='https://'

#SITE='download.i2p2.de/'
SITE='files.i2p-projekt.de/'

DIR=releases
RELEASELISTING=$(lynx -listonly -nonumbers -dump $SCHEME$SITE$DIR/ | sed "s|$SCHEME$SITE$||g")

for f in $RELEASELISTING; do
  wget -r -np -c $SCHEME$SITE$f
  mkdir -p $f/
  rm $f/*/ -rf
  cp -rv $SITE$f/* $f/
  git add $f*
  git commit -am "$f"
  git push
done
```

If the server you are using doesn't have open directory listings enabled, you can
also use the scripts to pre-generate listings for your visitors to navigate with.

```sh
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
  rm $d/README.md
done

rm index.md
for f in $(ls); do
  if [ $f = "download.i2p2.de" ]; then
    break
  fi
  echo " - [$f]($f)" >> index.md 
  markdown index.md > index.html
done

mv index.html index2.html
pandoc README.md -o index.html
cat index2.html >> index.html
rm index2.html
```
