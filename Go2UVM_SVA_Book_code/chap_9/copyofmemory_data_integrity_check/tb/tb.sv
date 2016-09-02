
class c_xactn;
    rand bit write; // memory write
    rand bit read;  // memory read
    rand int wdata; // data written to memory
    rand bit[31:0] addr;  // memory address 
    constraint addr_range_cst { addr <= 15 ;}
    constraint no_wr_and_rd_cst { !(read && write);}
endclass : c_xactn
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

    always_ff @ (posedge clk) begin 
        if(!c1.randomize())  $error("c1 randomization failure"); 
        write <= c1.write; 
        read  <= c1.read; 
        wdata <= c1.wdata;  
        addr  <= c1.addr; 
    end 
endmodule : top1 
// vlog -mfcu memory_data_integrity_check.sv
// vsim -novopt -assertdebug top

