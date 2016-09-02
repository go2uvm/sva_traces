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
 
    logic a, b, d;
    int min, max;  
    logic addr; 
    logic data; 
    logic cache_mem;  
    logic  a3, b3; 


   clocking cb @(posedge clk);
output  a, b, d,min, max,addr,data, cache_mem; 
input a3,b3; 
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
   top2 dut (.clk(clk),
           .a(if_0.a),
           .b(if_0.b),
           .d(if_0.d),
           .addr(if_0.addr),
           .data(if_0.data),
           .cache_mem(if_0.cache_mem) 
                  
                                     );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


