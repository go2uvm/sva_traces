interface blobclk_if (input clk);
 logic   clk, a, b, c, d;
int   r;
   
   clocking cb @(posedge clk);
output a, b, c, d;
 


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
     int m,addr,TEST_NUM;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
          
                                           
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test

//`timescale 1ns/100
module top1;
   timeunit 1ns;
   timeprecision 1ns;
  logic clk=1;
 initial forever #10 clk = !clk;  //Instantiate the Interface 
  blobclk_if if_0 (.*);
    unit_chk dut (.clk(clk),
                     .a(if_0.b),
		     .b(if_0.b),
		     .c(if_0.c),
                          .d(if_0.d),
.r(if_0.r)
               

                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
