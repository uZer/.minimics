.minimics
=========

> Use at your own risk
> The bundle is not complete

Minimalistic dotfiles for linux environment.
Easy to use, trying to avoid overkill plugins I'll never find the usage more than
one time in a year.

## How to use this and not to use this

I recommend you not to use this repository, but to build your own fork with your
settings. This repository is not maintained for stability but only to fulfill my
needs at a specific moment.

If you just plan to `git clone` and say yolo as many of my friends did these last
years, please make sure to run setup.sh or replace manually my name in .gitconfig
file...

## Content

This bundle contains:

+ Git dotfile model (you should customize it with setup script or edit the file)
+ Vim configuration with vundle, neocomplete and syntastic (disabled by default)
+ ZSH configuration files with oh-my-zsh autoinstall
+ Custom aliases
+ Solarized dircolors submodule (git submodule init / git submodule update)
+ i3 configuration files and other X and Archlinux related configuration files
+ Cygwin configuration files with solarized colorscheme

Non-solarized terminal are supported with some minor changes in colorschemes.
Non-powerline fonts are supported, but by default powerline chars are used in vim
and zsh. You can ajust this according to your needs.

This bundle uses:
+ Sexy visual bar for vim [vim-airline](https://github.com/bling/vim-airline)
+ Bundle management solution for vim [vundle](https://github.com/gmarik/vundle)
+ gitconfig from [scyn-conf](https://github.com/scyn-conf/conf)

This bundle can include:
+  solarize dircolors for [solarized terminals]() (facultative)
+ [powerline](https://github.com/Lokaltog/powerline) fonts (facultative)


## Installation

.minimics is very easy to install. You just need to have git installed on you
system. There is an autoinstall script in your .minimics folder. To install,
just perform :

    git clone https://github.com/uZer/.minimics.git ~/.minimics
    ~/.minimics/setup.sh

A backup of your old configuration files is automatically made in your minimics
folder.

If you plan to use minimics for your desktop/i3 environment, you may have extra
packages to compile/install

## Usage and configuration

#### Vim

There are plenty of usefull keyboard mapping in the vimrc configuration file.

My vim configuration will remove end-of-line trailing whitespaces each time you
save a document. If you want to disable this feature, edit your .vimrc and
comment the line containing:

    autocmd BufWrite * :call DeleteTrailingWS()

Leader command is `<space>` by default.
To update vundle plugins, you can just run `:PluginUpdate`

Useful shorcuts:

To paste a block of text, use paste mode: `<leader>pp`
To enable syntax check, please type `<leader>sc` out of edit mode.
Tab management:    `<leader>tn` (tab new) and `<leader>tc` (tab close)
Window management: `<leader>wn` (win new) and `<leader>wc` (win close)
Move from tab to tab / window to window with `<leader>j or k, h, l`.

#### Bash

Coming soon.

#### ZSH

Using oh-my-zsh bundle and custom aliases.

Also using powerline zsh configuration file, if you don't have any powerline
installed please comment the appropriated line in your .zshrc

#### Git config

See the .gitconfig file in your home directory for usefull git shocuts.
Please make sure you changed the name of your user in your gitrc file

#### Colors

If you use solarized terminal configurations, you can enable solarized colors in
the setup script (comment or uncomment the variables). At any time if your
unhappy with some color configuration, you can edit the configuration.
More info coming soon.

## Uninstall

If for any reason you want to uninstall .minimics partially or completely, you
just have to unlink the unwanted configuration files in your home directory.

    unlink ~/.bashrc

