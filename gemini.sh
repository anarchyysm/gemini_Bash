#!/bin/bash

declare -a history=()


show_logo() {
    echo ":'######:::'########:'##::::'##:'####:'##::: ##:'####:"
    echo "'##... ##:: ##.....:: ###::'###:. ##:: ###:: ##:. ##::"
    echo " ##:::..::: ##::::::: ####'####:: ##:: ####: ##:: ##::"
    echo " ##::'####: ######::: ## ### ##:: ##:: ## ## ##:: ##::"
    echo " ##::: ##:: ##...:::: ##. #: ##:: ##:: ##. ####:: ##::"
    echo " ##::: ##:: ##::::::: ##:.:: ##:: ##:: ##:. ###:: ##::"
    echo ". ######::: ########: ##:::: ##:'####: ##::. ##:'####:"
    echo ":......::::........::..:::::..::....::..::::..::....::"
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
                echo "$resposta"
		            echo ""

                history+=("$message")
                history+=("$resposta")
                return 0
            fi
        fi
    done
	
    echo ""
    echo "Error: Could not connect to any port (5013, 5014, 5015)"
    echo ""
    return 1
}

show_logo
echo "Welcome to the chat interface! Type 'exit' to quit."
echo ""
while true; do
    echo -n "Prompt >>> "
    read input

    if [ "$input" = "exit" ]; then
        echo "Goodbye!"
        break
    fi

    if [ -z "$input" ]; then
        continue
    fi

    send_message "$input"
done
