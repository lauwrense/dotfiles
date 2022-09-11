#! /usr/bin/env bash

arch_aur_install() {

    AUR_PACKAGES={
        cava
        brave-bin
        navi
        slides
        nerd-fonts-jetbrains-mono
    }

    sudo pacman -S --needed base-devel
    
    echo "installing paru"
    cd
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    echo "cleaning up"
    sudo rm -rf paru

    sudo paru -S $[AUR_PACKAGES[@]]
}

arch_install() {
    PACKAGES={
        ttf-jetbrains-mono

        # Dev
        alacritty
        neovim

        clang
        gcc
        zig
        python
        bun

        # Utils
        zsh

        ripgrep
        sd
        fd
        bat
        exa
        zoxide
        pandoc

        curl
        wget
        rsync
        unrar
        unzip
        zip
        stow
        bottom
        starship
        reflector

        # Vid & Audio
        mpv
        mpd
        ncmpcpp

        # WM
        sway
        swaylock
        swayidle
        swaybg
        wallutils
        dunst
        bemenu
        waybar
        brightnessctl
        gammastep
        grim
        slurp
        xdg-desktop-portal-wlr
        xorg-xwayland

        # Extras
        macchina
    }


    sudo pacman -Syyu
    sudo pacman -S $[PACKAGES[@]]

    curl https://sh.rustup.rs -sSf | sh -s -- --profile default --default-toolchain stable
    curl -sSL https://install.python-poetry.org | python3 -

}

dotfiles_install() {

}