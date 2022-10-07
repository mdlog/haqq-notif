#!/bin/bash
sudo apt update && sudo apt install screen -y

VALIDATOR="haqqvaloper1xmc094zr2zhkmcqw4yw6wzrrf0eaak4sgcafcr"
ID_CHAT="485873863"
TOKEN_BOT="5509813677:AAHUX7kAMuW0aF1Zx3NDq5ZxzUx6yJWXHZM"
URL= https://api.telegram.org/bot$TOKEN/sendMessage
while true
do
cd "$HOME"/ || return
jail=$(haqqd q staking validator "$VALIDATOR" -ot | jq .jailed)
if  [ "$jail" == "false" ]; then
curl -s -X POST "$URL" -d "chat_id=$ID" -d "parse_mode=html" -d "text= ✅ $VALIDATOR IS FINE"

elif [ "$jail" == "true" ]; then
 curl -s -X POST "$URL" -d "chat_id=$ID" -d "parse_mode=html" -d "text= ❌ $VALIDATOR IS JAILED"
fi
block=$(haqqd q slashing signing-info $(haqqd tendermint show-validator) -oj | jq .missed_blocks_counter | grep -o -E '[0-9]+')
if  [[ "$block" -eq 0 ]]; then
  curl -s -X POST "$URL" -d "chat_id=$ID" -d "parse_mode=html" -d "text= ✅ NODE MISSED NO BLOCK"

elif [[ "$block" -gt 0 ]]; then
 curl -s -X POST "$URL" -d "chat_id=$ID" -d "parse_mode=html" -d "text= ⚠️ NODE IS MISSING BLOCKS: $block missed blocks"
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
