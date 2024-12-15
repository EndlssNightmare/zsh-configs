#!/bin/bash

# Define light green color
BLUE="\033[0;34m"
RED="\033[0;31m"
LIGHT_GREEN="\033[1;32m"
RESET_COLOR="\033[0m"

# Ask the user which network interface to configure
echo -e "${BLUE}Please enter your network interface that you want to show on terminal (e.g., eth0, wlan0): \c ${RESET_COLOR}"
read -r NETWORK_INTERFACE \n

# Export the environment variable
export NETWORK_INTERFACE
echo -e "${BLUE}Selected network interface: $NETWORK_INTERFACE has been saved as an environment variable NETWORK_INTERFACE.${RESET_COLOR}"

# Update the package list
echo -e "${BLUE}Updating package list...${RESET_COLOR}"
sudo apt update

# Install necessary packages
echo -e "${BLUE}Installing required packages...${RESET_COLOR}"
sudo apt install -y neofetch zsh chafa

# Install Oh My Zsh
echo -e "${BLUE}Installing Oh My Zsh...${RESET_COLOR}"
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || exit 1
sleep 2
sudo RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || exit 1

# Clone Oh My Zsh plugins
echo -e "${BLUE}Cloning Oh My Zsh plugins into user directory...${RESET_COLOR}"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

echo -e "${BLUE}Cloning Oh My Zsh plugins into root directory...${RESET_COLOR}"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-completions /root/.oh-my-zsh/custom/plugins/zsh-completions
sudo git clone https://github.com/zsh-users/zsh-history-substring-search /root/.oh-my-zsh/custom/plugins/zsh-history-substring-search

# Copy the .zshrc file to the user's home directory
echo -e "${BLUE}Copying .zshrc to home directory...${RESET_COLOR}\n"
cp .zshrc ~/.zshrc
sudo cp .zshrc /root/.zshrc


echo -e "${LIGHT_GREEN}Please choose the Zsh theme you would like to install:${RESET_COLOR}"
echo -e "1) lukerandall"
echo -e "2) duellj"
echo -e "${RESET_COLOR}Enter the number corresponding to the theme (1 or 2): \c"

# Inicia um loop para garantir que o usuário faça uma escolha válida
while true; do
    read -r THEME_CHOICE
    
    # Verifica a escolha do usuário
    if [[ "$THEME_CHOICE" == "1" ]]; then
        # Copia o tema lukerandall
        echo -e "${LIGHT_GREEN}Copying lukerandall.zsh-theme to the Oh My Zsh themes directory...${RESET_COLOR}\n"
        cp Themes/lukerandall.zsh-theme ~/.oh-my-zsh/themes/lukerandall.zsh-theme
	sleep 1
	sudo cp Themes/root-lukerandall.zsh-theme /root/.oh-my-zsh/themes/lukerandall.zsh-theme
        break  # Sai do loop se a escolha for válida

    elif [[ "$THEME_CHOICE" == "2" ]]; then
        # Copia o tema duellj
        echo -e "${LIGHT_GREEN}Copying duellj.zsh-theme to the Oh My Zsh themes directory...${RESET_COLOR}\n"
        cp Themes/duellj.zsh-theme ~/.oh-my-zsh/themes/lukerandall.zsh-theme
	sleep 1
	sudo cp Themes/root-duellj.zsh-theme /root/.oh-my-zsh/themes/lukerandall.zsh-theme
        break  # Sai do loop se a escolha for válida

    else
        # Caso a escolha seja inválida, avisa o usuário e repete a pergunta
        echo -e "${RED}Invalid choice! Please enter 1 or 2.${RESET_COLOR}"
        echo -e "${LIGHT_GREEN}Please choose the Zsh theme you would like to install:${RESET_COLOR}\n"
        echo -e "1) lukerandall"
        echo -e "2) duellj\n"
        echo -e "${LIGHT_GREEN}Enter the number corresponding to the theme (1 or 2):\c \n${RESET_COLO}"
    fi
done

neofetch

# Copy the Neofetch configuration file
echo -e "${BLUE}Copying config.conf to the Neofetch configuration directory...${RESET_COLOR}\n"
cp config.conf ~/.config/neofetch/config.conf
sudo cp config.conf /root/.config/neofetch/config.conf

# Copy fonts to the system fonts directory
echo -e "${BLUE}Copying fonts to the /usr/share/fonts/ directory...${RESET_COLOR}\n"
sudo cp Fonts/*.ttf /usr/share/fonts/

echo -e "${BLUE}Creating directory '/opt/neofetch-images' and moving images:${RESET_COLOR}\n"
sudo mkdir /opt/neofetch-images
sudo cp Images/*.jpg /opt/neofetch-images

# Change the default shell to Zsh
echo -e "${BLUE}Changing the default shell to Zsh...${RESET_COLOR}\n"

ZSH_PATH=$(which zsh)

chsh -s $ZSH_PATH
sudo chsh -s $ZSH_PATH root

# Display system information
echo -e "${LIGHT_GREEN}Installation complete! Run ${RESET_COLOR}${RED}'source ~/.zshrc'${RESET_COLOR}${LIGHT_GREEN} command to start the new shell.${RESET_COLOR}"
