# clear the console
clear

adel -all
# create project library and make sure it is empty
alib work


# compile project's source file (alongside the UVM library)
alog $UVMCOMP -msg 0 -dbg -f flist.enc_3.rvra      

transcript file fifo4.log

# run simulation
asim +access +rw  $UVMSIM +UVM_VERBOSITY=UVM_FULL
wave -rec sim:/* 
run -all; quit
