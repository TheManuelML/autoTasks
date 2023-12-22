#!/bin/bash

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
                echo "$ipv4 $ttl Windows"
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
    ipv4=$1
    pattern=$(verify_ip $ipv4)

    if [[ -z "$1" ]]; then
        echo "Usage: hack ports {target}"
        exit 1
    else
        if [[ $pattern == "true" ]]; then
            echo "Open ports"
            echo "----------------------"
            scan=$(sudo nmap -sS -p- -nPn $ipv4 -oG scan)
            ports=$(cat scan | grep -oE "Ports: .*" | grep -oE '\b[0-9]+\b' | tr '\n' ',')
            echo "$ports"
        else
            echo "Not a valid IP or unable to scan $ipv4"
            exit 1
        fi
    fi
}

help() {
    echo -e "No command coincidences"
    echo -e "Usage: hack [command]\n       hack [command] {target}"
    echo -e "\nCommands"
    echo -e "init        Make the starting directories"
    echo -e "osinfo      Gives the ttl and OS of a target {target}"
    echo -e "ports       Return open ports of the grep (-oG) file"
    echo -e "\nTarget\nRefers to an IPv4: 0.0.0.0"
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