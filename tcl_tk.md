#conditional statement
if {$vbl == 1} {
   puts "vbl is one"
} elseif {$vbl == 2} {
   puts "vbl is two"
} else {
   puts "vbl is not one or two"
}



#arguments

argc argv argv0
All Tcl scripts have access to three predefined variables.
    $argc - number items of arguments passed to a script.
    $argv - list of the arguments.
    $argv0 - name of the script.

To use the arguments, the script could be re-written as follows.

    if { $argc != 2 } {
        puts "The add.tcl script requires two numbers to be inputed."
        puts "For example, tclsh add.tcl 2 5".
        puts "Please try again."
    } else {
        puts [expr [lindex $argv 0] + [lindex $argv 1]]
        }
		
		
		
#exit from tcl code
	exit 1

		