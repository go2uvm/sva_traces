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

import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;


interface sva_if (input clk);
    logic read,write,rd_served,interrupt,wr_served; 

  clocking cb @(posedge clk);
    inout read,write,rd_served,interrupt,wr_served; 

  endclocking : cb

endinterface : sva_if
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
 begin @(vif.cb); 
        if(!randomize(vif.cb.read, vif.cb.write, vif.cb.rd_served, vif.cb.interrupt, vif.cb.wr_served))  $error("randomization failure");   
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
   m9_13 dut (.clk(clk),
                    
		    .read(if_0.read),
		    .write(if_0.write), 
		    .interrupt(if_0.interrupt),
		    .rd_served(if_0.rd_served),
		    .wr_served(if_0.wr_served)
		    
 ); 
		      uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


