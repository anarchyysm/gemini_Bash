#!/bin/bash

declare -a history=()

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

show_logo() {
    echo -e "${CYAN}:'######:::'########:'##::::'##:'####:'##::: ##:'####:${RESET}"
    echo -e "${CYAN}'##... ##:: ##.....:: ###::'###:. ##:: ###:: ##:. ##::${RESET}"
    echo -e "${CYAN} ##:::..::: ##::::::: ####'####:: ##:: ####: ##:: ##::${RESET}"
    echo -e "${CYAN} ##::'####: ######::: ## ### ##:: ##:: ## ## ##:: ##::${RESET}"
    echo -e "${CYAN} ##::: ##:: ##...:::: ##. #: ##:: ##:: ##. ####:: ##::${RESET}"
    echo -e "${CYAN} ##::: ##:: ##::::::: ##:.:: ##:: ##:: ##:. ###:: ##::${RESET}"
    echo -e "${CYAN}. ######::: ########: ##:::: ##:'####: ##::. ##:'####:${RESET}"
    echo -e "${CYAN}:......::::........::..:::::..::....::..::::..::....::${RESET}"
}

send_message() {
    local message="$1"
    local port
    local response
    local payload

    history_json=$(printf '%s\n' "${history[@]}" | jq -R . | jq -s .)
    payload=$(jq -n --arg msg "$message" --argjson hist "$history_json" '{"message": $msg, "history": $hist}')

    for port in 5013 5014 5015; do
        response=$(curl -s -w "%{http_code}" -X POST "http://177.104.86.234:$port/send_message" \
            -H "Content-Type: application/json" \
            -d "$payload")
        
        http_code=${response: -3}
        
        if [ "$http_code" -eq 200 ]; then
            response_body=${response%???}
            
            mensagem=$(echo "$response_body" | jq -r '.mensagem')
            resposta=$(echo "$response_body" | jq -r '.resposta')
            status=$(echo "$response_body" | jq -r '.status')

            if [ "$status" = "sucesso" ]; then
                echo ""
                echo -e "${MAGENTA}$resposta${RESET}"
                echo ""

                history+=("$message")
                history+=("$resposta")
                return 0
            fi
        fi
    done
    
    echo ""
    echo -e "${RED}Error: Could not connect to any port (5013, 5014, 5015)${RESET}"
    echo ""
    return 1
}

show_logo
echo -e "${BLUE}Welcome to the chat interface! Type 'exit' to quit.${RESET}"
echo ""
while true; do
    echo -n -e "${YELLOW}Prompt >>> ${RESET}"
    read input

    if [ "$input" = "exit" ]; then
        echo -e "${RED}Goodbye!${RESET}"
        break
    fi

    if [ -z "$input" ]; then
        continue
    fi

    send_message "$input"
done

