#!/bin/bash
function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Game and Watch Flash tools " \
            --ok-label OK --cancel-label Back \
            --menu "What action would you like to perform?" 25 75 20 \
			1 "BackUp save state files" \
			2 "Restoring save state files" \
			3 "Flash roms" \
            2>&1 > /dev/tty)

        case "$choice" in
			1) BackupState ;;
			2) RestoringState ;;
            3) flash_game  ;;
            *)  break ;;
        esac
    done
}

function BackupState() {
	cd ~/game-and-watch-retro-go
	./dump_saves.sh build/gw_retro_go.elf
	read -p "Press enter to continue"
}

function RestoringState() {
	cd ~/game-and-watch-retro-go
	./program_saves.sh build/gw_retro_go.elf
	read -p "Press enter to continue"
}

function flash_game() {
	cd ~/game-and-watch-retro-go
	make -j8 flash_all
	read -p "Press enter to continue"
}

main_menu
