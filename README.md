# Arch-Dotfiles (Yonatan Shaked <https://yonatanshaked.com>'s dotfiles)
My dot files for arch linux

![Screenshot](static/hyprland_ys.png)

---

## Setup

> ⚠️ Assumes Arch linux was installed with archinstall script and Hyprland chosen as DE.

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/arch-dotfiles.git
cd arch-dotfiles
```

### 2. Install official repository packages
All explicitly required pacman packages are listed in:

```
static/pkgs.txt
```

Install them with:
```bash
sudo pacman -S --needed - < static/pkgs.txt
```

### 3. Install `yay` (AUR helper)
```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
```

### 4. Install AUR packages
AUR packages are listed in:

```
static/aur_pkgs.txt
```

Install them with:
```bash
yay -S --needed - < static/aur_pkgs.txt
```

### 5. Apply dotfiles

symlinks:
```bash
ln -sf Arch-Dotfiles/.config/* ~/.config/
```

### 6. Setup NvChad
```bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```

### 7. Change default shell to Zsh
```bash
chsh -s /bin/zsh
```

Log out and back in for it to take effect.

### 8. Reboot
```bash
reboot
```
---

## Default Desktop Artwork

Thomas Thiemeyer's *The Road to Samarkand* ([fb](https://www.facebook.com/t.thiemeyer/), [insta](https://www.instagram.com/tthiemeyer/), [shop](https://www.redbubble.com/de/people/TThiemeyer/shop))
