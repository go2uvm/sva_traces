# clear the console
clear

# create project library and make sure it is empty
alib work
adel -all


# compile project's source file (alongside the UVM library)
alog $UVMCOMP   -msg 0 -dbg -f flist.enc.rvra      

transcript file section8_2.log

# run simulation
asim +access +rw  $UVMSIM +UVM_VERBOSITY=UVM_FULL
wave -rec sim:/* 
run -all; quit
