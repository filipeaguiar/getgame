#!/bin/bash

SYSTEM=$1
GAME=$2

function archive () {
  /roms/ports/.ia/ia download --no-directories $1 --glob="${2}" --destdir /roms/$SYSTEM
}

case $SYSTEM in
  psx)
    archive projeto-launchbox-sony-playstation "${GAME}"
    ;;
  gba)
    archive nointro.gba "${GAME}"
    cd /roms/gba
    7zr e "*.7z"
    rm *.7z
    ;;
  gbc)
    archive nointro.gbc "${GAME}*USA*"
    archive nointro.gb "${GAME}*USA*"
    cd /roms/gbc
    7zr e "*.7z" 
    rm *.7z
    ;;
  snes)
    archive nointro.snes "${GAME}*USA*"
    cd /roms/snes
    7zr e "*.7z" 
    rm *.7z
    ;;
  mastersystem)
    archive nointro.ms-mkiii "${GAME}"
    cd /roms/mastersystem
    7zr e "*.7z" 
    rm *.7z
    ;;
  megadrive)
    archive nointro.md "${GAME}*USA*"
    cd /roms/megadrive
    7zr e "*.7z" 
    rm *.7z
    ;;
  fbneo)
    archive fbnarcade-fullnonmerged "arcade/${GAME}"
    cd /roms/fbneo/arcade
    mv *.zip ../
    rm -rf /roms/fbneo/arcade
    ;;
  nds)
    archive no-ndsdec2021 "${GAME}"
    ;;
  n64)
    archive nointro.n64 "${GAME}"
    cd /roms/n64
    7zr e "*.7z" 
    rm *.7z
    ;;
  dreamcast)
    archive redump.dc.revival "${GAME}"
    cd /roms/dreamcast
    unzip "*.zip"
    rm *.zip
    ;;
  psp)
    archive redump.psp "${GAME}"
    archive redump.psp.p2 "${GAME}"
    cd /roms/psp
    unzip "*.zip"
    rm -rf *.zip
    ;;
  scummvm)
    echo "TBD"
    ;;
  *)
    echo "Opção Inválida"
    ;;
esac
