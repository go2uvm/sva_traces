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


interface sva_if (input clk);
   logic clk0,clk1,clk2, a,b,c,d,e;

  clocking cb @(posedge clk);
    output clk0,clk1,clk2, a,b,c,d,e; 
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

    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
        
     @ (vif.cb);
        
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
logic clk=0,clk0=0,clk1=0,clk2=0;
 initial forever #10 clk=!clk; 

 initial forever #10 if_0.clk0=!if_0.clk0; 

 initial forever #10 if_0.clk1=!if_0.clk1; 

 initial forever #10 if_0.clk2=!if_0.clk2; 


    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
   lce dut (.clk(clk),
                   .clk0(if_0.clk0),
                   .clk1(if_0.clk1),
                   .clk2(if_0.clk2),

                    .a(if_0.a),
                    .b(if_0.b),
                    .c(if_0.c),
                    .d(if_0.d),
                    .e(if_0.e)

                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


