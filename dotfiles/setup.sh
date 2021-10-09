#!/usr/bin/env bash

bold=$(tput bold)
color=$(tput setaf 5)
normal=$(tput sgr0)
arrow="${color}${bold}=>${normal}"


function help() {
    echo "${bold}Description:${normal} This script will install and setup Xmonad WM"
    echo ""
    echo "${bold}Usage: ${normal}"
    echo "      ./setup.sh [FLAGS]"
    echo ""
    echo "${bold}Flags: ${normal}"
    echo "      -h, --help,     Prints this help message"
    echo "      -i, --install,  This will install all required aplications and copy dotfiles"
}


function init() {
    echo "${arrow} Starting script..."

}


function install() {
  echo "${arrow} Starting Installation.."
  echo "${arrow} Would you like to install utiity apps? (rofi, xorg, nitrogen etc..): (yes/no)"
  read UITITY_INSTALLATION

  if [[ $UITITY_INSTALLATION == "yes" || $UITITY_INSTALLATION = "y" ]]; then
    echo "${arrow} Installing utility apps.."

     /usr/bin/yay -S xorg python pulseaudio pulseaudio-alsa pulseaudio-bluetooth alsa-utils nitrogen dmenu rofi xfce4-power-manager wireless_tools git flameshot volumeicon network-manager network-manager-applet iwd parcellite neofetch htop picom-git playerctl xsettingsd  nerd-fonts-complete
  else
    echo "${arrow} You chose: ${UITITY_INSTALLATION}"
  fi

  rsync -avxRHAXP --dry-run .config/picom ~/
  
  echo "${arrow} Would you like to install window manager and setup the dotfiles? (yes/no)"
  read INSTALL_WM

  if [[ $INSTALL_WM == "yes" || $INSTALL_WM == "y" ]]; then
    windowManager
  else
    echo "${arrow} You chose: ${INSTALL_WM}"
  fi

  echo "${arrow} Would you like to install terminal emulator and setup the dotfiles? (yes/no)"
  read INSTALL_TE

  if [[ $INSTALL_TE == "yes" || $INSTALL_WM == "y" ]]; then
    terminalEmulator
  else
    echo "${arrow} You chose: ${INSTALL_WM}"
  fi
}


function windowManager{

  echo " ${arrow} Do you want to install Xmonad Window Manager with Xmobar? (yes/no)"
  read INSTALL_WM

  if[[ $INSTALL_WM == "yes" || ${INSTALL_WM} == "y" ]]; then
     echo "${bold}Starting installation and copying dotfiles..${normal}"
    /usr/bin/yay -S xmonad xmonad-contrib xmobar
  else
    echo" ${arrow} You chose: ${INSTALL_TE}"
  fi

  rsync -avxRHAXP .xmonad/xmonad.hs .config/xmobar ~/

  echo " Xmonad and Xmobar are installed and all dotfiles are copied."

}


function terminalEmulator{
  
  echo " ${arrow} Do you want to install Kitty? (yes/no) "
  read INSTALL_TE

  if[[ $INSTALL_TE == "yes" || ${INSTALL_TE} == "y" ]]; then
     echo "${bold}Starting installation and copying dotfiles..${normal}"
    /usr/bin/yay -S kitty
  else
    echo" ${arrow} You chose: ${INSTALL_TE}"
  fi

  rsync -avxRHAXP .config/kitty ~/

  echo " Kitty is installed and all dotfiles are copied."
}


case "$#" in
0)
  help
  ;;
1)
  case "$1" in
  -h | --help | help)
    help
    ;;
  -i | --install | install)
    init
    install
    ;;
  *)
    echo "Input error."
    exit 1
    ;;
  esac
  ;;
*)
  echo "Input error, too many arguments."
  exit 1
  ;;
esac
