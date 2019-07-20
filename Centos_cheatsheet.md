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
	

# user management
    sudo adduser test	
	sudo userdel test
	
	
# change default gateway temporarily
    sudo ip route replace default via 192.168.1.10 dev em1	
	
# check OS release version
    cat /etc/centos-relase	
	
# service management
    systemctl list-unit-files -t service ;list all services
	systemctl stop service ;stop
    systemctl start service
	systemctl enable service ;enable automatical startup during bootup 
	systemctl disable service
	
# yum install package management
    yum list kernel* ;query instaled package
	yum info package ;query available package on repo
	yum install
	yum remove


# Install Nvidia driver
    sudo vi /etc/modprobe.d/blacklist-nouveau.conf	
add following content
    blacklist nouveau
	options nouveau modeset=0	
then
    sudo dracut --force
    sudo reboot	
check if disable	
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
	
	

  