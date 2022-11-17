#!/bin/bash
REPO=/roms
IA=/roms/ports/.ia/ia

SYSTEM=$(dialog --menu "Escolha o sistema" 0 0 10 \
  gba "GameBoy Advance" \
  gbc "GameBoy Color" \
  snes "SuperNES" \
  mastersystem "Master System" \
  megadrive "MegaDrive" \
  fbneo "NeoGeo" \
  nds "Nintendo DS" \
  n64 "Nintendo 64" \
  dreamcast "DreamCast" \
  psp "PlayStation Portable" \
  scummvm "Scumm VM" --stdout)

GAME=$(dialog --inputbox 'Informe o nome do jogo' 0 0 --stdout)

archive () {
  mkdir -p "$REPO/$SYSTEM"
  $IA download --no-directories "$1" --glob="${2}" --destdir "$REPO/$SYSTEM"
}

case $SYSTEM in
  psx)
    archive projeto-launchbox-sony-playstation "${GAME}"
    ;;
  gba)
    archive nointro.gba "${GAME}" && \
    cd $REPO/gba && \
    7zr e "*.7z" && \
    rm -f ./*.7z
    ;;
  gbc)
    archive nointro.gbc "${GAME}*USA*" && \
    archive nointro.gb "${GAME}*USA*" && \
    cd $REPO/gbc && \
    7zr e "*.7z" && \
    rm -f ./*.7z
    ;;
  snes)
    archive nointro.snes "${GAME}*USA*" && \
    cd $REPO/snes && \
    7zr e "*.7z" && \
    rm -f ./*.7z
    ;;
  mastersystem)
    archive nointro.ms-mkiii "${GAME}" && \
    cd $REPO/mastersystem && \
    7zr e "*.7z" && \
    rm -f ./*.7z
    ;;
  megadrive)
    archive nointro.md "${GAME}*USA*" && \
    cd $REPO/megadrive && \
    7zr e "*.7z" && \
    rm -f ./*.7z
    ;;
  fbneo)
    archive fbnarcade-fullnonmerged "arcade/${GAME}" && \
    cd $REPO/fbneo/arcade && \
    mv ./*.zip ../ && \
    rm -rf $REPO/fbneo/arcade
    ;;
  nds)
    archive no-ndsdec2021 "${GAME}"
    ;;
  n64)
    archive nointro.n64 "${GAME}" && \
    cd /roms/n64 && \
    7zr e "*.7z" && \
    rm -f ./*.7z
    ;;
  dreamcast)
    archive redump.dc.revival "${GAME}" && \
    cd /roms/dreamcast && \
    unzip "*.zip" && \
    rm -f ./*.zip
    ;;
  psp)
    archive redump.psp "${GAME}" && \
    archive redump.psp.p2 "${GAME}" && \
    cd /roms/psp && \
    unzip "*.zip" && \
    rm -rf ./*.zip
    ;;
  scummvm)
    echo "TBD"
    ;;
  *)
    echo "Opção Inválida"
    ;;
esac
