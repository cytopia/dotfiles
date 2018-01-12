# xdg-open

* https://wiki.archlinux.org/index.php/Default_applications
* https://unix.stackexchange.com/questions/77136/xdg-open-default-applications-behavior

Query defaut application for directory

## Get default applications
```shell
xdg-mime query default inode/directory
xdg-mime query default text/html
```

## Set default applications

```shell
# Images
xdg-mime default ximage.desktop image/png
xdg-mime default ximage.desktop image/jpg
xdg-mime default ximage.desktop image/jpeg

# Browser
xdg-settings set default-web-browser chromium.desktop
```

