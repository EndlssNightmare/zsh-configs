#!/bin/bash

# Define light green color
LIGHT_GREEN="\033[1;32m"
RESET_COLOR="\033[0m"

# Ask the user which network interface to configure
echo -e "${LIGHT_GREEN}Please enter your network interface that you want to show on terminal (e.g., eth0, wlan0):${RESET_COLOR}"
read -r NETWORK_INTERFACE

# Export the environment variable
export NETWORK_INTERFACE
echo -e "${LIGHT_GREEN}Selected network interface: $NETWORK_INTERFACE has been saved as an environment variable NETWORK_INTERFACE.${RESET_COLOR}"

# Update the package list
echo -e "${LIGHT_GREEN}Updating package list...${RESET_COLOR}"
sudo apt update

# Install necessary packages
echo -e "${LIGHT_GREEN}Installing required packages...${RESET_COLOR}"
sudo apt install -y neofetch zsh chafa

# Install Oh My Zsh
echo -e "${LIGHT_GREEN}Installing Oh My Zsh...${RESET_COLOR}"
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || exit 1

# Clone Oh My Zsh plugins
echo -e "${LIGHT_GREEN}Cloning Oh My Zsh plugins...${RESET_COLOR}"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

# Copy the .zshrc file to the user's home directory
echo -e "${LIGHT_GREEN}Copying .zshrc to the user's home directory...${RESET_COLOR}"
cp .zshrc ~/.zshrc

# Copy the lukerandall.zsh-theme file to the Oh My Zsh themes directory
echo -e "${LIGHT_GREEN}Copying lukerandall.zsh-theme to the Oh My Zsh themes directory...${RESET_COLOR}"
cp lukerandall.zsh-theme ~/.oh-my-zsh/themes/lukerandall.zsh-theme

neofetch

# Copy the Neofetch configuration file
echo -e "${LIGHT_GREEN}Copying config.conf to the Neofetch configuration directory...${RESET_COLOR}"
cp config.conf ~/.config/neofetch/config.conf

# Copy fonts to the system fonts directory
echo -e "${LIGHT_GREEN}Copying fonts to the /usr/share/fonts/ directory...${RESET_COLOR}"
sudo cp Fonts/*.ttf /usr/share/fonts/

echo -e "${LIGHT_GREEN}Creating directory '/opt/neofetch-images' and moving images:${RESET_COLOR}"
sudo mkdir /opt/neofetch-images
sleep 1
cd ~/zsh-configs/Images
sleep 1
sudo mv *.jpg /opt/neofetch-images

# Change the default shell to Zsh
echo -e "${LIGHT_GREEN}Changing the default shell to Zsh...${RESET_COLOR}"
chsh -s $(which zsh)

# Display system information
echo -e "${LIGHT_GREEN}Installation complete! Run 'source ~/.zshrc' to start the new shell.${RESET_COLOR}"
