# sxiv image viewer

https://wiki.archlinux.org/index.php/Sxiv

## Status bar

The information displayed on the left side of the status bar can be replaced with the output of a user-provided script, which is called by sxiv whenever an image gets loaded. The path of this script is $XDG_CONFIG_HOME/sxiv/exec/image-info and the arguments given to it are: 1) path to image file, 2) image width, 3) image height.
