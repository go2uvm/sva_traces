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
interface sampled4_if (input clk);
logic clk,reset_n,req,ack,a,b,c,k,data_valid;

clocking cb @(posedge clk);
output a,b,c,reset_n,k,req,data_valid;
input ack;
endclocking: cb

endinterface: sampled4_if

import uvm_pkg::*;
`include "uvm_macros.svh"
import vw_go2uvm_pkg::*;

class uvm_sampled4_test extends go2uvm_base_test;
virtual sampled4_if vif;

task reset();
`uvm_info( log_id,"start of RESET", UVM_MEDIUM)
// repeat(5) @(vif.cb);
`uvm_info( log_id,"end of RESET",UVM_MEDIUM)
endtask: reset


task main();
`uvm_info (log_id,"start of TEST",UVM_MEDIUM)
 // @ (vif.cb)
`uvm_info(log_id,"end of TEST",UVM_MEDIUM)
endtask: main

endclass: uvm_sampled4_test

module top;
timeunit 1ns;
 timeprecision 1ns;
logic clk;
//  initial forever #10 clk=!clk;

// instantiate the interface
sampled4_if if_0(.*);

// instantiate the DUT
sampled4_3 DUT(
         .clk(clk),
         .a(if_0.a),
         .b(if_0.b), 
         .c(if_0.c),
         .reset_n(if_0.reset_n),
         .req(if_0.req),
         .k(if_0.k),
         .data_valid(if_0.data_valid),
         .ack(if_0.ack)
          );

uvm_sampled4_test test_0;
 
initial begin
 test_0 = new();
 test_0.vif = if_0;
 run_test();
end

endmodule :top
 
