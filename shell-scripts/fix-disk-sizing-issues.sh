# 9/21/26
# Run this if your computer says there is some issue with your storage and allocated space.
# NOTE: Make sure to increase the disk size allocated to the VM in VMware -> Virtual Machine Settings. Then continue.


#!/bin/bash
# need to update this script later to have clearer error checking; for now, set -e should do.

[[ -e execution.log ]] || : > execution.log

{ lsblk && sudo pvs; sudo lvs; sudo vgs; } > execution.log

if sgdisk -v /dev/sda 2>&1 | grep -q "GPT table header not at correct position"; then
	printf "Relocating GPT table header"
	sgdisk -e /dev/sda >> execution.log
fi

printf "What is the number of the physical disk you are resizing?\n"
read part
sudo growpart /dev/sda "$part" >> execution.log
sudo pvresize "/dev/sda${part}" >> execution.log

lsblk
printf "NOTE: This next step will require you to type out the name of the logical volume. Refer to the lsblk output on top for reference.\n"
printf "What is the name of the logical volume you are resizing?\n"
read logvol
sudo lvextend -r -l +100%FREE /dev/mapper/$logvol >> execution.log

df -hT
printf "Check to see if the logical volume sizing matches expectations."

