
module top1;
    timeunit 1ns;   timeprecision 100ps;
    bit write; // memory write
    bit read;  // memory read
    int wdata; // data written to memory
    int rdata; // data read from memory
    bit[31:0] addr;  // memory address 
    bit reset_n=1'b1; // active low reset
    bit clk=1'b1;   // clock
    c_xactn c1=new(); 
top dut (.*);
default clocking cb @(posedge clk);
endclocking

    initial forever #50 clk=!clk;
always @ (posedge clk)
	assert(randomize(write, read, wdata, rdata, addr));
   endmodule : top1 
// vlog -mfcu memory_data_integrity_check.sv
// vsim -novopt -assertdebug top

