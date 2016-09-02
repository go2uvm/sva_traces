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
interface imm_if( input clk);
logic bus_err, abort_command, retransmit_cmd,mode;

       clocking  cb @(negedge clk);
           output bus_err, abort_command, retransmit_cmd;
           
       endclocking : cb
endinterface : imm_if


import uvm_pkg::*;
`include "uvm_macros.svh"
import vw_go2uvm_pkg::*;


class uvm_imm_test extends go2uvm_base_test;
  virtual imm_if vif;

task reset();
`uvm_info( log_id,"start of RESET", UVM_MEDIUM)
//repeat(2) @(vif.cb);
`uvm_info( log_id,"end of RESET",UVM_MEDIUM)
endtask: reset


task main();
`uvm_info (log_id,"start of TEST",UVM_MEDIUM)
// @ (vif.cb)
// reset();
`uvm_info(log_id,"end of TEST",UVM_MEDIUM)
endtask: main

endclass: uvm_imm_test

module top;
timeunit 1ns;
 timeprecision 1ns;
logic clk;
initial forever #5 clk=!clk;

// instantiate the interface
imm_if if_0(.*);

//instantiate the DUT
sect1_1_3_1 DUT(.clk(clk),
          .bus_err(if_0.bus_err),
          .abort_command(if_0.abort_command),
          .retransmit_cmd(if_0.retransmit_cmd)
	  
	  );


uvm_imm_test test_0;
 
initial begin
 test_0 = new();
 test_0.vif = if_0;
 run_test();
end

endmodule :top

