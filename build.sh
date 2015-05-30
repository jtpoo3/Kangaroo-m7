#!/bin/bash

# The font colors are predefined in this array. Color will choose one at random
FONT_COLORS=(31 32 33 34 35 36 91 92 93 94 95 96 97)
COLOR=$(($RANDOM % ${#FONT_COLORS[@]}))

echo -e "\e[${FONT_COLORS[$COLOR]}m "
echo "        _   __                                        "
echo "       | | / /                                        "
echo "       | |/ /  __ _ _ __   __ _  __ _ _ __ ___   ___  "
echo "       |    \ / _' | '_ \ / _' |/ _' | '__/ _ \ / _ \ "
echo "       | |\  \ (_| | | | | (_| | (_| | | | (_) | (_) |"
echo "       \_| \_/\__,_|_| |_|\__, |\__,_|_|  \___/ \___/ "
echo "                           __/ |                      "
echo "                          |___/                  _,'  ___         "
echo "            _   __                     _       <__\__/   \        "
echo "           | | / /                    | |         \_  /  _\       "
echo "           | |/ /  ___ _ __ _ __   ___| |            \,\ / \\     "
echo "           |    \ / _ \ '__| '_ \ / _ \ |              //   \\    "
echo "           | |\  \  __/ |  | | | |  __/ |            ,/'     '\_, "
echo "           \_| \_/\___|_|  |_| |_|\___|_|             "
echo "                                                      "
echo -e "\033[0m                                            "

VER="KANGAROO"

DATE_START=$(date +"%s")
export LOCALVERSION="-"`echo $VER`
export KBUILD_BUILD_USER=PNDGE

export ARCH=arm
export SUBARCH=arm
export PATH=$PATH:~/toolchains/arm-eabi-4.8-lollipop/bin/
export CROSS_COMPILE=arm-eabi-
OUT_DIR="${HOME}/repos/Kangaroo_Installer"

make "m7_defconfig"
make -j2

# Copy zImage & modules
find -name 'zImage' -exec cp -v {} $OUT_DIR \;
rm `echo $OUT_DIR/system/lib/modules"/*"`
find -name '*.ko' -exec cp -v {} $OUT_DIR/system/lib/modules \;

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))

echo
echo "  Build completed in $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds."
echo "  Finish time: $(date +"%r")"
echo
