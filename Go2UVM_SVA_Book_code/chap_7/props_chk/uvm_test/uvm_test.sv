
interface props_if (input clk);
   
   logic load, reset_n,clk;
  logic [WIDTH-1:0] q, d,d_r;
;
   clocking cb @(posedge clk);
     output    load;
     output    reset_n;
     input    q,d,d_r;
    
   endclocking : cb
 endinterface : props_if  

 import uvm_pkg::*;
   `include "uvm_macros.svh"
 
 import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual props_if vif;
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
  props_if if_0 (.*);

  props_chk dut (.clk(clk),
                     .load(if_0.load),
		     .reset_n(if_0.reset_n),
		     .q(if_0.q),
                     .d(if_0.d),
                     .d_r(if_0.d_r)
                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
