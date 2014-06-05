.minimics
=========

> Do not use yet,
> The bundle is not ready.

Minimalistic dotfiles for linux environment.
Easy to use, no overkill plugins you'll never find the usage more than one time
a year.


## Content

This bundle contains:

+ Vim configuration files
+ Bash configuration files (coming soon)
+ ZSH configuration files for people who have taste (coming soon)
+ Git configuration file
+ Dircolors configuration (coming soon)

Non-solarized terminal are supported.
Non-powerlined font system are supported.

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

## Usage and configuration

#### Vim
There are plenty of usefull keyboard mapping in the vimrc configuration file.
There will be a shortcut section coming soon in the wiki.

My vim configuration will remove end-of-line trailing whitespaces each time you
save a document. If you want to disable this feature, edit your .vimrc and
comment the line containing:

    autocmd BufWrite * :call DeleteTrailingWS()


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
just have to unlink the configuration files in your home directory.

    unlink ~/.bashrc

