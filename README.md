.minimics
=========

![img](https://raw.githubusercontent.com/uZer/.minimics/master/preview.png)


A pywal based desktop environment

> Use at your own risk

## How to use and not to use this repository

I recommend you NOT to use this repository, but to build your own fork with your
own settings. This repository is not maintained for stability but only to
fulfill my needs at a specific moment, on various computers. My current
computers where I use .minimics are:

- a Ubuntu WSL2 on Windows 11
- Multiple Archlinux, graphic and non graphic
- Raspberry Pi with multiple distros
- MacOSX High Sierra
- A phone with Termux

If you just plan to `git clone` and say yolo as many of my friends did over
these last 10 years, please make sure to run setup.sh or replace manually my
name in .gitconfig file... :)

## Content

This bundle contains:

+ Git dotfile model (you should customize it with setup script or edit the file)
+ NeoVim configuration with a lot of useful plugins.
+ ZSH configuration files with oh-my-zsh autoinstall
+ Custom aliases and local aliases support in `~/.aliases.local`
+ i3 configuration files
+ other X and Archlinux related configuration
  + a custom lockscreen
  + ctags
  + dunst
  + picom
  + polybar
  + rofi
  + some usefull scripts in `bin/`
+ pywal16 wrapper and custom colorschemes

Everything is built around pywal or pywal16 for color selection.

## Installation

.minimics is very easy to install. You just need to have git installed on you
system. There is an autoinstall script in your .minimics folder. To install,
just perform :

    git clone https://github.com/uZer/.minimics.git ~/.minimics
    ~/.minimics/setup.sh

A backup of your old configuration files is automatically made in your minimics
folder.

If you plan to use minimics for neovim or a desktop/i3 environment, you will
have extra packages to compile/install. (TODO: a list of dependencies)

## Usage and configuration

#### pywal16

I recommend you to use the pywal16 fork.

#### NeoVim

See init.nvim.

The lua configuration is splitted, you may find useful information in various
files. Install dependencies with `:PackerSync` and `:MasonInstallAll`

#### Bash

I don't use bash except for copy pasting stuff, so my bashrc is minimal.

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

## Uninstall

If for any reason you want to uninstall .minimics partially or completely, you
just have to unlink the unwanted configuration files in your home directory.

    unlink ~/.bashrc
