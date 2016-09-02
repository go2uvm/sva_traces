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
   logic clk1,clk2, req, ack, done, crc_pass, crc_err, busy, ready, reset, x, a;  
 logic   b0, b, c, d, x1, x0;
 logic a1, a2, a0, a4, a5, reset_n; 
   int i, j,data; 
 logic req_data,flag,fx1;

  clocking cb @(posedge clk);
    output  req, ack, done, crc_pass, crc_err, busy, ready, reset, x, a;  
output  b0, b, c, d, x1, x0;
output i, j,data; 
    output   a1, a2, a0, a4, a5, reset_n; 
output flag,fx1,req_data;
inout clk1,clk2;
  endclocking : cb

endinterface : sva_if
import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;

class uvm_sva_test extends go2uvm_base_test;
virtual sva_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
     @ (vif.cb);
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
 sva_if if_0 (.*);
// virtual sva_if vif;
    logic clk=0,clk1=0,clk2=0;
    initial forever #10 clk=!clk; 
    initial forever #10 clk2<=!clk2; 
     initial forever #10 clk1<=!clk1;
// initial forever #10 clk=!clk; 


    // Instantiate the Interface
   //sva_if if_0 (.*);

    // Instantiate the DUT
   clk_event dut (.clk(clk),
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
                    .j(if_0.j),
		    .req_data(if_0.req_data),
		    .flag(if_0.flag),
		    .data(if_0.data),
		    .fx1(if_0.fx1),
                    .clk1(if_0.clk1),
		    .clk2(if_0.clk2)

                    

                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


