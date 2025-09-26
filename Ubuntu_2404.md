##  Mount /home1  

```
mkdir -p /home1/jon
mount /dev/disk/by-uuid/5af4352a-692e-4df3-8343-aa762f9f40f7 /home1/jon

echo "/dev/disk/by-uuid/5af4352a-692e-4df3-8343-aa762f9f40f7  /home1/jon  ext4 defaults 0 1" | tee -a /etc/fstab
```

##  Mount NTFS file system during bootup

```
echo "/dev/nvme0n1p4   /repo  ntfs-3g rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 0 1" | tee -a /etc/fstab
```

##  Adding new user  
```
useradd jon -d /home1/jon -G sudo,render,video -s /bin/bash

chown jon -R /home1/jon
chgrp jon -R /home1/jon
```
##    Enable sshd  
```
apt -y install openssh-server -qq
systemctl restart ssh
```

##  Install AMD GPU driver   
```
wget https://repo.radeon.com/amdgpu-install/6.4.3/ubuntu/noble/amdgpu-install_6.4.60403-1_all.deb
apt install ./amdgpu-install_6.4.60403-1_all.deb -y -q
apt update
apt install "linux-headers-$(uname -r)" "linux-modules-extra-$(uname -r)" -q -y
apt install amdgpu-dkms -q -y
```
##  Install vncserver   
```
apt -y install tigervnc-standalone-server -qq
apt -y install xfce4 xfce4-goodies -qq
```

## Add a alias to start vncserver  
echo "Need to reboot before launch vncserver"
echo "Only works when start vncserver from SSH terminal"
echo "It's safe to ignore the error in vnc log file:"
echo "    libEGL warning: failed to open /dev/dri/card1: Permission denied"
```
echo "alias vncs='tigervncserver -xstartup /usr/bin/startxfce4  -SecurityTypes VncAuth,TLSVnc -geometry 1980x1020 -localhost no :58'" | sudo tee -a /etc/bash.bashrc
```
