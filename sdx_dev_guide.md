#  How to change kernel working clock frequency (Need confirm)
add this occ parameters on link and compile phases

    --kernel_frequency 200
	
#  How to validate kernel in HLS 
## May need to create a new testbench for HLS
1. Change the interface data bus width to match kernel
2. Remove offset from axi_lite interface which may cause hardware emulation failure
3. Try to use same data width for interfaces bundled together

#  Assign long variable with initial value

    res_w[i]  = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
   HLS will report this warning: integer constant is too large for its type	
   Change to this could make it works
    res_w[i]  = "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	


# several kernels with same functions in lib file
   for the SW emulation, add lib file to the first kernel. Don't add lib file to other kernels. 
   for the HW emulation and system, need add lib to each kernel
   
   

	