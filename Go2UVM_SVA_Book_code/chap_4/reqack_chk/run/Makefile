questa: clean
	qverilog -f flist
clean:
	\rm -fr work* qver* *.wlf


#	rv:clean
#	vlib work
#	vlog -dbg -f flist +incdir+../sample_sva_w_UVM_stim +define+ALDEC
#	vsim -c updown_top -do "run;quit"


rvra: clean
	vsim -c -do rvra_run.do
