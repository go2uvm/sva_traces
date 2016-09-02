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

interface fifo_if (input clk);
logic reset_n, full, empty, almost_full, almost_empty,  error, push, pop;
logic [31:0] data_in, data_out;
  
  clocking cb @(posedge clk);
    output reset_n, push, pop;
    output data_in; 
    input empty, full, almost_empty, almost_full,error;
    input data_out;
  endclocking : cb

endinterface : fifo_if
import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;

class uvm_sva_test extends go2uvm_base_test;
  virtual fifo_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    repeat(5) @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
     
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
            @ (vif.cb);
           `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
    timeunit 1ns;   timeprecision 100ps;
    logic clk=0;
    initial forever #10 clk=!clk; 

    // Instantiate the Interface
   fifo_if if_0 (.*);

    // Instantiate the DUT
   fifo dut (.clk(clk),
             .empty(if_0.empty),
             .full(if_0.full),
             .almost_empty(if_0.almost_empty),
             .reset_n(if_0.reset_n),
             .almost_full(if_0.almost_full),
             .push(if_0.push),
             .pop(if_0.pop),
             .error(if_0.error),
             .data_in(if_0.data_in),
             .data_out(if_0.data_out)
             );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


