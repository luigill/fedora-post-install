#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}


update_system(){
    sudo dnf upgrade -y
}

enable_rpmfusion(){
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf config-manager --enable fedora-cisco-openh264 -y
}

install_rpm(){

  echo -e "${VERDE}[INFO] - Instalando pacotes RPM${SEM_COR}"

    sudo dnf install curl git wget timeshift fastfetch eza bat gcc neovim tmux axel unzip postgresql-server steam -y
}


install_flatpaks(){

    echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

    flatpak install flathub com.discordapp.Discord -y
    flatpak install flathub com.spotify.Client -y
    flatpak install flathub net.lutris.Lutris -y
    flatpak install flathub com.heroicgameslauncher.hgl -y
    flatpak install flathub net.davidotek.pupgui2 -y
    flatpak install flathub com.obsproject.Studio -y
    flatpak install flathub org.qbittorrent.qBittorrent -y
    flatpak install flathub com.bitwarden.desktop -y
    flatpak install flathub md.obsidian.Obsidian -y
    flatpak install flathub com.stremio.Stremio -y
    flatpak install flathub com.github.johnfactotum.Foliate -y
    flatpak install flathub com.rafaelmardojai.Blanket -y
    flatpak install flathub com.protonvpn.www -y
    flatpak install flathub info.febvre.Komikku -y
    flatpak install flathub com.vscodium.codium -y
}

add_aliases(){

    echo -e "${VERDE}[INFO] - Adicionando os aliases${SEM_COR}"

    echo 'alias p3="python3"' >> ~/.bashrc
    echo 'alias nf="fastfetch"' >> ~/.bashrc
    echo 'alias up="sudo dnf upgrade -y && flatpak update -y && sudo dnf autoremove -y"' >> ~/.bashrc
    echo 'alias ls="eza --icons"' >> ~/.bashrc
    echo 'alias la="eza --icons -l"' >> ~/.bashrc
    echo 'alias cat="bat"' >> ~/.bashrc
}
 
install_mise(){

    echo -e "${VERDE}[INFO] - Instalando mise${SEM_COR}"

    curl https://mise.run | sh
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
    eval "$(~/.local/bin/mise activate bash)"
    ~/.local/bin/mise --version
    mise use --global node@20
    mise use --global python@3.11
}

install_starship(){

    echo -e "${VERDE}[INFO] - Instalando starship${SEM_COR}"

    curl -sS https://starship.rs/install.sh | sh
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
}

install_font(){
    axel -n 20 https://github.com/microsoft/cascadia-code/releases/download/v2404.23/CascadiaCode-2404.23.zip
    unzip ./CascadiaCode-2404.23.zip -d ./CascadiaCode-2404.23
    sudo mv ./CascadiaCode-2404.23/ttf/static/* /usr/share/fonts/
    fc-cache -f -v
}

install_media_codecs(){
    sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
    sudo dnf install lame\* --exclude=lame-devel -y
    sudo dnf group upgrade --with-optional Multimedia -y 
}

testes_internet
update_system
enable_rpmfusion
install_rpm
install_flatpaks
add_aliases
install_mise
install_starship
install_font
install_media_codecs


echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
