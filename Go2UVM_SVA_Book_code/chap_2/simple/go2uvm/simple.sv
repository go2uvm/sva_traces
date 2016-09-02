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
 logic  req, ack, done, crc_pass, crc_err, busy, ready,reset, x, a;  
 logic   b0, b, c, d, x1, x0;
 logic a1, a2, a0, a4, a5, reset_n; 
   int i, j; 


  clocking cb @(posedge clk);
  output req, ack, done, crc_pass, crc_err, busy, ready, reset, x, a;  
output  b0, b, c, d,  x0;
output i, j; 
    output   a1,  a0, a4, a5, reset_n; 
    output a2,x1;
  endclocking : cb

endinterface : sva_if
import uvm_pkg::*;
  `include "uvm_macros.svh"

import cvc_go2uvm_pkg::*;

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
   simple dut (.clk(clk),
                    .req(if_0.req),
                    .ack(if_0.ack),
                    .crc_pass(if_0.crc_pass),
                    .crc_err(if_0.crc_err),
                    .busy(if_0.busy),
                    .reset(if_0.reset),
                     .ready(if_0.ready),
                    .x(if_0.x),
                    .a(if_0.a),
                    .b0(if_0.b0),
                    .c(if_0.c),
                    .b(if_0.b),
                    .d(if_0.d),
                    .x0(if_0.x0),
                    .x1(if_0.x1),
                    .a1(if_0.a1),
                    .a2(if_0.a2),
                    .a0(if_0.a0),
                    .a5(if_0.a5),
                    .a4(if_0.a4),
                    .reset_n(if_0.reset_n),
                    .i(if_0.i),
                    .j(if_0.j)


                    

                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


