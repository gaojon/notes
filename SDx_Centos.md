# Prerequisite 
This is the guideline to install SDx on Centos on VM. I ran into issues with compatibility issues between VirtualBox version and Centos version, so the final combination is VirtualBox 5.2.22 and Centos 7.5. The first step is to download those install packages from corresponding website. 

Older version of Centos could be found here:http://archive.kernel.org/centos-vault/

    CentOS-7-x86_64-DVD-1804

Download Oracle VM together with Extension Pack
	Oracle_VM_VirtualBox_Extension_Pack-5.2.22	
	VirtualBox-5.2.22-126460-Win
	
# Instal VM
It's recommend to right click on install package to install as administrator. This could avoid permission issues during the run time.  

# Install Centos 
Nothing special. Just remember to install additional tools and desktop. 

Software Selection: On the left select GNOME Desktop, and on the right GNOME Application, Development Tools and Compatibility Library Tool Done

# Set up Centos EPEL repo
    sudo yum install epel-release
	
# Install DSA and Alveo deployment and development environment
Download the install packages for Centos from this linke:
https://www.xilinx.com/products/boards-and-kits/alveo/u200.html#gettingStarted

    sudo yum install <rpm-dir>/xrt_201830.2.1.1695_7.4.1708-xrt.rpm
    sudo yum install <rpm-dir>/xilinx-u200-xdma-201830.1-2405991.x86_64.rpm
    sudo yum install <rpm-dir>/xilinx-u200-xdma-dev-201830.1.x86_64.rpm
	
Solve /lib64/libstdc++.so.6 version 'glibcxx_3.4.2' not found issue

	cd /lib64
	sudo mv libstdc++.so.6 libstdc++.so.6.bak
	ln -s /xlnx/xlnx/SDK/2018.3/lib/lnx64.o/Default/libstdc++.so.6 libstdc++.so.6
	