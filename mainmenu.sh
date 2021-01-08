#!/bin/bash
# This script change CPU and GPU settings
export ADAPTER=raspberrypi
function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Game and Watch flash tools " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "How to connect Game & Watch" \
            2 "BackUp / Restore Game & Watch" \
			3 "Flash NES / GB Game" \
			4 "Update RetroGO" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) readme  ;;
            2) backup  ;;
            3) flash  ;;
			4) update_RetroGo;;
            *)  break ;;
        esac
    done
}


function readme() {
	fbi -a -1 -t 5 opening-1.png
}

function backup() {
	cd ~/game-watch-flash-menu
	./backup.sh
}

function flash() {
	cd ~/game-watch-flash-menu
	./flash.sh
}

function update_RetroGo(){
	cd ~/game-and-watch-retro-go
	git pull
	read -p "Press enter to continue"
}
main_menu
