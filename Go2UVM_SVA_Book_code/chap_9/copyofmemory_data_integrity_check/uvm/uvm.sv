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

c_xactn c1=new(); 
 

interface sva_if (input clk);
   logic write; // memory write
    logic read;  // memory read
    int wdata; // data written to memory
    int rdata; // data read from memory
    logic[31:0] addr;  // memory address 
    logic reset_n=1'b1; // active low reset

  clocking cb @(posedge clk);
  inout write; // memory write
    inout read;  // memory read
    inout wdata; // data written to memory
    inout rdata; // data read from memory
    inout addr;  // memory address 
    inout reset_n; // active low reset
    
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
begin @ (vif.cb);
        if(!c1.randomize())  $error("c1 randomization failure"); 
        @ (vif.cb); vif.cb.write <= vif.cb.write; 
        @ (vif.cb); vif.cb.read  <= vif.cb.read; 
        @ (vif.cb); vif.cb.wdata <= vif.cb.wdata;  
        @ (vif.cb); vif.cb.addr  <= vif.cb.addr; 
    end 


      
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top2;
    timeunit 1ns;   timeprecision 100ps;
    logic clk=0;
    initial forever #10 clk=!clk; 

    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT       
               top dut (.clk(clk),
                    .read(if_0.read),
                    .reset_n(if_0.reset_n),
                    .write(if_0.write),
                    .rdata(if_0.rdata),
                    .wdata(if_0.wdata),
                    .addr(if_0.addr)
                                       );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top2


