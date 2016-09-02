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
interface m_xy_if (input clk);
logic x,y;

clocking cb @(posedge clk);
output x,y,clk;
endclocking: cb

endinterface: m_xy_if

import uvm_pkg::*;
`include "uvm_macros.svh"
import vw_go2uvm_pkg::*;

class uvm_m_xy_test extends go2uvm_base_test;
virtual m_xy_if vif;

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

endclass: uvm_m_xy_test

module top;
timeunit 1ns;
 timeprecision 1ns;
logic clk;
// initial forever #5 clk=!clk;

// instantiate the interface
m_xy_if if_0(.*);

// instantiate the DUT
m DUT       (
                .clk(clk),
		.x(if_0.x),
		.y(if_0.y)
           );

uvm_m_xy_test test_0;
 
initial begin
 test_0 = new();
 test_0.vif = if_0;
 run_test();
end

endmodule :top

