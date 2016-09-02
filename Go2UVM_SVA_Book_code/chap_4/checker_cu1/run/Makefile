

#RVPRO

all:blobclk coverg fulture_gclk props_chk smpl

blobclk :clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/blobclk.sv
	vsim -c -O2 +access +r {t} -do "add wave *;run -all;quit" #
	
coverg:clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/coverg.sv
	vsim -c -O2 +access +r {coverx} -do "add wave *;run -all;quit"

future_gclk:cleani
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/future_gclk.sv
	vsim -c -O2 +access +r {future_gclk_test} -do "add wave *;run -all;quit"
props_chk:clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/props_chk.sv
	vsim -c -O2 +access +r {props_chk} -do "add wave *;run -all;quit"

smpl:clean
	vlib work
	vlog -dbg -sv +define+_VERBOSE ../src/smpl.sv
	vsim -c -O2 +access +r {smpl} -do "add wave *;run -all;quit"
clean:
	rm work -rf compile* dataset* librar* transcript *.wlf
rvra:	
	vsim -c -do rvra_run.do
