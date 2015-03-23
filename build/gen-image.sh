#!/bin/sh

BUILD_DIR=$(pwd)"/"
BUILD_NEW=$(pwd)"/new/"
BUILD_REV=`date +"%Y%m%d%H%M"`

echo "== umount =="
umount $BUILD_NEW"dev/"

echo "== remove script ==\n"
rm -rf new/tmp/*

echo "== remove resolv.conf \n"
rm -rf new/etc/resolv.conf

echo "== make manifest ==\n"
rm -rf $BUILD_DIR"livecd/casper/filesystem.squashfs"

chroot $BUILD_NEW dpkg-query -W --showformat='${Package} ${Version}\n' > $BUILD_DIR"livecd/casper/filesystem.manifest"
cp $BUILD_DIR"livecd/casper/filesystem.manifest" $BUILD_DIR"livecd/casper/filesystem.manifest-desktop"
sed -ie '/ubiquity/d'  $BUILD_DIR"livecd/casper/filesystem.manifest-desktop"

mksquashfs new $BUILD_DIR"livecd/casper/filesystem.squashfs"

cd livecd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt

nano md5sum.txt

mkisofs -r -V "Suriyan 54.04 i386" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../suriyan-54.04_$BUILD_REV.iso .
md5sum ../suriyan-54.04_$BUILD_REV.iso > ../suriyan-54.04_$BUILD_REV.iso.md5

#qemu -boot d -cdrom ../suriyan-53.04b$BUILD_REV.iso -m 1024

