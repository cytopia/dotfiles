# dotfiles

**[TL;DR](#tldr)** | 
**[What is included?](#what-is-included)** | 
**[How to apply?](#how-to-apply)** | 
**[Screenshots](#screenshots)**

These are all of my personal hand-crafted and non-bloated dotfiles I use at home as well as at work.

Before applying my dotfiles on an untouched system, I provision it in one go with **[ansible-debian](https://github.com/cytopia/ansible-debian)**.


## TL;DR
```bash
$ ./install.sh
```


## What is included?

| dotfile   | description |
|-----------|-------------|
| [autorunner](https://github.com/cytopia/autorunner) | Configurable and notification aware autostart helper |
| [bash](https://www.gnu.org/software/bash) | Shell configuration files |
| [compton](https://github.com/chjj/compton) | Compositor for Xorg |
| [ctags](http://ctags.sourceforge.net) | Generate tag files for source code. Integrates well into vim and neovim |
| [dunst](https://dunst-project.org) | Notification manager for i3-wm |
| [git](https://git-scm.com) | gitconfig |
| [gnupg](https://gnupg.org) | gnupg configuration |
| [gtk](https://www.gtk.org) | GTK 2.0 and GTK 3.0 theme configuration |
| [i3](https://i3wm.org) | i3 / i3-gaps configuration |
| [i3blocks](https://github.com/vivien/i3blocks) | i3blocks (status bar for i3) configuration |
| [neovim](https://neovim.io) | The last editor |
| [profanity](http://www.profanity.im) | Console based XMPP client |
| [qt](https://www.qt.io) | QT theme configuration |
| [readline](https://tiswww.case.edu/php/chet/readline/rltop.html) | Terminal key configuration |
| [redshift](http://jonls.dk/redshift) | Turns the screen red when working during night. Keeps your eyes intact |
| [sublime](https://www.sublimetext.com) | Fast gui-based editor |
| [sxiv](https://github.com/muennich/sxiv) | Small, fast and low-dependency image viewer with vim binding |
| [thunar](https://docs.xfce.org/xfce/thunar/start) | Gui-based and leight-weight file explorer |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [X11](https://www.x.org/wiki) | X11 configuration files (Xresources, Xmodmap, xinitrc and xsession).<br/> They also configure dpi, fonts, colors, rofi and urxvt |
| [xdg](https://specifications.freedesktop.org/mime-apps-spec) | Sets my prefered default applications |
| [zathura](https://pwmt.org/projects/zathura) | Small, fast and low-dependency pdf viewer with vim bindings |


## How to apply?
Running `install.sh` will just symlink every configuration file from this repository to its respective location. Before doing so it will take care about confirmation and backups.

1. Each symlink must be confirmed and can be skipped
2. Backing up the currently existing config file to `~/dotfiles-backup_<YYY-MM-DD_hh_mm_ss>/`

```bash
# Install with confirmation
$ ./install.sh

Symlink bash? (Y/n)
Symlink compton? (Y/n)
Symlink ctags? (Y/n)
Symlink dunst? (Y/n)
...
```

You can also run everything without confirmation by supplying `-y` argument to the `install.sh` script.
```bash
# Install without confirmation and always assume yes
$ ./install.sh -y
```


## Screenshots

#### Rofi
[![screenshot](.github/screenshot-01.jpg)](.github/screenshot-01.jpg)

#### urxvt
[![screenshot](.github/screenshot-02.jpg)](.github/screenshot-02.jpg)

#### Thunar
[![screenshot](.github/screenshot-03.jpg)](.github/screenshot-03.jpg)

#### Neovim
[![screenshot](.github/screenshot-04.jpg)](.github/screenshot-04.jpg)

#### Sublime Text 3
[![screenshot](.github/screenshot-05.jpg)](.github/screenshot-05.jpg)

#### Gimp & LibreOffice
[![screenshot](.github/screenshot-06.jpg)](.github/screenshot-06.jpg)
