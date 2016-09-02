/*
    Code for use with the book
    "SystemVerilog Assertions Handbook, 3nd edition"ISBN  878-0-9705394-3-6

    Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2012

    www.systemverilog.us  ben@systemverilog.us
    www.cvcblr.com, info@cvcblr.com

    All code provided in this book and in the accompanied website is distributed
    with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
    the authors nor any supporting vendors shall be liable for damage in connection
    with, or arising out of, the furnishing, performance or use of the models
    provided in the book and website.
*/

interface seq1_if (input clk);
logic clk,a,b,c,d,e,x,y;

clocking cb @(negedge clk);
output a,b,c,d,e,x,y;
endclocking: cb

endinterface: seq1_if

import uvm_pkg::*;
`include "uvm_macros.svh"
import vw_go2uvm_pkg::*;

class uvm_seq_test extends go2uvm_base_test;
virtual seq1_if vif;

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

endclass: uvm_seq_test

module top;
timeunit 1ns;
 timeprecision 1ns;
logic clk;
//  initial forever #10 clk=!clk;

// instantiate the interface
seq1_if if_0(.*);

// instantiate the DUT
seq1 DUT(.clk(clk),
         .a(if_0.a),
         .b(if_0.b), 
         .c(if_0.c),
         .d(if_0.d),
         .e(if_0.e),
         .x(if_0.x),
         .y(if_0.y));

uvm_seq_test test_0;
 
initial begin
 test_0 = new();
 test_0.vif = if_0;
 run_test();
end

endmodule :top

 
          
