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

VALIDATOR="$VALIDATOR_ADDRESS"
CHAT_ID="$ID_CHAT"
TOKEN_BOT="5509813677:AAHUX7kAMuW0aF1Zx3NDq5ZxzUx6yJWXHZM"
URL="https://api.telegram.org/bot$TOKEN_BOT/sendMessage"
while true
do
cd "$HOME"/ || return
jail=$(haqqd q staking validator "$VALIDATOR" -ot | jq .jailed)
if  [ "$jail" == "false" ]; then
curl -s -X POST $URL -d "chat_id=$CHAT_ID" -d "parse_mode=html" -d "text=  ✅ Your $VALIDATOR IS OK 👍"

elif [ "$jail" == "true" ]; then
 curl -s -X POST $URL -d "chat_id=$CHAT_ID" -d "parse_mode=html" -d "text= ❌ Your  $VALIDATOR IS JAIL 😒 "
fi
block=$(haqqd q slashing signing-info $(haqqd tendermint show-validator) -oj | jq .missed_blocks_counter | grep -o -E '[0-9]+')
if  [[ "$block" -eq 0 ]]; then
  curl -s -X POST $URL -d "chat_id=$CHAT_ID" -d "parse_mode=html" -d "text=  ✅ Your NODE NO MISSED BLOCK 👍"

elif [[ "$block" -gt 0 ]]; then
 curl -s -X POST $URL -d "chat_id=$CHAT_ID" -d "parse_mode=html" -d "text= ⚠️ Your NODE IS MISSING BLOCKS: $block missed blocks 🚨"
fi
   printf "sleep"
        for((sec=0; sec<300; sec++))
        do
                printf "."
                sleep 1
        done
        printf "\n"
done
