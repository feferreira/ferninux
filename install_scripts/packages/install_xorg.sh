#!/bin/bash

set -e

SCRIPT=$(realpath -s "$0")
SCRIPT_PATH=$(dirname "$SCRIPT")

RECIPES_DIR=$SCRIPT_PATH/recipes/x86_64/xorg
SOURCES_ROOT_DIR=/sources

echo "Creating Xorg build env"
export XORG_PREFIX=/usr
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"

#if sudo installed
#cat > /etc/sudoers.d/xorg << EOF
#Defaults env_keep += XORG_PREFIX
#Defaults env_keep += XORG_CONFIG
#EOF

cat > /etc/profile.d/xorg.sh << EOF
XORG_PREFIX="$XORG_PREFIX"
XORG_CONFIG="--prefix=\$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
export XORG_PREFIX XORG_CONFIG
EOF
chmod 644 /etc/profile.d/xorg.sh

declare -a recipes=()
recipes+=(util-macros)
recipes+=(xorgproto)
recipes+=(libXau)
recipes+=(libXdmcp)
recipes+=(xcb-proto)
recipes+=(libxcb)
#auto generated by Xorg_Libraries.sh
recipes+=(xtrans)
recipes+=(libX11)
recipes+=(libXext)
recipes+=(libFS)
recipes+=(libICE)
recipes+=(libSM)
recipes+=(libXScrnSaver)
recipes+=(libXt)
recipes+=(libXmu)
recipes+=(libXpm)
recipes+=(libXaw)
recipes+=(libXfixes)
recipes+=(libXcomposite)
recipes+=(libXrender)
recipes+=(libXcursor)
recipes+=(libXdamage)
recipes+=(libfontenc)
recipes+=(libXfont2)
recipes+=(libXft)
recipes+=(libXi)
recipes+=(libXinerama)
recipes+=(libXrandr)
recipes+=(libXres)
recipes+=(libXtst)
recipes+=(libXv)
recipes+=(libXvMC)
recipes+=(libXxf86dga)
recipes+=(libXxf86vm)
recipes+=(libpciaccess)
recipes+=(libxkbfile)
recipes+=(libxshmfence)
# end Xorg Libraries
recipes+=(libxcvt)
recipes+=(xcb-util)
recipes+=(xcb-util-image)
recipes+=(xcb-util-keysyms)
recipes+=(xcb-util-renderutil)
recipes+=(xcb-util-wm)
recipes+=(xcb-util-cursor)
recipes+=(Mesa)
recipes+=(xbitmaps)
#auto generated by Xorg_Applications.sh
recipes+=(iceauth)
recipes+=(luit)
recipes+=(mkfontscale)
recipes+=(sessreg)
recipes+=(setxkbmap)
recipes+=(smproxy)
recipes+=(x11perf)
recipes+=(xauth)
recipes+=(xbacklight)
recipes+=(xcmsdb)
recipes+=(xcursorgen)
recipes+=(xdpyinfo)
recipes+=(xdriinfo)
recipes+=(xev)
recipes+=(xgamma)
recipes+=(xhost)
recipes+=(xinput)
recipes+=(xkbcomp)
recipes+=(xkbevd)
recipes+=(xkbutils)
recipes+=(xkill)
recipes+=(xlsatoms)
recipes+=(xlsclients)
recipes+=(xmessage)
recipes+=(xmodmap)
recipes+=(xpr)
recipes+=(xprop)
recipes+=(xrandr)
recipes+=(xrdb)
recipes+=(xrefresh)
recipes+=(xset)
recipes+=(xsetroot)
recipes+=(xvinfo)
recipes+=(xwd)
recipes+=(xwininfo)
recipes+=(xwud)
# end Xorg_Applications
recipes+=(xcursor-themes)
# auto generated by Xorg_Fonts.sh
recipes+=(font-util)
recipes+=(encodings)
recipes+=(font-alias)
recipes+=(font-adobe-utopia-type1)
recipes+=(font-bh-ttf)
recipes+=(font-bh-type1)
recipes+=(font-ibm-type1)
recipes+=(font-misc-ethiopic)
recipes+=(font-xfree86-type1)
# end Xorg_fonts
recipes+=(XKeyboardConfig)
recipes+=(Xwayland)
recipes+=(Xorg-Server)
recipes+=(libevdev) 
recipes+=(xf86-input-evdev)
recipes+=(libinput)
recipes+=(xf86-input-libinput)
recipes+=(xf86-input-synaptics)
recipes+=(xf86-input-wacom)
recipes+=(twm)
recipes+=(xterm)
recipes+=(xclock)
recipes+=(xinit)

cd $RECIPES_DIR

for file in "${recipes[@]}"
do
    if [ -x "$file.sh" ]; then
        . ./"$file.sh"
	echo "extracting files from $SRC_COMPRESSED_FILE"
	rm -rf $SOURCES_ROOT_DIR/$SRC_FOLDER
	tar xvf $SOURCES_ROOT_DIR/$SRC_COMPRESSED_FILE -C $SOURCES_ROOT_DIR
	cd $SOURCES_ROOT_DIR/$SRC_FOLDER
	build_source_package
	rm -rf $SOURCES_ROOT_DIR/$SRC_FOLDER
	cd $RECIPES_DIR
    else
        echo "File $file is not executable."
    fi
done

install -v -d -m755 /usr/share/fonts                               &&
ln -svfn $XORG_PREFIX/share/fonts/X11/OTF /usr/share/fonts/X11-OTF &&
ln -svfn $XORG_PREFIX/share/fonts/X11/TTF /usr/share/fonts/X11-TTF
