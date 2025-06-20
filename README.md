# Dotfiles

Copy what you want

# Packages

```sh
yay -S hyprland hyprlock hypridle wl-clipboard dunst waybar swww rofi kitty fish wev swayimg mpv yt-dlp \
    cmus thunar thunar-volman gvfs htop pipewire pipewire-pulse pipewire-alsa alsa-utils \
    ttf-harmonyos-sans ttf-jetbrains-mono ttf-jetbrains-mono-nerd iwd impala bluetui \
    nvtop chafa fastfetch kernel-modules-hook downgrade wiremix-git xdg-desktop-portal-wlr \
    xdg-desktop-portal-hyprland hyprshade
```

## AmneziaVPN

Install:

```sh
yay -S amneziawg-go openresolv amneziawg-tools
```

Up VPN:

```sh
sudo awg-quick up amnezia_for_awg.conf
```

Down VPN:

```sh
sudo awg-quick down amnezia_for_awg.conf
```

## Caching DNS

As described at [Systemd-resolved wiki](https://wiki.archlinux.org/title/Systemd-resolved):

```sh
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

```

## Other

```sh
sudo systemctl enable linux-modules-cleanup.service
```

## Heroes 3 HotA

Install packages:

```sh
yay -S umu-launcher lib32-pipewire lib32-gnutls
```

Install the game:
```sh
GAMEID="Heroes3_HotA" umu-run <path to installer>
```

Run the game:
```sh
GAMEID="Heroes3_HotA" UMU_RUNTIME_UPDATE=0 umu-run HD_Launcher.exe
```

(optional) Create desktop entry at `$HOME/.local/share/applications`:
```sh
cat > $HOME/.local/share/applications/Heroes3HotA.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Heroes 3
Path=$HOME/Games/umu/Heroes3_HotA/drive_c/Games/Heroes3_HotA
Exec=env GAMEID="Heroes3_HotA" UMU_RUNTIME_UPDATE=0 umu-run $HOME/Games/umu/Heroes3_HotA/drive_c/Games/Heroes3_HotA/HD_Launcher.exe
StartupNotify=true
Icon=$HOME/Games/umu/Heroes3_HotA/drive_c/Games/Heroes3_HotA/icon.png
Categories=Game
EOF

```
Also you need an icon for menu entry

# Vim

Just copy everything into your home. For complete vim installation run inside vim `:PlugInstall`
