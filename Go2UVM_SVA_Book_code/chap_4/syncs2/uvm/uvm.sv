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
  logic  a, b, c, d, e, f,g, h, enb;


  clocking cb @(posedge clk);
   output a, b, c, d,g;
 input  e, f, h, enb;
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
   logic clk=0;
  initial forever #10 clk=!clk; 

    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
   syncs2 dut (.clk(clk),
                  
                    .a(if_0.a),
                    .b(if_0.b),
                    .c(if_0.c),
                    .d(if_0.d),
                     .e(if_0.e),
                    .f(if_0.f),
                    .g(if_0.f),
                     .h(if_0.h),
                       .enb(if_0.enb)
                                       
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


