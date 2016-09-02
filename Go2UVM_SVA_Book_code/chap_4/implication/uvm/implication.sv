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
interface impl_if (input clk);
logic req,bus_req,done,ready,ack,bus_ack,err,transfer_envelope;

clocking cb @(negedge clk);
output req,bus_req,done;
input ready,ack,bus_ack,err, transfer_envelope ;
endclocking: cb

endinterface: impl_if

import uvm_pkg::*;
`include "uvm_macros.svh"
import vw_go2uvm_pkg::*;

class uvm_impl_test extends go2uvm_base_test;
virtual impl_if vif;

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

endclass: uvm_impl_test

module top;
timeunit 1ns;
 timeprecision 1ns;
logic clk;
 initial forever #10 clk=!clk;

// instantiate the interface
impl_if if_0(.*);

// instantiate the DUT
implication DUT(
                .clk(clk),
		.req(if_0.req),
		.bus_req(if_0.bus_req),
		.done(if_0.done),
		.ready(if_0.ready),
		.ack(if_0.ack),
		.bus_ack(if_0.bus_ack),
		.err(if_0.err),
		.transfer_envelope(if_0.transfer_envelope)
               );

uvm_impl_test test_0;
 
initial begin
 test_0 = new();
 test_0.vif = if_0;
 run_test();
end

endmodule :top

