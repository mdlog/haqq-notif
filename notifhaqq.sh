#!/bin/bash
sudo apt update && sudo apt install screen -y

VALIDATOR="haqqvaloper1xmc094zr2zhkmcqw4yw6wzrrf0eaak4sgcafcr"
ID_CHAT="485873863"
TOKEN_BOT="5509813677:AAHUX7kAMuW0aF1Zx3NDq5ZxzUx6yJWXHZM"

while true
do
cd "$HOME"/ || return
jail=$(haqqd q staking validator "$VALIDATOR" -ot | jq .jailed)
if  [ "$jail" == "false" ]; then
curl -s -X POST \
 --parse_mode=html \
 --chat_id=$ID_CHAT \
 --text="✅ $VALIDATOR IS FINE" \
 --request https://api.telegram.org/bot$TOKEN_BOT/sendMessage

elif [ "$jail" == "true" ]; then
curl -s -X POST \
 --parse_mode=html \
 --chat_id=$ID_CHAT \
 --text="❌ $VALIDATOR IS JAILED" \
 --request https://api.telegram.org/bot$TOKEN_BOT/sendMessage
fi
block=$(haqqd q slashing signing-info $(haqqd tendermint show-validator) -oj | jq .missed_blocks_counter | grep -o -E '[0-9]+')
if  [[ "$block" -eq 0 ]]; then
curl -s -X POST \
 --parse_mode=html \
 --chat_id=$ID_CHAT \
 --text="✅ NODE MISSED NO BLOCK" \
 --request https://api.telegram.org/bot$TOKEN_BOT/sendMessage

elif [[ "$block" -gt 0 ]]; then
curl -s -X POST \
 --parse_mode=html \
 --chat_id=$ID_CHAT \
 --text="⚠️ NODE IS MISSING BLOCKS: $block missed blocks" \
 --request https://api.telegram.org/bot$TOKEN_BOT/sendMessage
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
