I am surprised that I ran into different kinds of issues during installation of Centos on Oracal VM. I started from the latest VirtualBox version with latest Centos version, I ran into the issue of cursor disappeared. After wasted a lot of time on this, I found a combination works. Hope this guideline could save you some time if you want to do the same thing. 

# Download the Centos iso file
  Download the CentOS-7-x86_64-DVD-1804.iso from Centos website. Choose the nearest mirror site to get higher speed. 
  https://www.centos.org/download/mirrors/
  
# Download the Oracle VM box
  Download the VirtualBox-5.2.22-126460-Win.exe file

# Download the guest additions image from Oracle
  Download the latest guest additions VBoxGuestAdditions_6.0.4.iso
  
# Install the Centos on VM
  Software Selection: On the left select GNOME Desktop, and on the right GNOME Application, Development Tools and Compatibility Library Tool Done
  
# Install the guest additions
  load the VBoxGuestAdditions_6.0.4.iso on VM optical drives
  left click on CD drive and select "Open in Terminal"
  $sudo ./VBoxLinuxAdditions.run
  
After the successful installation of guest additions, the screen will be messed up. After restarted the VM, everything should be all set then.
  
  
  
  