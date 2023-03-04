#!/bin/bash
#
# Symlinks dotfiles for current user, creates backup of previous dotfiles.
# This script is so 2005 and hates you as much as you do hate it.

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

###################
## FEATURE FLAGS ##
###################

# Enable modules
INST_BASH="true"
INST_DUNST="true"
INST_GIT="true"
INST_GTK3="true"
INST_HTOP="true"
INST_I3="true"
INST_MINIMICS="true"
INST_NVIM="true"
INST_TW="true"
INST_VIM="false"
INST_ZSH="true"

# Dotfiles path
MIN_PATH="${HOME}/.minimics"
OHMY_PATH="${HOME}/.oh-my-zsh"

# Backup dir in ~/.minimics/.backup.<timestamp>
_BACKUPDIR="${MIN_PATH}/.backup.$(date +%s)"

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

###########
## TOOLS ##
###########

## [MAKELINK]
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

## [BASH]
installBash () {
  echo "[BASH]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/bash/bashrc" "${HOME}/.bashrc"
  echo
  return
}

# [DUNST]
installDunst () {
  echo "[DUNST]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/dunst" "${HOME}/.config/dunst"
  echo
  return
}

# [TASKWARRIOR]
installTW () {
  echo "[TASKWARRIOR]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/taskwarrior/taskrc" "${HOME}/.taskrc"
  echo
  return
}

## [GIT]
installGit () {
  echo "[GIT]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/git/gitconfig" "${HOME}/.gitconfig"
  echo "  What is your github login? [Default: Youenn Piolet]"
  read -r GIT_LOGIN
  echo "  What is your github email? [Default: piolet.y@gmail.com]"
  read -r GIT_EMAIL
  GIT_LOGIN="${GIT_LOGIN:-Youenn Piolet}"
  GIT_EMAIL="${GIT_EMAIL:-piolet.y@gmail.com}"
  echo "[user]"
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

## [VIM]
installVim () {
  echo "[VIM]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/vim/vimrc"  "${HOME}/.vimrc"
  makelink "${MIN_PATH}/vim"        "${HOME}/.vim"
  makelink "${MIN_PATH}/nvim"       "${HOME}/.config/nvim"
  echo
  return
}

## [NVIM]
installNVim () {
  echo "[NVIM]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/nvim"       "${HOME}/.config/nvim"
  if [ ! -f "${HOME}/.cache/wal/colors-wal.vim" ]; then
    echo "  Cheating the absence of pywal for the colorscheme..."
    mkdir -p "${HOME}/.cache/wal" 2>/dev/null
    cp "${MIN_PATH}/.walcachefornvim" "${HOME}/.cache/wal/colors-wal.vim"
  fi
  echo
  return
}

## [HTOP]
installHtop () {
  echo "[HTOP]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/htop/htoprc" "${HOME}/.config/htop/htoprc"
  echo
  return
}

## [I3]
installI3 () {
  echo "[I3]"
  echo "  Linking i3, picom, polybar, rofi, rofi-pass configuration files..."
  makelink "${MIN_PATH}/i3"         "${HOME}/.config/i3"
  makelink "${MIN_PATH}/picom"      "${HOME}/.config/picom"
  makelink "${MIN_PATH}/polybar"    "${HOME}/.config/polybar"
  makelink "${MIN_PATH}/rofi"       "${HOME}/.config/rofi"
  makelink "${MIN_PATH}/rofi-pass"  "${HOME}/.config/rofi-pass"
  echo
  return
}

## [ZSH]
installZSH ()
{
  echo "[ZSH]"
  echo "  Linking configuration files..."
  makelink "${MIN_PATH}/zsh/zshrc"    "${HOME}/.zshrc"
  makelink "${MIN_PATH}/zsh/p10k.zsh" "${HOME}/.p10k.zsh"
  if [ ! -e "${OHMY_PATH}" ]; then
  echo "  Downloading oh-my-zsh..."
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${OHMY_PATH}"
  fi
  echo "  Creating custom aliases file in ~/.aliases.local ..."
  touch ~/.aliases.local > /dev/null 2>&1
  echo ""
  return
}

## [GTK-3.0]
# Useful for terminator configuration
installGTK3 ()
{
  echo "[GTK3]"
  echo "  Linking GTK3 configuration files..."
  makelink "${MIN_PATH}/gtk-3.0/gtk.css" "${HOME}/.config/gtk-3.0/gtk.css"
  echo ""
  return
}

## [MINIMICS]
installMINIMICS () {
  echo "[MINIMICS]"
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

echo "You will find backups in ${_BACKUPDIR}."
echo
# Install configuration symlinks
# ZSH comes first
[ "$INST_MINIMICS" == "true" ]   && installMINIMICS

[ "$INST_ZSH" == "true" ]   && installZSH
[ "$INST_GIT" == "true" ]   && installGit

[ "$INST_BASH" == "true" ]  && installBash
[ "$INST_DUNST" == "true" ] && installDunst
[ "$INST_GTK3" == "true" ]  && installGTK3
[ "$INST_HTOP" == "true" ]  && installHtop
[ "$INST_I3" == "true" ]    && installI3
[ "$INST_NVIM" == "true" ]  && installNVim
[ "$INST_TW" == "true" ]    && installTW
[ "$INST_VIM" == "true" ]   && installVim
