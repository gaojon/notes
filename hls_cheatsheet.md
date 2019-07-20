# register without change
    #pragma HLS INTERFACE ap_stable port=lib_num
	
# infer fifo instead of RAM
    #pragma HLS STREAM variable=c_dat depth=8
	
# concurrency of functions
	ug1197
    void foo_1 (a,b,c,d,*x,*y) {
    ...
    func_A(a,b,&x);
    func_B(c,d,&y);
    }
In function foo_1, there is no data dependency between functions func_A and func_B.Even though they appear serially in the C code, Vivado HLS implements an architecture where both functions start to process data at the same time in the first clock cycle.

    void foo_2 (a,b,c,*x,*y) {
    int *inter1;
    ...
    func_A(a,b,&inter1,&x);
    func_B(c,d,&inter1,&y)
    }
In function foo_2, there is a data dependency between the functions. Internal variable inter1 is passed from func_A to func_B. In this case, Vivado HLS must schedule function func_B to start only after function func_A is finished. But we could leverage the DATA_FLOW grammar to reduce latency to start func_B as soon as part of inter1 data is ready. 

# loops
* Loops are always scheduled to execute in order

Even there is no dependency between loop SUM_X and SUM_Y, however, they will always be scheduled in the order they appear in the code.

* Loops by default are left "rolled"

This means that Vivado HLS synthesizes the logic in the loop body once and then executes this logic serially until the loop termination limit is reached. Loops can be "unrolled" allowing all the operations to occur in parallel but creating multiple copies of the loop hardware, or they can be pipelined to improve performance.

#  Arrays
* ARRAY_PARITION vs ARRAY_RESHAPE

If the ARRAY_PARITION directive is used to improve the initiation interval you might want to
consider using the ARRAY_RESHAPE directive instead. The ARRAY_RESHAPE optimization
performs a similar task to array partitioning however the reshape optimization re-combines
the elements created by partitioning into a single block RAM with wider data ports.




# pipeline and dataflow

* pipeline impact

This is a requirement for pipelining: there cannot
be sequential logic inside the pipeline.

* pipeline could be used to decrease latency without much area increase

Reduces the initiation interval by allowing the concurrent execution of operations within a loop or function.

* dataflow used on task, loop and function, level

Functions and loops are considered tasks. The DATAFLOW directive can be used to pipeline tasks, allowing them to execute concurrently if data dependencies allow. Since the execution delay of each tasks is not equal and uncertain, Fifos or RAMs will be introduced between task to bridge and buffer the data.

* Some functions and loops contain sub-functions

If the sub-function is not pipelined,
the function above it might show limited improvement when it is pipelined. The
non-pipelined sub-function will be the limiting factor.

* Some functions and loops contain sub-loops

When you use the PIPELINE directive, the
directive automatically unrolls all loops in the hierarchy below. This can create a great
deal of logic. It might make more sense to pipeline the loops in the hierarchy below.

* buffer between tasks after applied DATA_FLOW

If you used the DATAFLOW optimization and Vivado HLS cannot determine whether the
tasks in the design are streaming data, Vivado HLS implements the memory channels
between dataflow tasks using ping-pong buffers. If the design is pipelined and the data is
streaming from one task to the next, you can greatly reduce the area by using the dataflow
configuration config_dataflow to convert the ping-pong buffers used in the default
memory channels into FIFO buffers. You can then set the FIFO depth to the minimum
required size


# Dataflow rules
1.Single-producer-consumer Violations

Each variable must be driven from a single task and only be consumed by a single task. It means we could only drive one variable in one task and consume it in another. If the variable do needed in two tasks, we need to use a task to split the source to two different variables. 

2.Bypassing Tasks

All the outputs from the previous tasks should be all consumed by next one. If there are few of them jumping to next tasks will cause performance issues

3.Feedback Between Tasks
Feedback occurs when the output from a task is consumed by a previous task in the DATAFLOW
region. Feedback between tasks is not permitted in a DATAFLOW region

4.Bundled bus interface can only be read or write in one task

5.One specific interface can only be read or write in one task

6.Need continuous data flow between tasks

# Performance tunning


# Interfaces definition
1. Don't use offset if the design for sdx
2. Leave enough depth for pointer on top function. Especially pay attention to this when you changed your testing data from smaller to bigger one.

    #pragma HLS INTERFACE m_axi depth=128 port=lib offset=slave bundle=gmem0
