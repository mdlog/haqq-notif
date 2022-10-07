#!/bin/bash
echo "================================================================================"
echo -e "\033[0;35m"
echo " :::       :::   :::::::::       :::           :::::::::      ::::::::::    ";
echo " ::: +   + :::   :::     ::::    :::          ::::    :::    :::       ::   ";
echo " :+: ++ ++ :+:   :+:     :+::+   ::+          +::      ::+   :+:            ";
echo " +:+  +:+  +:+   ++:      ++:+   +:+         :++       ++:   :+:+#######  ";
echo " +#+       +#+   +++      #+++   #++         +#+       +#+   +#+      ###   ";
echo " ###       ###   ###    #####    #########    ###     ###    ###      ###   ";
echo " ###       ###   ### ######      #########      #######       ##########   ";
echo -e "\e[0m"
echo "================================================================================="


sleep 1

# set vars
if [ ! "$ID_CHAT" ]; then
read -r -p "Input Your ID_CHAT: " ID_CHAT
echo 'export ID_CHAT='\"${ID_CHAT}\" >> $HOME/.bash_profile
read -r -p "Input Your Validator Address: " VALIDATOR_ADDRESS
echo 'export VALIDATOR_ADDRESS='\"${VALIDATOR_ADDRESS}\" >> $HOME/.bash_profile
fi
echo "source $HOME/.bashrc" >> "$HOME"/.bash_profile
. "$HOME"/.bash_profile

echo -e "Your ID Chat: \e[1m\e[32m${ID_CHAT}\e[0m"
echo -e "Your Validator Address: \e[1m\e[32m${VALIDATOR_ADDRESS}\e[0m"
echo '================================================='
sleep 1

sudo apt update && sudo apt install screen -y


cd $HOME
wget -O notifhaqq.sh https://raw.githubusercontent.com/mdlog/haqq-notif/main/notifhaqq.sh && chmod +x notifhaqq.sh && screen -xR -S mdlog ./notifhaqq.sh
