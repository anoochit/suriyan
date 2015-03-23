#!/bin/sh

BUILD_DIR=$(pwd)"/new/"

echo "== copy resolv.conf ===\n"
cp -f src/resolv.conf new/etc/

#echo "== copy casper.conf ===\n"
#cp -f src/casper.conf new/etc/

#echo "== copy sources.list ===\n"
#cp -f src/sources.list new/etc/apt/

#echo "== copy local.list ===\n"
#cp -f src/local.list new/etc/apt/sources.list.d/

#cp -f src/suriyan*.deb new/tmp/

#echo "== copy gen-install.sh ===\n"
#cp gen-install.sh $BUILD_DIR"tmp/"

echo "== mount bind dev ===\n"
sudo mount --bind /dev/ $BUILD_DIR"dev"

echo "== chroot ===\n"
chroot $BUILD_DIR
