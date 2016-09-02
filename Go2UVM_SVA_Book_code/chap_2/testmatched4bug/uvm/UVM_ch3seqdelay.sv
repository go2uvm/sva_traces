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


interface sva_if (input clk
);
    logic sysclk,a_sysclk,b_sysclk,c,d_clk,a_clk;

    clocking cb @(posedge clk);
output sysclk,a_sysclk,b_sysclk,c,d_clk,a_clk;

        endclocking : cb

endinterface : sva_if
import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;

class uvm_sva_test extends go2uvm_base_test;
  virtual sva_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    repeat(10) @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
     int i;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
            @ (vif.cb);
 begin
     repeat(10) 	
     @ (vif.cb);vif.cb.c <= 1'b1;
      @ (vif.cb);vif.cb.c <= 1'b1;
     repeat(2) 
      @ (vif.cb);vif.cb.d_clk <= 1'b1;
    
      @ (vif.cb);vif.cb.d_clk <= 1'b0;
     
   end

  begin
     repeat(2) 	
      @ (vif.cb);vif.cb.a_sysclk <= 1'b1;
     
      @ (vif.cb);vif.cb.a_sysclk <= 1'b1;vif.cb.b_sysclk<= 1'b1;
     repeat(4) 
     
      @ (vif.cb);vif.cb.b_sysclk <= 1'b0;
     repeat(2) 
      $finish;
  end 

  



           `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
    timeunit 1ns;   timeprecision 100ps;
    logic clk=0;
    initial forever #10 clk=!clk; 

    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
  testmatched dut (.clk(clk),
										.a_clk(if_0.a_clk),
										.a_sysclk(if_0.a_sysclk),
                    .b_sysclk(if_0.b_sysclk),
                    .d_clk(if_0.d_clk),
                    .c(if_0.c),
                    .sysclk(if_0.sysclk)

                                      );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


