questa: clean
	qverilog -f flist
clean:
	\rm -fr work* qver* *.wlf


rvra: clean
	vlib work
	vlog -dbg ../dut/cpu_cvg.sv
	#vsim -c -do rvra_run.do
	vsim -c +access +r cpu_module -do "run -all; fcover report -html;quit"
	firefox fcover_report.html &
 
