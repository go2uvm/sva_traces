# clear the console
clear

# create project library and make sure it is empty
alib work
adel -all


# compile project's source file (alongside the UVM library)
alog $UVMCOMP -msg 0 -dbg -f flist.enc.rvra      

transcript file m9_12.log

# run simulation
vsim -novopt -assertdebug +UVM_VERBOSITY=UVM_LOW 
asim +access +rw  $UVMSIM +UVM_VERBOSITY=UVM_FULL
wave -rec sim:/* 
run -all; quit
