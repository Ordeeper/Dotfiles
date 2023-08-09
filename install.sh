#!/usr/bin/env bash

path=$(pwd)

clear
echo ""
echo ""
echo " ▒█████   ██▀███  ▓█████▄ ▓█████ ▓█████  ██▓███  ▓█████  ██▀███  "
echo "▒██▒  ██▒▓██ ▒ ██▒▒██▀ ██▌▓█   ▀ ▓█   ▀ ▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒"
echo "▒██░  ██▒▓██ ░▄█ ▒░██   █▌▒███   ▒███   ▓██░ ██▓▒▒███   ▓██ ░▄█ ▒"
echo "▒██   ██░▒██▀▀█▄  ░▓█▄   ▌▒▓█  ▄ ▒▓█  ▄ ▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄  "
echo "░ ████▓▒░░██▓ ▒██▒░▒████▓ ░▒████▒░▒████▒▒██▒ ░  ░░▒████▒░██▓ ▒██▒"
echo "░ ▒░▒░▒░ ░ ▒▓ ░▒▓░ ▒▒▓  ▒ ░░ ▒░ ░░░ ▒░ ░▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░"
echo "  ░ ▒ ▒░   ░▒ ░ ▒░ ░ ▒  ▒  ░ ░  ░ ░ ░  ░░▒ ░      ░ ░  ░  ░▒ ░ ▒░"
echo "░ ░ ░ ▒    ░░   ░  ░ ░  ░    ░      ░   ░░          ░     ░░   ░ "
echo "    ░ ░     ░        ░       ░  ░   ░  ░            ░  ░   ░     "
echo "                   ░                                             "
echo ""
echo "                   https://github.com/Ordeeper                   "
echo ""
echo ""
echo "Detecting Operating System..."
sleep 1 && clear

packages_arch="stow alsa-utils brave-bin firefox htop cava clipmenu xsel xclip clipnotify cmatrix corrupter-bin cowsay cpulimit dbus-python discord dmidecode docker dunst exfatprogs feh fish flameshot scrot gnu-netcat i3-wm i3lock-color i3-gnome-pomodoro-git imagemagick inotify-tools kitty ksshaskpass libva-intel-driver lxappearance mesa mpv dropbox nemo nemo-dropbox neofetch obsidian picom pipewire-alsa pipewire-pulse polybar python-gobject python-pip npm python-pywal python-pywalfox wal-telegram-git telegram-desktop ranger redshift rofi simplescreenrecorder slop sweet-gtk-theme-dark candy-icons-git tesseract tesseract-data-osd tesseract-data-eng tesseract-data-por tldr tmux ttf-maple ttf-hack-nerd ttf-icomoon-feather noto-fonts-emoji unzip vulkan-icd-loader vulkan-intel wireplumber wmctrl xdotool yad xorg-xwininfo xdg-user-dirs xorg-server xorg-xinit xorg-xev zbar lm_sensors man-db man-pages neovim"

if grep -q "hypervisor" /proc/cpuinfo; then
    packages_arch=$(echo "$packages_arch" | sed 's/picom//g')
fi

distro=$(cat /etc/os-release | awk -F '=' '/^ID=/ {print $2}')

case $distro in
    "arch")
        echo "You are on Arch!"

        if ! command -v yay &> /dev/null; then
            echo "Installing Yay..."
            rm -rf /tmp/yay &> /dev/null
            git clone https://aur.archlinux.org/yay.git /tmp/yay
            cd /tmp/yay
            makepkg -sric --noconfirm
            cd $path
            rm -rf /tmp/yay
            sleep 1 && clear
        fi

        echo "Installing Programs..."
        yay -Syu ${packages_arch} --needed --noconfirm
        sleep 1 && clear

        echo "Organizing Dotfiles and Configurations..."
        xdg-user-dirs-update
        stow -d .. -t $HOME Dotfiles --ignore=install.sh
        touch $HOME/.xinitrc
        if ! grep -wq "exec i3" $HOME/.xinitrc; then
            echo "exec i3" >> $HOME/.xinitrc
        fi
        if ! echo $SHELL | grep -q fish; then
            chsh -s /usr/bin/fish
        fi
        sleep 1 && clear

        read -p "Do you want to use a display manager? (y/n) " answer
        sleep 1 && clear

        case $answer in
            "y"|"Y")
                echo "Installing Display Manager..."
                yay -S lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-glorious --needed --noconfirm
                sudo sed -i 's/^#\{0,1\}greeter-session\s*=\s*\(.*\)/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
                sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
                sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
                systemctl enable lightdm.service
                ;;
            "n"|"N")
                echo "Skipping..."
                ;;
            *)
                echo "Invalid Answer, skipping..."
                ;;
        esac
        ;;
    "void")
        echo "You are on Void!"
        # TODO: Add support to Void
        exit 1
        ;;
    *)
        echo "Operating system unsupported for this script."
        exit 1
        ;;
esac

sleep 1 && clear

while true; do
    ls $HOME/Pictures/Wallpapers
    read -rp "Which wallpaper do you want? " answer
    wallpaper=$(ls $HOME/Pictures/Wallpapers | grep -im 1 "${answer}")

    if [ $? -eq 0 ]; then
        wal -i $HOME/Pictures/Wallpapers/"${wallpaper}"
        sleep 1 && clear
        break
    fi
    echo "Invalid Wallpaper Selection. Please try again."
    sleep 1 && clear
done

echo "All done!"
read -p "Do you want to reboot for changes to take effect? (y/n) " answer

case $answer in
    "y"|"Y")
        reboot
        ;;
    "n"|"N")
        exit 0
        ;;
    *)
        echo "Invalid Answer, skipping..."
        exit 0
        ;;
esac
