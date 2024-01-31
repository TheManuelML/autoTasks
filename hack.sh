#!/bin/bash

## Auto tasks
## Created by Mahackmaga
__version__="1.0"

init(){
    echo "Initializating pentest"
    echo "----------------------"
    echo -e "content\nexploits\nnmap"
    mkdir {content,exploits,nmap}
    echo "----------------------"
    echo "3 Directories, 0 Files"
}

verify_ip() {
    guide_ipv4="^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]?[0-9])$"
    
    if [[ $ipv4 =~ $guide_ipv4 ]]; then
        echo "true"
    else
        echo "false"
    fi
}

osinfo() {
    ipv4=$1
    pattern=$(verify_ip $ipv4)

    if [[ -z "$1" ]]; then
        echo "Usage: hack osinfo {target}"
        exit 1

    else
        if [[ $pattern == "true" ]]; then
            echo "OpSys information"
            echo "----------------------"
            ping=$(ping -c 1 -W 5 $ipv4 | grep -o 'ttl=[0-9]*' | cut -d'=' -f2)
            ttl=$((ping))

            if [ "$ttl" -gt 0 ] && [ "$ttl" -le 64 ]; then
                echo "$ipv4 ttl=$ttl Linux"
            elif [[ "$ttl" -gt 64 ]]; then
                echo "$ipv4 ttl=$ttl Windows"
            else
                echo "Cannot sent packages to $ipv4"
            fi

        else
            echo "Not a valid IP or unable to sent packages to $ipv4"
            exit 1
        fi
    fi
}

ports() {
    file=$1 

    if [[ -z "$1" ]]; then
        echo "Usage: hack ports {target}"
        exit 1
    else
        echo "Open ports"
        echo "----------------------"
        ports=$(cat $file | grep -oE "Ports: .*" | grep -oE '\b[0-9]+\b' | tr '\n' ',' | sed 's/,$//')
        echo "$ports"
        echo "----------------------"
        echo "Copied in clipboard"

        ## Copy depend of each clipboard
        xclip=$(which xclip)
        if [[ "${xclip:0:1}" == '/' ]]; then
            echo "$ports" | sed 3d | tr -d '\n' | xclip -selection clipboard
        fi

        pbcopy=$(which pbcopy)
        if [[ "${pbcopy:0:1}" == '/' ]]; then
            echo "$ports" | sed 3d | tr -d '\n' | pbcopy
        fi
        
        xsel=$(which xsel)
        if [[ "${xsel:0:1}" == '/' ]]; then
            echo "$ports" | sed 3d | tr -d '\n' | xsel --clipboard
        fi

    fi
}

help() {
    echo -e "No command coincidences"
    echo -e "Usage: hack [command]\n       hack [command] {target}"
    echo -e "\nCommands"
    echo -e "\tinit        Make the starting directories"
    echo -e "\tosinfo      Gives the ttl and OS of a target {target}"
    echo -e "\tports       Return ports of the document (-oG) {target}"
    echo -e "\nTarget"
    echo -e "\tIPv4: 0.0.0.0"
    echo -e "\tNmap document"
}

case $1 in
    osinfo)
        osinfo $2
    ;;
    init)
        init
    ;;
    ports)
        ports $2
    ;;
    *)
        help
    ;;
esac