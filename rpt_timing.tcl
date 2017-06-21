# example
# rpt_timing clock_245 5000 8
proc rpt_timing { target_domain max_paths log_level} {

	if {[info exist path_start_bram]} {unset path_start_bram	}
	if {[info exist path_end_bram  ]} {unset path_end_bram  	}
	if {[info exist path_start_dsp ]} {unset path_start_dsp 	}
	if {[info exist path_end_dsp   ]} {unset path_end_dsp      	}
	if {[info exist path_others    ]} {unset path_others    	}
	if {[info exist path_long      ]} {unset path_long      	}

	set all_paths [get_timing_paths -max_paths $max_paths -slack_lesser_than 0.5 -group $target_domain]

	foreach path $all_paths {
		set logic_level [get_property LOGIC_LEVELS $path]
		
		set start_cell_type [get_property PRIMITIVE_GROUP [get_cells -of_object [get_property STARTPOINT_PIN $path]]]
		set end_cell_type 	[get_property PRIMITIVE_GROUP [get_cells -of_object [get_property ENDPOINT_PIN $path]]]
		
		if {$logic_level > $log_level } {
			lappend path_long $path
		} elseif {$start_cell_type == "BLOCKRAM" } {
			lappend path_start_bram $path
		} elseif {$end_cell_type == "BLOCKRAM"} {
			lappend path_end_bram $path
		} elseif {$start_cell_type == "ARITHMETIC" } {
			lappend path_start_dsp $path	
		} elseif {$end_cell_type == "ARITHMETIC"} {
			lappend path_end_dsp $path	
		} else {
			lappend path_others $path
		}	
	}

	llength $all_paths


	if {[info exist path_start_bram]} {put [llength $path_start_bram];report_timing -of_objects $path_start_bram -name path_start_bram}
	if {[info exist path_end_bram  ]} {put [llength $path_end_bram	];report_timing -of_objects $path_end_bram -name path_end_bram	  }
	if {[info exist path_start_dsp ]} {put [llength $path_start_dsp	];report_timing -of_objects $path_start_dsp -name path_start_dsp  }
	if {[info exist path_end_dsp   ]} {put [llength $path_end_dsp	];report_timing -of_objects $path_end_dsp -name path_end_dsp	  }
	if {[info exist path_others    ]} {put [llength $path_others	];report_timing -of_objects $path_others -name path_others		  }
	if {[info exist path_long      ]} {put [llength $path_long		];report_timing -of_objects $path_long -name path_long			  }
}


