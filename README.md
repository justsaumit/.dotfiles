# .dotfiles
Personal Arch Linux dot files


## Installation guide
1. After a base install and setting up Xorg display server alongwith xf86-video-intel video driver 
2. git clone [.dotfiles](https://github.com/Saumit-D/.dotfiles), [dwm](https://github.com/Saumit-D/dwm), [st](https://github.com/Saumit-D/st) and [dwmblocks](https://github.com/Saumit-D/dwmblocks)
3. Install dwm and st. Install dwmblocks later because it will cause the system to crash on login due to the absence of certain fonts and not being able to access the listed scripts
4. Copy/Replace the dotfiles
5. Install the necessary fonts: ubuntu mono, deja vu mono,terminal,hack font, spoqa, jetbrainsmono, ocr-a, joypixels 
6. Make all the scripts executable by chmod +x command //Always make sure that a script is KISS and not malicious in nature before making it executable.
7. Very important to replace the standard "libxft" with "libxft-bgra-git" for color emoji support and to avoid crash on login.
8. necessary programs/dependencies for the scripts to work that aren't install by default: pamixer, xwallpaper, pywal, xdottool
9. sxhkd: xorg-backlight needs xf86-video-intel to function else would crash and logout.
10. fstab: requires ntfs-3g



## Brief look
![857ke-amnb8](https://user-images.githubusercontent.com/79687674/141660827-528277f8-dbf6-4274-a3d6-0fc84da096e6.gif)

## License
Since dwm, st and other suckless tools come under
[MIT](https://choosealicense.com/licenses/mit/) License, this repo also comes under MIT License. If it were my own setup, made from scratch I'd probably one use one of the GPL Licenses.



