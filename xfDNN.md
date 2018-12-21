# xfDNN environment installation with Alveo boards on UBUNTU 16.4
## This was for xfDNN v1.2 . On the xfDNN v1.3, the overlay bug has been fixed.
## Install the Alevo U200 board
Power down the server and make sure you are ESD free to avoid potential hardware damage happening. 

Plug in the Alveo board, make sure the AUX power cable is connected correctly. Alveo boards currently need 8pin PCIe AUX power supply which is different from Nvidia acceleration card. Some servers only provide the AUX power cable for 8pin CPU connector. You may need to contact vendor to get the right power cable. 

power on the server and execute following command to see if the Alveo card already detected by BIOS.

    sudo lspci -vd 10ee:	
If you see following output, it means the Alveo boards have already been detected at operation system.
 
    d8:00.0 Processing accelerators: Xilinx Corporation Device 5001
            Subsystem: Xilinx Corporation Device 000e
            Flags: bus master, fast devsel, latency 0, IRQ 11
            Memory at f2000000 (32-bit, non-prefetchable) [size=32M]
            Memory at f4020000 (32-bit, non-prefetchable) [size=64K]
    
  

## Install the XRT
Go to following link to download Xilinx runtime (XRT) and Deployment shell (DSA)

https://www.xilinx.com/products/acceleration-solutions/xilinx-machine-learning-suite.html#gettingStartedU200

Download the Xilinx Runtime

Download the Deployment Shell 

Install the XRT and DSA from downloaded install packages

    sudo apt install <deb-dir>/xrt_<version>.deb
    sudo apt install <deb-dir>/xilinx_u200_xdma_<version>.deb

Check if the XRT has been installed successfully. 


    sudo xbutil flash scan

You should be able to see following output:

    Card [0]
            Card BDF:               0000:d8:00.1
            Card type:              u200
            Flash type:             SPI
            DSA running on FPGA:
                    xilinx_u200_xdma_201820_1,[TS=0x000000005b891ee3]
            DSA package installed in system:
                    xilinx_u200_xdma_201820_1,[TS=0x000000005b891ee3],[BMC=1.8]
				

## Flash the Alveo board  with the installed DSA
Flash the board if you noticed the runing DSA version is not match with installed DSA package 
	
    sudo /opt/xilinx/xrt/bin/xbutil flash -a xilinx_u200_xdma_201820_1 -t 0x000000005b891ee3
You will see the following output:

    INFO: ***Found 880 ELA Records
    Idcode byte[0] ff
    Idcode byte[1] 20
    Idcode byte[2] bb
    Idcode byte[3] 21
    Idcode byte[4] 10
    Enabled bitstream guard. Bitstream will not be loaded until flashing is
    finished.
    Erasing flash............................................
    Programming flash............................................
    Cleared bitstream guard. Bitstream now active.
    DSA image flashed succesfully
    Cold reboot machine to load the new image on FPGA

Cold reboot the server. After the system rebooted, use following command to validate the Alveo environement

    sudo xbutil validate
 
You will see following message:

    INFO: Found 1 cards
	
	
    The displayed messsage is similar as following:
    INFO: Validating card[0]: xilinx_u200_xdma_201820_1
    INFO: Checking PCIE link status: PASSED
    INFO: Starting verify kernel test:
    INFO: verify kernel test PASSED
    INFO: Starting DMA test
    Host -> PCIe -> FPGA write bandwidth = 11587.2 MB/s
    Host <- PCIe <- FPGA read bandwidth = 12148 MB/s
    INFO: DMA test PASSED
    INFO: Starting DDR bandwidth test: ............
    Maximum throughput: 45405.914062 MB/s
    INFO: DDR bandwidth test PASSED
    INFO: Card[0] validated successfully.
    
    INFO: All cards validated successfully.

If you see above message, it means you have successfully deployed the DSA and XRT. The Alveo board is ready for the xfDNN application now. 

Please refer to UG1301 for the details if you meet any issues


## Install xfDNN

    git clone https://github.com/Xilinx/ml-suite.git

### Download the overlay and models
https://www.xilinx.com/products/acceleration-solutions/xilinx-machine-learning-suite.html#gettingStartedU200

* Download the ML Suite Overlays
* Download the ML Suite Pre-Trained Models

Overlays: Download and unzip desired overlays into the ml-suite/overlaybins/alveo-u200 dir.

Pre-Trained Models: Download and unzip to the /ml-suite/models dir.

### Install anaconda 

Follow the following link to install anaconda

https://github.com/Xilinx/ml-suite/blob/master/docs/tutorials/anaconda.md

### Run example
change to bash shell if you are not bash shell

    Bash

Activate Environmen

    conda activate ml-suite
   
    cd ~/ml-suite/examples/benchmark
    ./run.sh
   
# One bug need to be fixed if you run into the following error
	
    loading ../../overlaybins/alveo-u200/overlay_0.xclbin
    ERROR: Failed to create compute program from binary -42

    cd ~/ml-suite/overlaybins/alveo-u200
    mv overlay_0.xclbin overlay_0.xclbin.bak
    ln -s xdnn_v2_32x28_4pe_8b_4mb_bank21.xclbin overlay_0.xclbin
	
	
Then, try the example again.
	
	cd ~/ml-suite/examples/benchmark
    ./run.sh
	
If you see following output, it means you have installed xfDNN successfully!!!!

    [XBLAS] # kernels: 1
    CL_PLATFORM_VENDOR Xilinx
    CL_PLATFORM_NAME Xilinx
    CL_DEVICE_0: 0x20f3950
    CL_DEVICES_FOUND 1, using 0
    loading ../../overlaybins/alveo-u200/overlay_0.xclbin
    [XBLAS] kernel0: kernelSxdnn_0
    [XDNN] loading xclbin settings from ../../overlaybins/alveo-u200/overlay_0.xclbin.json
    [XDNN] using custom DDR banks 2,2,1,1
    
    [XDNN] kernel configuration
    [XDNN]   num cores        : 2
    [XDNN]   dsp array width  : 28
    [XDNN]   img mem size     : 4 MB
    [XDNN]   version          : 2.3
    [XDNN]   8-bit mode       : 1
    [XDNN]   Max Image W/H    : 1023
    [XDNN]   Max Image Depth  : 4095
    [XDNN]   Max Filter Depth : 0
    
    Loading weights/bias/quant_params to FPGA...
    Running inference...
    
    ===========================================
    Performance Summary
    
      Network: googlenet_v1
      Precision: 8
      Images: 32768
      Batch Size: 8
      Total Batches: 4096
      Total Time: 20719.68 ms
      SIL: 5.06 ms
      FPS: 1581.49
      GOPS: 5022.98
    ===========================================

	
