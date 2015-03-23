#!/bin/sh

echo "== mount bind ==\n"
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devpts none /dev/pts

echo "== export root dir ==\n"
export HOME=/root
export LC_ALL=C


echo "== gen locale for en ==\n"
locale-gen en_EN.UTF-8

echo "== config timezone data ==\n"
dpkg-reconfigure tzdata

#dpkg -i /tmp/suriyan-repository_1.0-8_all.deb
#mv /etc/apt/sources.list /etc/apt/sources.list.orig
#mv /etc/apt/sources.list.d/suriyan.list /tmp/

echo "== update package cache ==\n"
apt-get -y update
apt-get -y upgrade

echo "== install restricted extra, language pack support thai ==\n"
#apt-get --force-yes install ubuntu-restricted-extras language-support-th gstreamer0.10-plugins* suriyan-data suriyan-theme suriyan-thai-fonts suriyan-screensaver suriyan-plymouth-theme blueman
#apt-get --force-yes install ubuntu-restricted-extras language-support-th gstreamer0.10-plugins* suriyan-theme suriyan-thai-fonts suriyan-screensaver suriyan-screensaver suriyan-plymouth-theme blueman suriyan-sound-theme suriyan-data 
#aptitude install pdfmod shutter gimp inkscape thunderbird sound-juicer cheese easytag gtk-recordmydesktop soundconverter vlc deja-dup htop hardinfo startupmanager simple-ccsm
#apt-get --force-yes remove gnome-bluetooth
#aptitude clean

banfile="package.list"
for ip in `cat $banfile | awk '{print $1}'`; do
xpack=$xpack" "$ip 
done

apt-get -y install $xpack


echo "== umount ==\n"
umount /proc/sys/fs/binfmt_misc
umount /proc
umount /sys
umount /dev/pts
#exit

