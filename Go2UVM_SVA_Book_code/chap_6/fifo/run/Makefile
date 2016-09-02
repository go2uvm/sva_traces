

#RVPRO

all: assert_control  fifo_assert_control fifo_props3 fifo_props  fifo_rtl1 fifo_rtl2 fifo_rtl fifo_tb2 fifo_tb 

assert_control :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/assert_control.sv
	vsim -c -O2 +access +r {assert_control } -do "add wave *;run -all;quit"
	
fifo_assert_control :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_assert_control.sv
	vsim -c -O2 +access +r {assert_control} -do "add wave *;run -all;quit"

fifo_props3 :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_props3.sv
	vsim -c -O2 +access +r {fifo_props } -do "add wave *;run -all;quit"
fifo_props :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_props.sv
	vsim -c -O2 +access +r {fifo_props} -do "add wave *;run -all;quit"

fifo_rtl1 :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_rtl1.sv
	vsim -c -O2 +access +r {fifo } -do "add wave *;run -all;quit"
fifo_rtl2 :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_rtl2.sv
	vsim -c -O2 +access +r {fifo } -do "add wave *;run -all;quit"
fifo_rtl :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_rtl.sv
	vsim -c -O2 +access +r {fifo } -do "add wave *;run -all;quit"


fifo_tb2 :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_tb2.sv
	vsim -c -O2 +access +r {fifo_tb } -do "add wave *;run -all;quit"
fifo_tb :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/fifo_tb.sv
	vsim -c -O2 +access +r {fifo_tb } -do "add wave *;run -all;quit"
clean:
	rm work -rf compile* dataset* librar* transcript *.wlf
rvra:clean
	vsim -c -do rvra_run.do
rvra_1:clean
	vsim -c -do rvra_run_1.do
rvra_2:clean
	vsim -c -do rvra_run_2.do
rvra_3:clean
	vsim -c -do rvra_run_3.do 
