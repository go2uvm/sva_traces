interface smpl_if (input clk);
   
   logic a,b,c;
   clocking cb @(posedge clk);
     input    a;
     input    b;
     inout    c;
    
   endclocking : cb
 endinterface : smpl_if  

 import uvm_pkg::*;
   `include "uvm_macros.svh"
 
 import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual smpl_if vif;
    task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    repeat(10) @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
     int i;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
            @ (vif.cb);
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test

//`timescale 1ns/100
module top;
   timeunit 1ns;
   timeprecision 1ns;

  logic clk = 0;
  initial forever #10 clk = !clk;
 
  //Instantiate the Interface 
  smpl_if if_0 (.*);

  smpl dut (.clk(clk),
                     .a(if_0.a),
		     .b(if_0.b),
		     .c(if_0.c)                     
                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
