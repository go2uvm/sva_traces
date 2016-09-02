interface blobclk_if (input clk);
  logic write, read; 
logic [31:0] wdata;
    logic [31:0] rdata;  // data read from memory
    logic [31:0]  addr;  // memory address -- small for simulation 
    logic  reset_n; // active low reset
     
   
   clocking cb @(posedge clk);
output  write,read;  // memory read
    output wdata; // data written to memory
    output rdata;  // data read from memory
    output addr;  // memory address -- small for simulation 
    output  reset_n; // active low reset
 


    endclocking : cb
 endinterface : blobclk_if  

 import uvm_pkg::*;
   `include "uvm_macros.svh"
 
 import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual blobclk_if vif;
    task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    //repeat(10) @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
        `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
          


                                           
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test

//`timescale 1ns/100
module top1;
   timeunit 1ns;
   timeprecision 1ns;
 logic clk=0;
 initial forever #10 clk = !clk;  //Instantiate the Interface 
  blobclk_if if_0 (.*);
    memory_data_integrity_check dut (.clk(clk),
                     .read(if_0.read),
		     .write(if_0.write),
		     .wdata(if_0.wdata),
.rdata(if_0.rdata),
.addr(if_0.addr),
.reset_n(if_0.reset_n)

                    
                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule : top1
