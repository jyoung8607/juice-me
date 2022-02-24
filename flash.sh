#!/bin/bash -e

FASTBOOT=platform-tools/fastboot

VERSION="r28.0.2"
PLATFORM="$(uname -s | tr '[:upper:]' '[:lower:]')"

if [ ! -f $FASTBOOT ]; then
  rm -rf platform-tools
  rm -f platform-tools-latest-$PLATFORM.zip

  curl -L https://dl.google.com/android/repository/platform-tools_$VERSION-$PLATFORM.zip --output platform-tools.zip
  unzip platform-tools.zip
  rm -f platform-tools.zip
fi

unzip -o ota-signed-juiceme-kernel.zip

echo "Please enter your computer password if prompted"

sudo $FASTBOOT flash recovery recovery-juiceme-kernel.img

# from OTA
[ -f files/logo.bin ] && $FASTBOOT flash LOGO files/logo.bin
sudo $FASTBOOT flash boot files/boot.img

sudo $FASTBOOT reboot
