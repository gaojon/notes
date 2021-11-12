# Install EPEL
    sudo yum install epel-release
	
# Change hostname
    sudo hostnamectl set-hostname newname	
	
# change IP address 
    sudo nmcli c modify em1 ipv4.addresses 192.168.1.200/24	
	sudo nmcli c modify em1 ipv4.gateway 192.168.1.1
	sudo nmcli c modify em1 ipv4.dns 192.168.1.1
	sudo nmcli c modify em1 ipv4.method manual
	sudo nmcli c down em1; nmcli c up em1
	sudo nmcli d show em1

# Enable SSH through RSA
	
	At the server side
	
	$ssh-keygen -t rsa 
	$mv ~/.ssh/id_rsa.pub ~/.ssh/authorized_key  ;private key
	
	
	At the client side
	
	$mkdir ~/.ssh
	$chmod 700 ~/.ssh
	$scp user@server:/home/usr/.ssh/id_rsa ~/.ssh/
	$ssh -i ~/.ssh/id_rsa user@server
	
	
# LD Library setup
    ldconfig -p ; show the current lib mapping
    ldconfig -v ; reload the lib

You can edit the file /etc/ld.so.conf and add your path /usr/local/lib to it or create a new file in /etc/ld.so.conf.d/. After add your own lib, don't forget to 
	
# Setup VNC server

Install the vncserver as your preferences and fluxbox

	sudo yum install tightvnc-server
	

Open pors for VNC

    sudo firewall-cmd --add-port=5900-5999/tcp --permanent 
    sudo service firewalld restart
	

# User management
    sudo adduser test	
	sudo userdel test
	
	
# Change default gateway temporarily
    sudo ip route replace default via 192.168.1.10 dev em1	
	
# Check OS release version
    cat /etc/centos-relase	
	
# Service management
    systemctl list-unit-files -t service ;list all services
	systemctl stop service ;stop
    systemctl start service
	systemctl enable service ;enable automatical startup during bootup 
	systemctl disable service
	
# Yum install package management
    yum list installed |grep kernel* ;query installed package
	yum info package ;query available package on repo
	yum install
	yum remove
	yum localinstall local_package.rpm
	
# RPM 
    rpm -ql package name
	rpm -qa |grep package name


# Install Nvidia driver
    sudo vi /etc/modprobe.d/blacklist-nouveau.conf	
add following content

    blacklist nouveau
    options nouveau modeset=0	
	
then

    sudo dracut --force
    sudo reboot
	
check if disabled
	
    sudo lsmod | grep nouveau
	sudo service gdm stop
	sudo ./NVIDIA-dirver --dkms -s
	
# Mount ntfs usb flash
    sudo yum install ntfs-3g
	sudo fdisk -l
    sudo mount -t ntfs-3g /dev/sdb1 /mnt/usb	
	
# Change the MAC address
    sudo chmod +x /etc/rc.d/rc.local
	sudo vi /etc/rc.local
add following line
    /sbin/ifconfig em1 hw ether cc:dd:ee:ff:00:11
	
# Check the exe file required library files
    ldd exec_file	
	
# Install SS server
Install packages

    sudo yum install m2crypto python-setuptools
    sudo easy_install pip
    sudo pip install shadowsocks    
	
create configuration file /etc/shadowsocks.json

    {
    "server":"ec2-54-199-158-226.ap-northeast-1.compute.amazonaws.com",
    "server_port":8388,
    "local_port":1080,
    "password":"fuckgfw",
    "timeout":600,
    "method":"aes-256-cfb"
    }
	
start service
    sudo ssserver -c /etc/shadowsocks.json -d start

stop service
    sudo ssserver -d stop
	
# Start xterm with font size
    xterm -fa "MONOspace" -fs 14
	
# Disk space management
    du -sh ./*
    
# Uninstall vivado
    into install directory
    sudo ./xsetup -Uninstall

# Disable bashrc for scp
   Some scripts inside bashrc will cause scp failed. Add following scripts at the beginning of the bashrc to avoid it. 
   
    if [ -z "$PS1" ]; then
    return
    fi

# Make NTFS file system
     sudo yum install ntfsprogs
  Then, you could use gnome disk utility to create a new file system with NTFS
  
# Install VirtualBox
  Install the virtualbox repo at first
  
    $sudo wget https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
	$sudo yum install VirtualBox-5.2
	
# Install Google-Chrome
   
   $sudo vi /etc/yum.repos.d/google-chrome.repo
    
	[google-chrome]
    name=google-chrome
    baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
    enabled=1
    gpgcheck=0
    gpgkey=https://dl.google.com/linux/linux_signing_key.pub
	
	$sudo yum install google-chrome-stable
	
	
# Add user to sudoers
    
	usermod -aG wheel username
	gpasswd -a user group 	;delete from group
  
# Install tkdiff
   $yum install tkcvs
   
# Install tcl
   on centos 7.5. The tclsh will report version confliction. 
   $sudo yum install tcl
   $tclsh 
   
# Install tk
   $sudo yum install tk
   $wish
   
# Find current and child directory 
   $find ./ -name "*.xsa"
   
# Disable tracker daemon which CPU occupation is high
   $cd /etc/xdg/autostart
   $sudo vi tracker*
   Change "X-GNOME-Autostart-enabled=true" "X-GNOME-Autostart-enabled=false"   
   
# Query license usage
    $lmutil lmstat -a -c ports@license_server   
	
# Tcl test file or directory exist
    if [ ! -d "test" ]; then 
	     touch "test"
	fi
	
# Install notepad++ 
    $sudo wget -O /etc/yum.repos.d/sea-devel.repo http://sea.fedorapeople.org/sea-devel.repo 
	$sudo yum install notepadqq
	
# Use multi-threads download tools  
	$sudo yum install aria2
	$aria2c URL
	$aria2c --max-download-limit=500K	;limit max download speed
	
	
# validate MD5 sum 
	$md5sum the_name_of_your_file
	
# Display the partition UUID
	$lsblk -f

# Reset Centos root passwd
    Press "e" to edit boot entry
    Add "rd.break" at the end of line "linux16...."
    Press "Ctrl+x" to boot with new options
    #mount -o remount,rw /sysroot
	#chroot /sysroot
	#passwd
	#touch /.autorelabel
	#exit
	exit

# home directory quota
    edit /etc/fstab and add "uquota,gquota" under option collumn
	#xfs_quota -x /home
	xfs_quota>limit bsoft=10g bhard=25g username
	xfs_quota>report -h -u

# Install 7zip
    $yum install p7zip
	$7za x file.7z
	
# Find and delete with confirmation
	$find ./ -name *.bak -exec rm -i {} \;
	
# set domain name
    $sudo vi /etc/resolv.conf  Just add a line 
	
	domain yourdomain.com	
	
	$chattr +i /etc/resolv.conf
	
	
# search pattern in all files under directory structure
    $grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
	
	-r or -R is recursive,
	-n is line number, and
	-w stands for match the whole word.
	-l (lower-case L) can be added to just give the file name of matching files.
	
	
#setup tftp server 
    $yum install tftp-server
	$vi /etc/xinet.d/tftp
	
	$vi /usr/lib/systemd/system/tftp.service
	$sudo systemctl enable tftp
	$sudo systemctl restart tftp
	
	$sudo firewall-cmd --add-service=tftp --permanent 
    $sudo service firewalld restart
	Default path is /var/lib/tftpboot


# install Meld to compare folders
    $sudo yum install meld

	
	
	
# resume scp after broken

    $rsync -Pavz user@host:remote_file local_file 
	$rsync -Pavz --delete   ;remote files not exist at source
	
# Ignore big files and files without readable permission
notes: The exclude file list is relative path to the current pmd directory
```
$cd source
$find . ! -readable -o -type d ! -executable | sed -e 's:^\./:/:' -e 's:[?*\\[]:\\1:g' >> ~/pl
$rsync -Pavzh --exclude-from=/home/jung/pl --max-size=1m . target
```

# Enable X11 forwarding through SSH
	$ssh -YC user@host   ;-C enable compression
	
# Install source navigator
	https://excellmedia.dl.sourceforge.net/project/sourcenav/NG4.4/sourcenavigator-NG4.4.tar.bz2
	Download the source code image
	configure and install
	
	
# Mount samba server
```
	smbclient -U jung -W xlnx //xsz-pvst2ns01-w/EngTools_nobackup/_ISE_Vivado_SDx_All_/Vivado_2020.1	
	smbget -r -U jung -w xlnx smb://xsz-pvst2ns01-w/EngTools_nobackup/_ISE_Vivado_SDx_All_/Vivado_2020.1/Xilinx_Unified_2020.1_0520_1512.tar.gz ./
```	
# Move OS to new HDD
## Step1 boot up 
Need to boot from USB live or rescue boot. 	

## Step2 partitioning new disk
1. create ms-dos partition table
2. create partitions as you like
3. set bootable flag for boot partition
4. make file system

`mkfs.xfs /dev/sda1 -f`

5. make swap 

`mkswap -L swap /dev/sda2`
`swpaon /dev/sda2`

## Step3 duplicate data from old partitions to new ones

```
#mount /dev/sda1 /mnt/sda1
#mount /dev/sdb1 /mnt/sdb1
#xfsdump -l0 -J - /mnt/sdb1 | xfsrestore -J - /mnt/sda1
```


Another option proved also working well 
```
#rsync -axHAWXS --numeric-ids --info=progress2 source target
```

repeat above steps to duplicate all the used partitions

## Step4 make new disk bootable
### Modify the boot and root partition name
`blkid  ;list the UUID of each partition`

Modify the BOOT and ROOT partition accordingly in those two files
```
/etc/fstab
/boot/grub2/grub.cfg
```
### Install the grub2 on new disk
```
mount /dev/old_root /mnt
mkdir -p /mnt/boot
mount /dev/new_boot /mnt/boot
mount -t devtmpfs /dev /mnt/dev
mount -t proc /proc /mnt/proc
mount -t sysfs /sys /mnt/sys
chroot /mnt/ grub2-install /dev/sda
```

Pay attention to install in new disk not partition
Just reboot to select booting from new disk


# Show path in file manager
ctrl+l


# NFS install
## NFS server
$sudo yum -y install nfs-utils


$ vi /etc/exports

/home 10.0.0.0/24(rw,no_root_squash)

$sudo systemctl start rpcbind nfs-server
$sudo systemctl enable rpcbind nfs-server


$sudo firewall-cmd --add-service=nfs --permanent
$sudo firewall-cmd --add-service={nfs3,mountd,rpc-bind} --permanent
$sudo firewall-cmd --reload

## update exportfs
$exportfs -r





## NFS client
[root@www ~]# yum -y install nfs-utils


[root@www ~]# systemctl start rpcbind
[root@www ~]# systemctl enable rpcbind

sudo vi /etc/fstab

10.178.176.9:/home                       /home                    nfs      defaults                     0 0
10.178.176.9:/opt                       /opt                    nfs       defaults                      0 0


# NIS install
## NIS server

[root@dlp ~]# yum -y install ypserv rpcbind
# set NIS domain name
[root@dlp ~]# ypdomainname srv.world
[root@dlp ~]# echo "NISDOMAIN=srv.world" >> /etc/sysconfig/network
[root@dlp ~]# vi /var/yp/securenets
# add IP addresses you allow to access to NIS server
255.0.0.0       127.0.0.0
255.255.255.0   10.0.0.0

[root@dlp ~]# vi /etc/hosts
# add server and clients' IP address for NIS database
10.0.0.30   dlp.srv.world dlp
10.0.0.31   www.srv.world www

[root@dlp ~]# systemctl start rpcbind ypserv ypxfrd yppasswdd
[root@dlp ~]# systemctl enable rpcbind ypserv ypxfrd yppasswdd
# update NIS database
[root@dlp ~]# /usr/lib64/yp/ypinit -m

##update database
[root@dlp ~]# cd /var/yp
[root@dlp yp]# make


## NIS client
sudo yum -y install ypbind rpcbind
sudo ypdomainname nj.xilinx.com
sudo echo "NISDOMAIN=nj.xilinx.com" >> /etc/sysconfig/network

sud vi /etc/hosts

10.178.176.9    xnjsrv1.nj.xilinx.com xnjsrv1
10.178.176.99   xnjws3.nj.xilinx.com xnjws3
10.178.176.127   xnjws3.nj.xilinx.com xnjws2
10.178.176.201  xnjws1.nj.xilinx.com xnjws1


sudo authconfig \
--enablenis \
--nisdomain=nj.xilinx.com \
--nisserver=xnjsrv1.nj.xilinx.com \
--enablemkhomedir \
--update


sudo systemctl start rpcbind ypbind
sudo systemctl enable rpcbind ypbind

sudo vi /etc/nsswitch.conf

passwd:     nis files sss
shadow:     nis files sss
group:      nis files sss


# list owner and ID of open files
lsof 


# NTP
install pacakge if it's not there

$sudo yum install ntp -you
$sudo systemctl start ntpd.service
$sudo systemctl enable ntpd.service

$sudo service ntpd status

Force the NTP to sync up time with servers

$sudo service ntpd stop
$sudo ntpd -gq
	-g – requests an update irrespective of the time offset
	-q – requests the daemon to quit after updating the date from the ntp server.
$sudo service ntpd start


# Kill all process from one user
killall --user name

# Kill process using directory
$fuser -km ./


# substitution for SED and VIM


```
.	any character except new line
*	matches 0 or more of the preceding characters, ranges or metacharacters .* matches everything including empty line
\+	matches 1 or more of the preceding characters...
```



# write image to usb
dd if=/mnt_nfsroot/sd_card.img of=/dev/mmcblk0 status=progress

# See live dmesg log

$sudo dmesg -wH


# memory segment management

$ipcs -m  	;list all shared memory segement
$cat /proc/sys/kernel/shmmni		;list limitation of segement
$wc -l /proc/sysvipc/shm			;show used segment
$ipcrm shm 32768(shi_id)	
$ipcs -m -i 32768		

# change shmmni to bigger value

$sudo sysctl -w kernel.shmmni=8196	;change it to bigger 


# Work with kernel modules

$lsmod |grep xdma 
$insmod ../xdma/xdma.ko
$rmmod xdma
$modinfo ../xdma/xdma.ko 


# Collect CPU and Memory related information

$sudo dmidecode -t memory |grep Speed >ddr
$sudo dmesg |grep MHz >cpu 


# swtich different Python versions  

ls /usr/bin/python*
sudo update-alternatives --list python

sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2

sudo update-alternatives --config python


# mount dd img file and chagne content

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



# dd create image with specific length

This should be useful for partition without occupied whole disk

$dd bs=512 count=26509312 if=/dev/sdk of=devsdk.img
