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
    logic dataout;     // output data bits
    logic checkout;    // output check bits
    logic datain;      // input data bits
    logic checkin;     // input check bits
    logic datacorr;    // corrected data bits
    logic singleerr;   // single error
    logic doubleerr;   // double error
    logic multipleerr; // uncorrectable error


  clocking cb @(posedge clk);
   output  dataout;     // output data bits
    input checkout;    // output check bits
    output  datain;      // input data bits
   output    checkin;     // input check bits
    input  datacorr;    // corrected data bits
    input singleerr;   // single error
   input   doubleerr;   // double error
   input   multipleerr; // uncorrectable error 
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
    timeunit 1ns;   timeprecision 100ps;
    logic clk=0;
    initial forever #10 clk=!clk; 

    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
   edac32hamming  dut(.clk(clk),
                     .dataout(if_0.dataout),                       
                      .checkout(if_0.checkout),   
                      .datain(if_0.datain),     
                      .checkin(if_0.checkin),     
                      .datacorr(if_0.datacorr),   
                      .singleerr(if_0.singleerr),  
                      .doubleerr(if_0.doubleerr),  
                     .multipleerr(if_0.multipleerr)                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


