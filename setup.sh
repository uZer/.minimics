#!/bin/bash
# Symlinks dotfiles for current user, creates backup of previous dotfiles.
# This script is so 2005 and hates you as much as you do hate it.
###############################################################################
# ENVIRONMENT

# Install selection
INST_I3="true"      # Enable i3 Config install
INST_GIT="false"    # Enable git Config install
INST_VIM="true"     # Enable vim config install
INST_ZSH="true"     # Enable zsh config install
INST_HTOP="true"    # Enable htop config install
INST_BASH="false"   # Enable bash config install
INST_DUNST="true"   # Enable Dunst config install
INST_TW="true"      # Enable Taskwarrior config install
# TODO Make params

# Dotfiles path
MIN_PATH="$HOME/.minimics"
OHMY_PATH="$HOME/.oh-my-zsh"

# Backup dir in ~/.minimics/.backup.<timestamp>
_BACKUPDIR="$MIN_PATH/.backup.`date +%s`"

###############################################################################
# Configuration file linking method, taking care of old conf if necessary
# backing it up in a new directory : $_BACKUPDIR
makelink ()
{
  _SOURCE="$1"
  _DEST="$2"

    # Source doesn't exist
    if [ ! -e "$_SOURCE" ]; then
      echo "ERROR: Source file doesn't exist" 1>&2
      return 1
    fi

    # Destination exists as a symbolic link
    if [ -L "$_DEST" ]; then
      echo "  Unlinking $_DEST..."

        # Unlink and test
        rm ${_DEST}
        [ "$?" -ne "0" ] && "ERROR: Can't unlink file." 1>&2 && return 2
    fi

    # Destination exists as a file or folder
    if [ -e "$_DEST" ]; then
      echo "  Making backup dir $_DEST..."

        # Created backup folder
        mkdir -p ${_BACKUPDIR} 2>/dev/null

        # Move the file/folder and check results
        mv ${_DEST} ${_BACKUPDIR}
        [ "$?" -ne "0" ] \
          && "ERROR: Can't make backup. Please check permissions." 1>&2 \
          && return 3
    fi

    # Make the new link
    ln -s $_SOURCE $_DEST
    return 0
  }

# [DUNST]
# Linking needed files
installDunst ()
{
  echo "[DUNST]"
  echo "  Linking dunst configuration files..."
  makelink $MIN_PATH/dunst $HOME/.config/dunst
  echo ""
  return
}

# [TASKWARRIOR]
# Linking needed files
installTW ()
{
  echo "[TASKWARRIOR]"
  echo "  Linking taskwarrior configuration files..."
  makelink "$MIN_PATH/taskwarrior/taskrc" "$HOME/.taskrc"
  echo ""
  return
}

# [GIT]
# Linking needed files
installGit ()
{
  echo "[GIT]"
  echo "  Linking git configuration files..."
  makelink $MIN_PATH/git/gitconfig $HOME/.gitconfig
  echo "  What is your github login? [Default: uZer]"
  read GIT_LOGIN
  echo "  What is your github email? [Default: piolet.y@gmail.com]"
  read GIT_EMAIL
  GIT_LOGIN=${GIT_LOGIN:-uZer}
  GIT_EMAIL=${GIT_EMAIL:-piolet.y@gmail.com}
  echo "
  [user]
  name        = $GIT_LOGIN
  email       = $GIT_EMAIL  "
  git config --global user.name "$GIT_LOGIN"
  git config --global user.email "$GIT_EMAIL"
  echo "export GIT_USERNAME=${GIT_LOGIN}" >> ~/.aliases.local
  echo "export GIT_EMAIL=${GIT_EMAIL}" >> ~/.aliases.local
  echo ""
  return
}

# [VIM]
# Linking vim configuration files
# Retrieving vundle
installVim ()
{
  echo "[VIM]"
  echo "  Linking vim configuration files..."

  # Make links
  makelink "$MIN_PATH/vim/vimrc" "$HOME/.vimrc"
  makelink "$MIN_PATH/vim" "$HOME/.vim"
  makelink "$MIN_PATH/nvim" "$HOME/.config/nvim"

  echo ""
  return
}

installHtop ()
{
  # Make links
  makelink "$MIN_PATH/htop/htoprc" "$HOME/.config/htop/htoprc"
  echo ""
  return
}

# [i3]
# Linking i3 configuration files
installI3 ()
{
  echo "[I3]"

  echo "  Linking i3 configuration files..."
  makelink $MIN_PATH/i3 $HOME/.config/i3
  makelink $MIN_PATH/picom $HOME/.config/picom
  makelink $MIN_PATH/polybar $HOME/.config/polybar
  makelink $MIN_PATH/rofi $HOME/.config/rofi

  echo ""
  return
}

# [ZSH]
# Linking zsh configuration files
# Retrieving oh-my-zsh
installZSH ()
{
  echo "[ZSH]"
  ZSH_CUSTOM=~/.oh-my-zsh/custom

  echo "  Linking zsh configuration files..."
  makelink $MIN_PATH/zsh/zshrc $HOME/.zshrc

  if [ ! -e $OHMY_PATH ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $OHMY_PATH
  fi

  echo "  Creating custom aliases file in ~/.aliases.local ..."
  touch ~/.aliases.local > /dev/null 2>&1
  echo ""
  return
}

# [BASH]
# Linking bash config
installBash ()
{
  echo "[BASH]"

  echo "  Linking bash configuration files..."
  makelink $MIN_PATH/bash/bashrc $HOME/.bashrc

  echo ""
  return
}

# [POLYBAR]
# Linking polybar config
installPolybar ()
{
  echo "[POLYBAR]"

  echo "  Linking polybar configuration files..."

  echo ""
  return
}

###############################################################################

MY_DIR=`pwd`

# Install configuration symlinks
mkdir -p $HOME/.config > /dev/null 2>&1

[ "$INST_ZSH" == "true" ]     && installZSH
[ "$INST_VIM" == "true" ]     && installVim
[ "$INST_HTOP" == "true" ]    && installHtop
[ "$INST_BASH" == "true" ]    && installBash
[ "$INST_I3" == "true" ]      && installI3
[ "$INST_DUNST" == "true" ]   && installDunst
[ "$INST_TW" == "true" ]      && installTW
[ "$INST_GIT" == "true" ]     && installGit

# Update submodules
cd $MIN_PATH
git submodule init
git submodule update

# Install other vim bundles
# vim +BundleInstall +qall

cd "$MY_DIR"
