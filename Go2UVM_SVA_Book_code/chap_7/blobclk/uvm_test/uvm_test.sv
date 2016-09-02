interface blobclk_if (input clk13);
  logic clk10,a,b,c; 
  
   
   clocking cb @(posedge clk13);
     output   clk10;
     output    a;
     output    b;
     output    c;
    
   endclocking : cb
 endinterface : blobclk_if  

 import uvm_pkg::*;
   `include "uvm_macros.svh"
 
 import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual blobclk_if vif;
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

  logic clk13 = 0;
  logic clk10 =0 ;
  initial forever #10 clk13 = !clk13;
  initial forever #10 clk10 = !clk10;  //Instantiate the Interface 
  blobclk_if if_0 (.*);

  t dut (.clk13(clk13),
            .clk10(if_0.clk10),
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
