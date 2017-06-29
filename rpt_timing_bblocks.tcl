# example
# rpt_timing_bblcoks hierachy
# rpt_timing_bblock u_pl_top/u_dpd/u_dpd_for_single_a0 500 10
proc rpt_timing_bblock { module_name max_paths slack  {

	if {[info exist path_start_bram]} {unset path_start_bram	}
	if {[info exist path_end_bram  ]} {unset path_end_bram  	}
	if {[info exist path_start_dsp ]} {unset path_start_dsp 	}
	if {[info exist path_end_dsp   ]} {unset path_end_dsp      	}
	if {[info exist path_block2block  ]} {unset path_block2block      	}

	set all_brams [get_cells -hierarchical -filter { PRIMITIVE_TYPE =~ BLOCKRAM.*.* } -regexp ${module_name}/.*]
	set all_dsps  [get_cells -hierarchical -filter { PRIMITIVE_TYPE =~ ARITHMETIC.*.* } -regexp ${module_name}/.*]

	set path_start_bram [get_timing_paths -slack_lesser_than $slack -from $all_brams -max_paths $max_paths]
	set path_end_bram [get_timing_paths -slack_lesser_than $slack -to $all_brams -max_paths $max_paths]

	set path_start_dsp [get_timing_paths -slack_lesser_than $slack -from $all_dsps -max_paths $max_paths]
	set path_end_dsp [get_timing_paths -slack_lesser_than $slack -to $all_dsps -max_paths $max_paths]

	set path_block2block [get_timing_paths -slack_lesser_than $slack -from [list $all_brams $all_dsps] -to [list $all_brams $all_dsps] -max_paths $max_paths]




	if {[info exist path_start_bram]} {put [llength $path_start_bram];report_timing -of_objects $path_start_bram -name path_start_bram}
	if {[info exist path_end_bram  ]} {put [llength $path_end_bram	];report_timing -of_objects $path_end_bram -name path_end_bram	  }
	if {[info exist path_start_dsp ]} {put [llength $path_start_dsp	];report_timing -of_objects $path_start_dsp -name path_start_dsp  }
	if {[info exist path_end_dsp   ]} {put [llength $path_end_dsp	];report_timing -of_objects $path_end_dsp -name path_end_dsp	  }
	if {[info exist path_block2block   ]} {put [llength $path_block2block	];report_timing -of_objects $path_block2block -name path_block2block	  }
}


