# Change the Static IP address from DHCP

    sudo vi /etc/network/interfaces
The original DHCP setting   

    auto eth0
    iface eth0 inet dhcp
	
comment the above lines and add following

    auto eth0
    iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    network 192.168.1.0
    broadcast 192.168.1.255
    gateway 192.168.1.1
    dns-nameservers 192.168.1.1
	
Remove DHCP and restart services

    sudo apt-get remove dhcp-client	
    sudo /etc/init.d/networking restart
	
# Add new user

This command will add user ubuntu with default bash shell
    
	sudo adduser ubuntu 
    
# Change user group

    usermod -G group_name  
	
-g for primary group

-G for additional group
	
# Grant user sudo permission
 
    usermod -G sudo
	
# Setup VNC server

Install the vncserver as your preferences and fluxbox

    sudo apt-get install fluxbox
	sudo apt-get install tightvnc-server
	
Create xstartup file in .vnc

    [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
    xsetroot -solid grey
    vncconfig -nowin &
    xterm -fa "MONOspace" -fs 14 -geometry 80x24+10+30 -bg grey -ls -title "$VNCDESKTOP Desktop" &
	exec fluxbox &

Start the vncserver
 
     vncserver -geometry 1980x1020 :58
	 
You may need to open for firewall for incoming vnc connections	


# service management

Use this command to set service start at boot time
    sudo systemctl enable docker
	
	
# disk space management

    du -sh ./*
	
# enable sudo with user env
    sudo visudo
    #Default env_reset
    #Default secure_path=""

# search installed packages
    sudo apt search xxxx
	sudo apt list ;	list all installed packages
	
	

