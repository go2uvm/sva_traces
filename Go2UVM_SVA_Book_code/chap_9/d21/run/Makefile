questa: clean
	qverilog -f flist
clean:
	\rm -fr work* qver* *.wlf


rvra: clean
	vsim -c -do rvra_run.do
