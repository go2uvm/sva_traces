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
    
logic read,reset_n,write;
l32_type addr;
l16_type wdata, rdata;

  clocking cb @(posedge clk);

output read,reset_n,write;
inout wdata;
input rdata;
inout addr;

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
              @(vif.cb);      
 begin : init
        @ (vif.cb);vif.cb.reset_n <= 0; 
        @ (vif.cb);vif.cb.reset_n <= 1'b1; 
        @(vif.cb);vif.cb.wdata<=16'h55;
        @(vif.cb);vif.cb.write<=1'b1; 
        @(vif.cb);vif.cb.addr<=32'h000000F0; 

        for (int i=0; i<10; i++) begin
            @(vif.cb);vif.cb.addr<=vif.cb.addr+(i*3);
           @(vif.cb);vif.cb. write <= 1'b1; 
            @(vif.cb);vif.cb.wdata <= vif.cb.wdata*3;
        end
        @(vif.cb);vif.cb. write <= 1'b0;
        @(vif.cb);vif.cb.addr<=32'h000000F0; 
        for (int i=0; i<10; i++) begin
            @(vif.cb);vif.cb.  addr<=vif.cb. addr+(i*3);
           @(vif.cb);vif.cb. read <= 1'b1; 
        end
        @(vif.cb);vif.cb.read <= 1'b0;

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
  top_aa dut (.clk(clk),
                    .reset_n(if_0.reset_n),
                    .read(if_0.read),
                    .write(if_0.write),
                    .wdata(if_0.wdata),
                    .rdata(if_0.rdata),
                    .addr(if_0.addr)
                    
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


