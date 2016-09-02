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
interface m_abc_if( input clk);
logic ack, crc_err, crc_pass, done, req;

       clocking  cb @(posedge clk);
           output crc_pass, done,ack, req;
	   input crc_err;
       endclocking : cb
endinterface : m_abc_if


import uvm_pkg::*;
`include "uvm_macros.svh"
import vw_go2uvm_pkg::*;


class uvm_mabc_test extends go2uvm_base_test;
  virtual m_abc_if vif;

task reset();
`uvm_info( log_id,"start of RESET", UVM_MEDIUM)

`uvm_info( log_id,"end of RESET",UVM_MEDIUM)
endtask: reset


task main();
`uvm_info (log_id,"start of TEST",UVM_MEDIUM)

`uvm_info(log_id,"end of TEST",UVM_MEDIUM)
endtask: main

endclass: uvm_mabc_test

module top;
timeunit 1ns;
 timeprecision 1ns;
logic clk;
initial forever #10 clk=!clk;

// instantiate the interface
m_abc_if if_0(.*);

//instantiate the DUT
sect1_1_3_2 dut(.clk(clk),
          .crc_err(if_0.crc_err),
          .done(if_0.done),
          .ack(if_0.ack),
	  .req(if_0.req),
	  .crc_pass(if_0.crc_pass)
	  );


uvm_mabc_test test_0;
 
initial begin
 test_0 = new();
 test_0.vif = if_0;
 run_test();
end

endmodule :top

 
          
