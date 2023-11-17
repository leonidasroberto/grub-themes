#!/bin/bash

THEME_DIR="/usr/share/grub/themes"

[ ! -d "$THEME_DIR" ] && sudo mkdir $THEME_DIR

function has_command() {
  command -v $1 > /dev/null
}

function configure () {
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub

    if has_command update-grub; then
        update-grub
    elif has_command grub-mkconfig; then
        grub-mkconfig -o /boot/grub/grub.cfg
    elif has_command grub2-mkconfig; then
        if has_command zypper; then
            grub2-mkconfig -o /boot/grub2/grub.cfg
        elif has_command dnf; then
            grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}

# SELECT DISPLAY
exec 3>&1
v=$(dialog --menu 'GRUB THEME SELECTOR' 30 40 20 'CyberPunk2077' ''  'CRT-AMBER' '' 'CyberSynchro' '' 'CyberEXS' '' 'GTG' '' 'XENLISM-ARCH-1080' '' 'XENLISM-GENTOO-1080' '' 2>&1 1>&3);
clear

function applytheme () {
    case $v in
    "CRT-AMBER")
    THEME_NAME="crt-amber-theme"
    unzip $(pwd)/themes/crt-amber-theme.zip -d $THEME_DIR
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    "CyberPunk2077")
    THEME_NAME="Cyberpunk"
    unzip $(pwd)/themes/Cyberpunk-GRUB-Theme-main.zip 'Cyberpunk-GRUB-Theme-main/Cyberpunk/*' -d $THEME_DIR
    mv $THEME_DIR/Cyberpunk-GRUB-Theme-main/Cyberpunk $THEME_DIR
    rm -rfv $THEME_DIR/Cyberpunk-GRUB-Theme-main
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    "CyberSynchro")
    THEME_NAME="CyberSynchro"
    tar -xf $(pwd)/themes/CyberSynchro.tar.gz -C $THEME_DIR
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    "CyberEXS")
    THEME_NAME="CyberEXS"
    tar -xf $(pwd)/themes/CyberEXS-1.0.0.tar.gz -C $THEME_DIR
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    "GTG")
    THEME_NAME="grub_gtg-v1.2"
    tar -xf $(pwd)/themes/GTG-grub-theme.tar.tar -C $THEME_DIR
    tar -C $THEME_DIR -xf $(pwd)/themes/GTG-grub-theme.tar.tar grub_gtg-v1.2/assets
    mv $THEME_DIR/$THEME_NAME/assets/* $THEME_DIR/$THEME_NAME
    # Copy assets
    cp $THEME_DIR/$THEME_NAME/images/background.png $THEME_DIR/$THEME_NAME/background.png
    cp $THEME_DIR/$THEME_NAME/menu/menu_*.png $THEME_DIR/$THEME_NAME
    cp $THEME_DIR/$THEME_NAME/selection/select_*.png $THEME_DIR/$THEME_NAME
    cp $THEME_DIR/$THEME_NAME/scrollbar/scrollbar_thumb_c.png $THEME_DIR/$THEME_NAME
    rm -r $THEME_DIR/$THEME_NAME/assets
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    "XENLISM-ARCH-1080")
    THEME_NAME="xenlism-grub-arch-1080p"
    tar -C $THEME_DIR -xf $(pwd)/themes/xenlism-grub-arch-1080p.tar.xz xenlism-grub-arch-1080p/Xenlism-Arch
    mv $THEME_DIR/$THEME_NAME/Xenlism-Arch/* $THEME_DIR/$THEME_NAME
    rm -r $THEME_DIR/$THEME_NAME/Xenlism-Arch
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    "XENLISM-GENTOO-1080")
    THEME_NAME="xenlism-grub-gentoo-1080p"
    tar -C $THEME_DIR -xf $(pwd)/themes/xenlism-grub-arch-1080p.tar.xz xenlism-grub-gentoo-1080p/Xenlism-Gentoo
    mv $THEME_DIR/$THEME_NAME/Xenlism-Gentoo/* $THEME_DIR/$THEME_NAME
    rm -r $THEME_DIR/$THEME_NAME/Xenlism-Gentoo
    echo 50
    grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
    echo 75
    configure > /dev/null
    echo 100
    ;;
    *) echo "NO OPTION SELECTED";;
    esac
}

applytheme | dialog --gauge "APPLYNG GRUB THEME..." 8 50 0
clear
