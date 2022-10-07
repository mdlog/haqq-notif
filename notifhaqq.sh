#!/bin/bash
sudo apt update && sudo apt install screen -y
clear

echo "Welcome to Haqq Node Checker!"
echo "This is a telegram bot to warn you about your node state"
echo "to continue, please provide your telegram ID Chat and Validator Address"
echo "Validator Address start with haqqvaloperxxxxxxxxxx"
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

sleep 1

clear

VALIDATOR="haqqvaloper1xmc094zr2zhkmcqw4yw6wzrrf0eaak4sgcafcr"
ID="485873863"
TOKEN_BOT="5509813677:AAHUX7kAMuW0aF1Zx3NDq5ZxzUx6yJWXHZM"
while true
do
cd "$HOME"/ || return
jail=$(haqqd q staking validator "$VALIDATOR" -ot | jq .jailed)
if  [ "$jail" == "false" ]; then
curl \
 — data parse_mode=HTML \
 — data chat_id=$ID_CHAT \
 — data text="✅ $VALIDATOR IS FINE" \
 — request 
 POST https://api.telegram.org/bot$TOKEN_BOT/sendMessage

elif [ "$jail" == "true" ]; then
curl \
 — data parse_mode=HTML \
 — data chat_id=$ID_CHAT \
 — data text="❌ $VALIDATOR IS JAILED" \
 — request 
 POST https://api.telegram.org/bot$TOKEN_BOT/sendMessage
fi
block=$(haqqd q slashing signing-info $(haqqd tendermint show-validator) -oj | jq .missed_blocks_counter | grep -o -E '[0-9]+')
if  [[ "$block" -eq 0 ]]; then
curl \
 — data parse_mode=HTML \
 — data chat_id=$ID_CHAT \
 — data text="✅ NODE MISSED NO BLOCK" \
 — request 
 POST https://api.telegram.org/bot$TOKEN_BOT/sendMessage

elif [[ "$block" -gt 0 ]]; then
curl \
 — data parse_mode=HTML \
 — data chat_id=$ID_CHAT \
 — data text="⚠️ NODE IS MISSING BLOCKS: $block missed blocks" \
 — request 
 POST https://api.telegram.org/bot$TOKEN_BOT/sendMessage
fi
   printf "sleep"
        for((sec=0; sec<300; sec++))
        do
                printf "."
                sleep 1
        done
        printf "\n"
        
        echo "Press Ctrl+A+D to detach from this screen..."
        echo "or type: exit "
done
