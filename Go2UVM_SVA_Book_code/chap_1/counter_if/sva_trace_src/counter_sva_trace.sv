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

class sva_test extends go2uvm_base_test;
  virtual counter_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    vif.cb.rst_n <= 1'b0;
    vif.ld <= 1'b0;
    vif.cb.data_in <= 0;
    @ (vif.cb);
    @ (vif.cb);
    vif.cb.rst_n <= 1'b1;
    @ (vif.cb);
    @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
    repeat (10) @ (vif.cb);
    repeat (4) begin : ld_rpt
      vif.cb.data_in <= $urandom;
      vif.ld <= 1'b1;
      @ (vif.cb);
    end : ld_rpt
    vif.ld <= 1'b0;
    @ (vif.cb);
    @ (vif.cb);
    @ (vif.cb);

    `uvm_info(log_id, "Start of FAIL trace ", UVM_MEDIUM)
    force top.if_0.counter = 0;
    @ (vif.cb);
    @ (vif.cb);
    repeat (4) begin : ld_fail
      vif.cb.data_in <= (1 + ($urandom % 13));
      vif.ld <= 1'b1;
      uvm_report_mock::expect_error("ap_load");
      @ (vif.cb);
    end : ld_fail
    vif.ld <= 1'b0;
    @ (vif.cb);
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
  endtask : main

endclass : sva_test


module top;
    timeunit 1ns;   timeprecision 100ps;
    
  bit clk;
  initial forever #10 clk <= ~clk;

    // Instantiate the Interface
   counter_if if_0 (.*);

   sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


