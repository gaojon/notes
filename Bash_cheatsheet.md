# Get arg input

$0	command itself
$1	first parameter


# Check if file exist

FILE=/etc/resolv.conf
if [ -f "$FILE" ]; then
    echo "$FILE exists."
fi

# Conditional 

if [ <some test> ]
then
<commands>
else
<other commands>
fi

if [ ! -d "/path/to/dir" ] && echo "Directory /path/to/dir DOES NOT exists."


# get ouptut form command

your_command_string="..."
output=$(eval "$your_command_string")
echo "$output"



# mount dd img file and chagne 

$fdisk ./*.img 

print out partition
~~~
Disk ./sd_card.img: 4294 MB, 4294967296 bytes, 8388608 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000992c7

        Device Boot      Start         End      Blocks   Id  System
./sd_card.img1   *        2048     2000895      999424   83  Linux
./sd_card.img2         2000896     3145727      572416   83  Linux

~~~

get the start offset address in bytes = sector *512 Blocks

$sudo mount -oloop,offset=1048576 ./sd_card.img /mnt/usb


