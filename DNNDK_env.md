Before getting started to install the linux and tools, you need to be careful about the versions of tools. Please refer to DNNDK user guide for the specific versions for each tools. Here is an example of the combination of Ubuntu 16.04.05, CUDA 9.0, cuDNN 7.05 and NCCL 1.3.5. Please follow the process to install drivers and tools step by step.

# 1. Ubuntu installation (16.04.05)
Go to the following link to download the older versions if the latest version is not preferred. 

https://launchpad.net/ubuntu/+cdmirrors?_ga=2.27638011.653245225.1542959555-619594991.1541750444

You could easily find detailed instructions and guideline to install Ubuntu, I don't want to spend more time on this topic.
 
If you ran into issues related to the video card during Ubuntu installation, you could give it a try on the Ubuntu server version. You could install the GUI desktop later after successfully installed the Ubuntu operation system. 

#### Ubuntu GUI desktop installation
The following command could help you to install GUI desktop if you installed Ubuntu server version instead of desktop version 

    sudo apt-get update
    sudo apt-get install ubuntu-desktop

# 2. Nvidia driver installation
### Easy way to install
If the Nvidia card is the only video card in your system, it's easy to install driver as following:

    sudo apt-get install nvidia-384 nvidia-modprobe

If you run into the following conditions, you have to install driver from the run file which could be downloaded from Nvidia website

   1. You don't want to install the driver version which was compiled for Ubuntu distribution version
   2. The video card is not supported by the compiled driver
   3. You have two video cards and the one you are connecting to display is not the Nvidia card (like Intel video card). Especially, when you are using Tesla series acceleration card without display output, you may run into GUI desktop login loop issue. In this case, you have to try following solution. 

NOTE: if you successfully installed driver through apt-get command, don't need to do following steps. Jump to verify driver installation step

### Install driver from run file

#### Turn off Secure Boot option is the BIOS if you are booting from UEFI 

#### Download the driver from Nvidia 

https://www.nvidia.com/Download/index.aspx?lang=en-us

Choose Linux 64 bit from Operation System category, and then you will download a NVIDIA-Linux-x86_64-xxx.xxx.run file. 

#### Install Dependencies

    sudo apt-get install build-essential gcc-multilib dkms

#### Creat Blacklist for Nouveau Driver
Create a file at /etc/modprobe.d/blacklist-nouveau.conf.

    sudo vi /etc/modprobe.d/blacklist-nouveau.conf

Add following:

    blacklist nouveau
    options nouveau modeset=0

#### Then, execute following command and reboot

    sudo update-initramfs -u
    sudo reboot

#### After the system reboot, stop desktop manager. You could use Ctrl+Alt+F1 to switch to terminal mode

    sudo service lightdm stop

#### Finally you could execute the downloaded run file from Nvidia

    chmod +x NVIDIA-Linux-x86_64-xxx.xxx.run
    sudo ./NVIDIA-Linux-x86_64-xxx.xxx.run --dkms -s
NOTE: Change xxx to the specific  number of your downloaded run file

NOTE: Remember to add --no-opengl-files parameter in case you have a non-NVIDIA (AMD or Intel) graphic is used for display while NVIDIA graphics are used for computing acceleration.

### Verify successfull driver installation
After successfully installed driver, you could verify through following command:

    nvidia-smi

The output should looks like:

    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 410.78       Driver Version: 410.78       CUDA Version: 10.0     |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Quadro K2100M       Off  | 00000000:01:00.0 Off |                  N/A |
    | N/A   65C    P5    N/A /  N/A |      0MiB /  1992MiB |      2%      Default |
    +-------------------------------+----------------------+----------------------+
    
    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+

# 2. CUDA install (9.0)
Go to the following link to select older version 9.0, then choose your corresponding OS type and runfile from installer type. 

https://developer.nvidia.com/cuda-toolkit-archive

    chmod +x cuda_9.0.176_384.81_linux.run
    ./cuda_9.0.176_384.81_linux.run --extract=$HOME
    cd $HOME
    sudo ./cuda-linux.9.0.176-22781540.run
    sudo bash -c "echo /usr/local/cuda/lib64/ > /etc/ld.so.conf.d/cuda.conf"
    sudo ldconfig

Add CUDA path into search path

    sudo vi /etc/environment

Append :/usr/local/cuda/bin to the PATH search list

    source /etc/environment
    which nvcc

It should display as following, then it means that CUDA was successfully installed!

    /usr/local/cuda/bin/nvcc

# 3. cuDNN install (7.05)

Go to following link, and you will need to register an account to proceed. Select cuDNN v7.0.5 Library for Linux to download file cudnn-9.0-linux-x64-v7.solitairetheme8 

https://developer.nvidia.com/rdp/cudnn-archive

Install cuDNN

    sudo cp cudnn-9.0-linux-x64-v7.solitairetheme8 /usr/local
    cd /usr/local
    sudo tar zxvf cudnn-9.0-linux-x64-v7.solitairetheme8
    sudo rm cudnn-9.0-linux-x64-v7.solitairetheme8
    sudo ldconfig 

# 3. NCCL install (1.3.5)

Go to the following link to download the NCCL from Xilinx forum

https://forums.xilinx.com/t5/Deephi-DNNDK/Questions-about-DNNDK-installation/td-p/901293

    tar zxvf nccl1.tar.gz
    cd nccl-master
    sudo make install -j

# 4. Install dependency libraries

    sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev python-numpy python-scipy python-matplotlib python-sklearn python-skimage python-h5py python-protobuf python-leveldb python-networkx python-nose python-pandas python-gflags ipython protobuf-c-compiler protobuf-compiler   libboost-regex-dev libyaml-cpp-dev g++ git make build-essential autoconf libtool libopenblas-dev libgflags-dev libgoogle-glog-dev libopencv-dev libprotobuf-dev protobuf-compiler libleveldb-dev liblmdb-dev libhdf5-dev libsnappy-dev libboost-system-dev libboost-thread-dev libboost-filesystem-dev libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev  python-numpy python-scipy python-matplotlib python-sklearn python-skimage python-h5py python-protobuf python-leveldb python-networkx python-nose python-pandas python-gflags ipython protobuf-c-compiler protobuf-compiler python-opencv python-numpy libyaml-dev libyaml-cpp-dev

# 5. Install DECENT and DNNC
Download DNNDK from following link

http://www.deephi.com/technology/dnndk

    tar zxvf deephi_dnndk_v2.07_beta.tar.gz
    cd deephi_dnndk_v2.07_beta
    cd host_x86/
    sudo ./install.sh ZCU102
    cd /usr/local/bin
    ./dnnc
    ./decent

If you could finally see following output, that means you have completed all the install process successfully!!!

    decent: command line brew
    usage: fix_tool <command> <args>
    
    commands:
      quantize        transform float model to fix (need calibration with dataset) and deploy to DPU
      deploy          deploy finetuned model to DPU
      finetune        train or finetune a model
      test            score a model
    example:
      1. quantize:                      ./decent_q quantize -model float.prototxt -weights float.caffemodel -gpu 0
      2. quantize with auto test:       ./decent_q quantize -model float.prototxt -weights float.caffemodel -gpu 0 -auto_test -test_iter 50
      3. quantize with method 0:        ./decent_q quantize -model float.prototxt -weights float.caffemodel -gpu 0 -method 0
      4. finetune quantized model:      ./decent_q finetune -model fix_results/float_train_test.prototxt -weights fix_results/float_train_test.caffemodel -gpu 0
      5. deploy finetuned fixed model:  ./decent_q depoly -model fix_train_test.prototxt -weights fix_finetuned.caffemodel -gpu 0
