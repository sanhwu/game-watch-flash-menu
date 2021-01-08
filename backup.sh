#!/bin/bash
function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Game and Watch Backup and Restore tools " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Back Up Flash." \
            2 "Back Up Internal Flash" \
			3 "Copy backup file to boot folder" \
			4 "Unlock Device" \
			5 "Restore" \
			0 "" \
			9 "restore Device if step 2 error" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) back_up_flash  ;;
            2) backup_internal_flash  ;;
			3) copy_backup_file  ;;
            4) unlock_device  ;;
            5) restore  ;;
			9) restore_device ;;
            *)  break ;;
        esac
    done
}

function back_up_flash() {
	cd ~/game-and-watch-backup
	./2_backup_flash.sh raspberrypi
	read -p "Press enter to continue"
}

function backup_internal_flash() {
	cd ~/game-and-watch-backup
	./3_backup_internal_flash.sh raspberrypi
	read -p "Press enter to continue"
}

function copy_backup_file() {
	cd ~/game-and-watch-backup
	sudo cp -R ./backups /boot/backup/
	read -p "Press enter to continue"
}

function unlock_device() {
	cd ~/game-and-watch-backup
	./4_unlock_device.sh raspberrypi
	read -p "Press enter to continue"
}

function restore() {
	cd ~/game-and-watch-backup
	./5_restore.sh raspberrypi
	read -p "Press enter to continue"
}

function restore_device() {
	cd ~/game-and-watch-backup
	./scripts/flashloader.sh raspberrypi ./backups/flash_backup.bin
	read -p "Press enter to continue"
}
main_menu
