# Run Resnet50 example on DP-8020 board

Before running this example, please make sure you have installed the DNNDK environment successfully. Please refer to my other article on how to set it up. 

One thing you need to pay attention is that you need to check the versions of the tools chain on x86 host and target board are exactly same. Otherwise, you may run into issues. In this case, the deephi_dnndk_v2.07_beta version is used on both x86 host and DP-8020 target board. 

Let me separate the process into host side and target board side to avoid confusing. At first, let's start from host side. 

# On the x86 host
## Download Resnet50 model file

    wget http://www.deephi.com/assets/ResNet50.tar.gz
	tar zxvf ResNet50.tar.gz
	cd resnet50

## Quantize the network
Update the decent_resnet50.sh as following:

    #!/usr/bin/env bash
    
    #working directory
    work_dir=$(pwd)
    #path of float model
    model_dir=${work_dir}
    #output directory
    output_dir=${work_dir}/decent_output
    
    decent     quantize                                    \
               -model ${model_dir}/float.prototxt     \
               -weights ${model_dir}/float.caffemodel \
               -output_dir ${output_dir} \
               -method 1

NOTES: change the "fix" to "quantize"     
              
Then, you should be able to run decent_q to quantize the network.

    ./decent_resnet50.sh

## Compile the network	
Update the dnnc_resnet50.sh file as following:

    #!/bin/bash
    net=resnet50
    model_dir=decent_output
    output_dir=dnnc_output
    
    echo "Compiling network: ${net}"
    
    dnnc --prototxt=${model_dir}/deploy.prototxt     \
           --caffemodel=${model_dir}/deploy.caffemodel \
           --output_dir=${output_dir}                  \
           --net_name=${net}                           \
           --dpu=1152FA                                 \
           --cpu_arch=arm64

NOTES: change dpu from 1152F to 1152FA and cpu_arch from arm32 to arm64

Then, compile the network with following command. 

    ./dnnc_resnet50.sh
	
You should be able to see the output elf file in dnnc_output directory. 

    ls -al dnnc_output
    total 25892
    drwxr-xr-x 2 jon jon     4096 Dec  7 17:42 .
    drwxr-xr-x 5 jon jon     4096 Dec  7 17:47 ..
    -rw-rw-r-- 1 jon jon 26502448 Dec  7 17:42 dpu_resnet50_0.elf

## Transfer the elf file to target board
Copy the elf file to target board. You could choose different way to do it. But the best efficient way is through Ethernet. 

    scp ./dnnc_output/dpu_resnet50_0.elf root@192.168.1.201:/root/deephi_dnndk_v2.07_beta/DP-8020/samples/resnet50/model
	
NOTE: Make sure the host is connected to target board through Ethernet cable and network has been configured correctly. Read following chapters to set up the Ethernet network on DP-8020 board. 


# On the target board(DP-8020)
Connect the USB hub to the board, and then connect a mouse and keyboard to USB hub. Connect Ethernet cable and DP cable to a monitor. Check the DIP switch to select the right boot up way. My setting is 1101 for SD card boot up. Then, power on and boot up the system.  

## network configuration

    vi /etc/network/interfaces
	
I changed the IP of target board to 192.168.1.201. Make your there is not IP conflict in your network. You also need to check the IP of your host should be in the same network. My host IP is 192.168.1.200. 

    # interfaces(5) file used by ifup(8) and ifdown(8)
    auto lo
    iface lo inet loopback
    
    auto eth0
    allow-hotplug eth0
    iface eth0 inet static
     address 192.168.1.201
     netmask 255.255.255.0
     gateway 192.168.1.1
     dns-nameservers 192.168.1.1

Restart your network service to enable the new network configuration

    systemctl restart networking

Use ping to validate the network configuration is correct. 

    ping 192.168.1.200

Change the root passwd if you don't know the current password of the Linux on DP-8020 board

    passwd 
	
## Make the executable file and execute
    cd /root/deephi_dnndk_v2.07_beta/DP-8020/samples/resnet50
	make
	./resnet50
	
You should be able to see the demo now.
