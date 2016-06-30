#!/bin/bash
# Install dotfiles for current user
#
# Youenn Piolet 2013
# <piolet.y@gmail.com>
###############################################################################
# ENVIRONMENT

# Install selection
INST_I3="true"      # Enable Git Config install
INST_GIT="true"     # Enable Git Config install
INST_VIM="true"     # Enable Vim config install
INST_ZSH="true"     # Enable ZSH config install
INST_BASH="true"    # Enable bash config install
INST_BSPWM="false"      # Enable Lemonbuddy config install
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

# [GIT]
# Linking needed files
installGit ()
{
    echo "[GIT]"
    echo "  Linking git configuration files..."
    makelink $MIN_PATH/git/gitconfig $HOME/.gitconfig
    echo "  What is your github login?"
    read GIT_LOGIN
    echo "  What is your github email?"
    read GIT_EMAIL
    echo "
    [user]
        name        = $GIT_LOGIN
        email       = $GIT_EMAIL  "
    git config --global user.name "$GIT_LOGIN"
    git config --global user.email "$GIT_EMAIL"
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

    echo ""
    return
}

# [i3]
# Linking i3 configuration files
installI3 ()
{
    echo "[I3]"

    echo "  Linking i3 configuration files..."
    makelink $MIN_PATH/i3/i3/ $HOME/.i3
    makelink $MIN_PATH/i3/i3status.conf $HOME/.i3status.conf

    echo ""
    return
}

# [ZSH]
# Linking zsh configuration files
# Retrieving oh-my-zsh
installZSH ()
{
    echo "[ZSH]"

    echo "  Linking zsh configuration files..."
    makelink $MIN_PATH/zsh/zshrc $HOME/.zshrc

    if [ ! -e $OHMY_PATH ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git $OHMY_PATH
    fi
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

# [LEMONBUDDY]
# Linking lemonbuddy config
installLemon ()
{
    echo "[Lemonbuddy]"

    echo "  Linking Lemonbuddy configuration files..."
    mkdir $HOME/.config > /dev/null 2>&1
    makelink $MIN_PATH/lemonbuddy $HOME/.config/lemonbuddy

    echo ""
    return
}

# [BSPWM]
# Linking lemonbuddy config
installBspwm ()
{
    echo "[BSPWM]"

    echo "  Linking bspwm configuration files..."
    mkdir $HOME/.config > /dev/null 2>&1
    makelink $MIN_PATH/sxhkd $HOME/.config/sxhkd

    echo ""
    return
}

# [SXHKD]
# Linking lemonbuddy config
installSxhkd ()
{
    echo "[SXHKD]"

    echo "  Linking sxhkd configuration files..."
    mkdir $HOME/.config > /dev/null 2>&1
    makelink $MIN_PATH/bspwm $HOME/.config/bspwm

    echo ""
    return
}
###############################################################################

MY_DIR=`pwd`

# Proceed installation
[ "$INST_GIT" == "true" ] && installGit
[ "$INST_VIM" == "true" ] && installVim
[ "$INST_ZSH" == "true" ] && installZSH
[ "$INST_LSC" == "true" ] && installLSC
[ "$INST_BASH" == "true" ] && installBash
[ "$INST_I3" == "true" ] && installI3
[ "$INST_BSPWM" == "true" ] && installBspwm; installSxhkd; installLemon;

# Update submodules
cd $MIN_PATH
git submodule init
git submodule update

# Install other vim bundles
# vim +BundleInstall +qall

# Adding local aliases file
touch $HOME/.aliases.local

echo
echo "If you don't have powerline installed,"
echo "please comment powerline call in your new zshrc file"
echo
echo "Installation complete!"

cd "$MY_DIR"
exit 0
