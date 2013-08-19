#!/bin/bash
# Install dotfiles for current user
#
# Youenn Piolet 2013
# <piolet.y@gmail.com>

###############################################################################
# ENVIRONMENT

# Install selection
INST_GIT="true"     # Enable Git Config install
INST_VIM="true"     # Enable Vim config install
INST_ZSH="true"     # Enable ZSH config install
INST_BASH="true"    # Enable bash config install
INST_LSC="true"     # Enable LS Colors config install
# TODO Make params

# Dotfiles path
MIN_PATH="$HOME/.minimics"

# Backup dir in ~/.minimics/.backup.<timestamp>
_BACKUPDIR="$MIN_PATH/.backup.`date +%s`"

# Do you have a solarized configured terminal ?
IS_SOLARIZED="true"

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

# [GIT]
# Linking needed files
installGit ()
{
    echo "[GIT]"
    echo "  Linking git configuration files..."
    makelink $MIN_PATH/git/gitconfig $HOME/.gitconfig
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

    return
}

# [ZSH]
# Linking zsh configuration files
# Retrieving oh-my-zsh
installZSH ()
{
    echo "[ZSH]"

    echo "  Linking zsh configuration files..."

    echo ""
    return
}

# [LSC]
# Linking new ls colors
installLSC ()
{
    echo "[LSC]"

    echo "  Linking ls_colors configuration files..."

    echo ""
    return
}

# [BASH]
# Linking bash config
installBash ()
{
    echo "[BASH]"

    echo "  Linking bash configuration files..."

    echo ""
    return
}

###############################################################################

MY_DIR=`pwd`
cd

# Proceed installation
[ "$INST_GIT" == "true" ] && installGit
[ "$INST_VIM" == "true" ] && installVim
[ "$INST_ZSH" == "true" ] && installZSH
[ "$INST_LSC" == "true" ] && installLSC
[ "$INST_LSC" == "true" ] && installBash

# Update submodules
cd $MIN_PATH
git submodule init
git submodule update

# Install other vim bundles
vim +BundleInstall +qall

cd "$MY_DIR"

exit 0
