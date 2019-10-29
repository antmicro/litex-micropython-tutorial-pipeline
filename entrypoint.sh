#!/bin/bash
set -e

ROOT=$PWD
SCRIPT=artifacts/script.sh

if [ -d litex-buildenv.wiki ]; then
  cd litex-buildenv.wiki
  git pull
  cd ..
else
  git clone https://github.com/timvideos/litex-buildenv.wiki
fi
cp litex-buildenv.wiki/MicroPython.md .

python3 -m pip install --user git+git://github.com/antmicro/tuttest

if [ -d litex-buildenv ]; then
  LOCAL=true
fi

python3 extract.py MicroPython.md $LOCAL > $SCRIPT

# a simpler command to debuf for local development
#if [ -e $ROOT/litex-buildenv/build/conda/bin/mono ]; then
#  PATH="$ROOT/litex-buildenv/build/conda/bin:$PATH" mono $ROOT/litex-buildenv/build/conda/opt/renode/bin/Renode.exe --disable-xwt -e "s @scripts/single-node/picosoc.resc"
#fi

echo "Running following script extracted from tutorial:"
cat $ROOT/$SCRIPT
chmod +x $ROOT/$SCRIPT
$ROOT/$SCRIPT
