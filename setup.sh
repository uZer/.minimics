#!/bin/bash

# Special requirements:
#   ctags:
#     universal-ctags
#   hyprland:
#     xdg-desktop-portal-hyprland wofi rofi-lbonn-wayland rofi-pass
#     swaylock-effects swaybg slop grim swappy wl-clipboard wireplumber
#     pipewire pipewire-pulse wdisplays kanshi playerctl brightnessctl
#     hyprpicker xdg-utils copyq tessen wtype imv qt5ct qt6ct swaync nwg-look
#     qogir-cursor-theme-git qogir-gtk-theme qogir-icon-theme terminator
#     ttf-mulish polkit-kde-agent noto-fonts-emoji xwaylandvideobridge
#   nvim:
#     neovim>=0.8.0 wget curl
#     npm yarn ripgrep fd tree-sitter tree-sitter-cli
#     luarocks python-pynvim lua-jsregexp
#     liquidsoap-prettier
#   pywal16:
#     pywal-16-colors

###################
## FEATURE FLAGS ##
###################

# Available modules:
# bash
# ctags
# chrome
# copyq
# env
# git
# gnuplot
# gtk
# htop
# hyprland
# kanshi
# minimics
# nvim
# pywal16
# rofi
# scide
# swappy
# swaync
# taskwarrior
# terminator
# vim
# waybar
# zsh

# By default, install selected modules:
modules=(bash zsh terminator chrome copyq ctags env git gtk htop hyprland  \
         minimics nvim pywal16 rofi waybar scide swaync taskwarrior kanshi \
         gnuplot swappy)

# Dotfiles path
MIN_PATH="${HOME}/.minimics"
OHMYZSH_PATH="${HOME}/.oh-my-zsh"

# Backup dir in ~/.minimics/.backup.<timestamp>
_BACKUPDIR="${MIN_PATH}/.backup.$(date +%s)"

echo "You will find backups in ${_BACKUPDIR}."
echo

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

###########
## TOOLS ##
###########

# Configuration file linking method, taking care of old conf if necessary
# backing it up in a new directory : $_BACKUPDIR
makelink () {
  _SOURCE="${1}"
  _DEST="${2}"

  # Source doesn't exist
  if [ ! -e "${_SOURCE}" ]; then
    echo "ERROR: Source file doesn't exist" 1>&2
    return 1
  fi

  # Destination exists as a symbolic link
  if [ -L "${_DEST}" ]; then
    echo "  Unlinking $_DEST first..."

    # Unlink
    if ! rm "${_DEST}"; then
      echo "ERROR: Can't unlink file." 1>&2
      return 2
    fi
  fi

  # Destination exists as a file or folder
  if [ -e "${_DEST}" ]; then
    echo "  Making backup dir ${_DEST}..."

    # Created backup folder
    mkdir -p "${_BACKUPDIR}" 2>/dev/null

    # Move the file/folder and check results
    if ! mv "${_DEST}" "${_BACKUPDIR}"; then
      echo "ERROR: Can't make backup. Please check permissions." 1>&2
      return 3
    fi
  fi

  # Make the new link
  ln -s "${_SOURCE}" "${_DEST}"
  return 0
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

##########################
## INSTALLATION SCRIPTS ##
##########################

_bash () {
  echo "[bash]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/bash/bashrc" "${HOME}/.bashrc"
  echo
  return
}

_chrome () {
  echo "[google-chrome]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/chrome/chrome-flags.conf" "${HOME}/.config/chrome-flags.conf"
  echo
  return
}

_ctags () {
  echo "[ctags]"
  echo "  Linking Universal Ctags configuration files..."
  makelink "${MIN_PATH}/ctags" "${HOME}/.ctags.d"
  echo
  return
}

_swaync () {
  echo "[swaync]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/swaync" "${HOME}/.config/swaync"
  echo
  return
}

_env () {
  echo "[env]"
  echo "  Linking configuration files..."
  mkdir -p "${HOME}/.config/environment.d"
  makelink "${MIN_PATH}/environment.d/minimics.cedilla.conf"  "${HOME}/.config/environment.d/minimics.cedilla.conf"
  makelink "${MIN_PATH}/environment.d/minimics.golang.conf"   "${HOME}/.config/environment.d/minimics.golang.conf"
  makelink "${MIN_PATH}/environment.d/minimics.path.conf"     "${HOME}/.config/environment.d/minimics.path.conf"
  echo
  return
}

_taskwarrior () {
  echo "[taskwarrior]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/taskwarrior/taskrc" "${HOME}/.taskrc"
  echo
  return
}

_terminator () {
  echo "[terminator]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/terminator" "${HOME}/.config/terminator"
  echo
  return
}

_copyq () {
  echo "[copyq]"
  echo "  Linking configuration files..."
  mkdir -p "${HOME}/.config/copyq/themes"
  makelink "${MIN_PATH}/copyq/copyq.conf" "${HOME}/.config/copyq/copyq.conf"
  makelink "${HOME}/.cache/wal/colors-copyq.css" "${HOME}/.config/copyq/themes/pywal.css"
  echo
  return
}

_git () {
  echo "[git]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/git/gitconfig" "${HOME}/.gitconfig"
  echo "  What is your github login? [Default: Youenn Piolet]"
  read -r GIT_LOGIN
  echo "  What is your github email? [Default: piolet.y@gmail.com]"
  read -r GIT_EMAIL
  GIT_LOGIN="${GIT_LOGIN:-Youenn Piolet}"
  GIT_EMAIL="${GIT_EMAIL:-piolet.y@gmail.com}"
  echo "  name  = ${GIT_LOGIN}"
  echo "  email = ${GIT_EMAIL}"
  git config --global user.name  "${GIT_LOGIN}"
  git config --global user.email "${GIT_EMAIL}"
  sed -i 's/^[\t]/  /g' "${MIN_PATH}/git/gitconfig"
  echo "export GIT_USERNAME=${GIT_LOGIN}" >> ~/.aliases.local
  echo "export GIT_EMAIL=${GIT_EMAIL}" >> ~/.aliases.local
  echo
  return
}

_gnuplot () {
  echo "[gnuplot]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/gnuplot/gnuplot"  "${HOME}/.gnuplot"
  echo
  return
}

_vim () {
  echo "[vim]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/vim/vimrc"  "${HOME}/.vimrc"
  makelink "${MIN_PATH}/vim"        "${HOME}/.vim"
  echo
  return
}

_nvim () {
  echo "[nvim]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/nvim"       "${HOME}/.config/nvim"
  if [ ! -f "${HOME}/.cache/wal/colors-wal.vim" ]; then
    echo "  Cheating the absence of pywal for the colorscheme..."
    mkdir -p "${HOME}/.cache/wal" 2>/dev/null
    cp "${MIN_PATH}/pywal16/.walcachefornvim" "${HOME}/.cache/wal/colors-wal.vim"
  fi
  echo
  return
}

_htop () {
  echo "[htop]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/htop/htoprc" "${HOME}/.config/htop/htoprc"
  echo
  return
}

_hyprland () {
  echo "[hyprland]"
  echo "  Linking hyprland and xprofile configuration files..."
  makelink "${MIN_PATH}/hyprland"           "${HOME}/.config/hypr"
  makelink "${MIN_PATH}/xprofile/xprofile"  "${HOME}/.xprofile"
  if [ ! -f "${HOME}/.cache/wal/colors-hyprland.conf" ]; then
    echo "  Cheating the absence of pywal for the colorscheme..."
    mkdir -p "${HOME}/.cache/wal" 2>/dev/null
    cp "${MIN_PATH}/pywal16/.walcacheforhyprland" "${HOME}/.cache/wal/colors-hyprland.conf"
  fi
  echo
  return
}

_rofi () {
  echo "[rofi]"
  echo "  Linking rofi/rofi-pass configuration"
  makelink "${MIN_PATH}/rofi"               "${HOME}/.config/rofi"
  makelink "${MIN_PATH}/rofi-pass"          "${HOME}/.config/rofi-pass"
  echo
  return
}

_pywal16 () {
  echo "[pywal16]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/pywal16"    "${HOME}/.config/wal"
  echo ""
  return
}

_waybar () {
  echo "[pywal16]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/waybar"    "${HOME}/.config/waybar"
  echo ""
  return
}

_kanshi () {
  echo "[kanshi]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/kanshi"    "${HOME}/.config/kanshi"
  echo ""
  return
}

_swappy () {
  echo "[swappy]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/swappy"    "${HOME}/.config/swappy"
  echo ""
  return
}

_zsh () {
  echo "[zsh]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/zsh/zshrc"    "${HOME}/.zshrc"
  makelink "${MIN_PATH}/zsh/p10k.zsh" "${HOME}/.p10k.zsh"
  if [ ! -e "${OHMYZSH_PATH}" ]; then
    echo "  Downloading oh-my-zsh..."
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${OHMYZSH_PATH}"
  fi
  echo "  Creating custom aliases file in ~/.aliases.local ..."
  touch ~/.aliases.local > /dev/null 2>&1
  echo ""
  return
}

_gtk () {
  # Useful for terminator configuration
  echo "[gtk]"
  echo "  Linking GTK2/GTK3 configuration files..."
  makelink "${MIN_PATH}/icons" "${HOME}/.config/icons"
  makelink "${MIN_PATH}/gtk-2.0/gtkrc-2.0" "${HOME}/.gtkrc-2.0"
  makelink "${MIN_PATH}/gtk-3.0" "${HOME}/.config/gtk-3.0"
  makelink "${MIN_PATH}/xsettingsd" "${HOME}/.config/xsettingsd"
  echo ""
  return
}

_scide () {
  echo "[Supercollider IDE]"
  echo "  Linking sc configuration files..."
  mkdir -p "${HOME}/.config/SuperCollider" 2>/dev/null
  makelink "${MIN_PATH}/supercollider/sc_ide_conf.yaml" "${HOME}/.config/SuperCollider/sc_ide_conf.yaml"
  makelink "${MIN_PATH}/supercollider/sclang_conf.yaml" "${HOME}/.config/SuperCollider/sclang_conf.yaml"
  makelink "${MIN_PATH}/supercollider/startup.scd"      "${HOME}/.config/SuperCollider/startup.scd"
  echo ""
  return
}

_minimics () {
  echo "[minimics]"
  echo "  Creating ${HOME}/.config if needed..."
  mkdir -p "${HOME}/.config" 2>/dev/null

  # Update submodules
  echo "  Updating submodules..."
  MY_DIR="$(pwd)"
  if cd "${MIN_PATH}"; then
    git submodule init
    git submodule update
  fi

  echo "  Create ${HOME}/.minimicsrc..."
  if [ ! -f "${HOME}/.minimicsrc" ] &&
    [ -f "${MIN_PATH}/minimicsrc.dist" ]; then
      cp minimicsrc.dist "${HOME}/.minimicsrc"
  fi
  cd "${MY_DIR}" || echo "Can't cd to previous folder.'"
  echo
  return
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

if [ $# -gt 0 ]; then
  # Install modules in arguments
  while (($#)); do
    eval "_${1}"
    shift
  done
else
  # Install default modules
  for module in "${modules[@]}"; do
    eval "_${module}"
  done
fi
