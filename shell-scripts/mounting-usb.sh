# 09/21/2026
# Too lazy to search up how to mount USBs again? I got you.#

#!/bin/bash

sudo mkdir -p /mnt/usb

lsblk
printf "What is the name of the partition you are trying to mount on?\n"
read part
sudo mount "/dev/$part" /mnt/usb

printf "\nYour USB should be located at /mnt/usb\n"
printf "If you need to unmount this, run 'sudo umount /dev/$part\n"
