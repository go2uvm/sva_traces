interface blobclk_if (input clk);
 logic enb, reset_n;
  logic req, ack, done, intrpt;

   clocking cb @(posedge clk);
output enb, reset_n;
  output req, ack, done, intrpt;
   
 


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
module top;
   timeunit 1ns;
   timeprecision 1ns;

  logic clk=0;
 initial forever #10 clk = !clk;  //Instantiate the Interface 
  blobclk_if if_0 (.*);
   
 m_equivalent dut (.clk(clk),
                     .enb(if_0.enb),
		     .reset_n(if_0.reset_n),
		     .req(if_0.req),
                         .ack(if_0.ack),
 .done(if_0.done),
 .intrpt(if_0.intrpt)
                 

                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
