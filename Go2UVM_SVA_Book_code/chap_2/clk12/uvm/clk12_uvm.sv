/*
    Code for use with the book
    "SystemVerilog Assertions Handbook, 2nd edition"ISBN  878-0-9705394-8-7

    Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2009 

    www.systemverilog.us  ben@systemverilog.us
    www.cvcblr.com, info@cvcblr.com

    All code provided in this book and in the accompanied website is distributed
    with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
    the authors nor any supporting vendors shall be liable for damage in connection
    with, or arising out of, the furnishing, performance or use of the models
    provided in the book and website.
*/


interface sva_if (input clk0);
    logic  clk_1, clk_2, clk_1b; 
 
  clocking cb @(posedge clk0);
   output clk_1, clk_2, clk_1b; 
  endclocking : cb

endinterface : sva_if
import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;

class uvm_sva_test extends go2uvm_base_test;
  virtual sva_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
   
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
         `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
        
             
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
    timeunit 1ns;   timeprecision 100ps;
    logic clk=0;
   initial forever #10 clk=!clk; 
    always @ (posedge if_0.clk0)if_0.clk_1 <=!if_0.clk_1;
    always @ (posedge if_0.clk_1)if_0.clk_2 <=!if_0.clk_2;


    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
   clk12 dut (.clk0(clk0),
                   // .clk0(if_0.clk0),
                    .clk_1(if_0.clk_1),
                    .clk_1b(if_0.clk_1b),
                    .clk_2(if_0.clk_2)
                    );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


