#! /usr/bin/bash
User=$1
InstallPath="/home/$User/."


ls $InstallPath

if [ -d "$InstallPath/.config" ] ; then
    ls "$InstallPath/.config"
fi

