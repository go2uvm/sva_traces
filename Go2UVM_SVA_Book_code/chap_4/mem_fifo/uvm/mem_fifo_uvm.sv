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


interface sva_if (input clk_xt33,clk_rcv25);
    logic wr_33; // Transmitter write signal @33MHz
    logic rd_25;  // Receiver   read signal @25 MHz
    logic[31:0]    wdata; // write data from Transmitter
    logic[31:0]    rdata; // read data from Receiver
    logic reset_n; // active low reset
    logic clk_xt33;   // clock transmitter @33 MHz
    logic clk_rcv25; // clock Receiver @25 MHz
     parameter MAX_BUFF_SIZE=1024; 
  logic[31:0] waddr;  // write address for storage of incoming data
  logic[31:0] raddr;  // read address for reading of received data
  logic[31:0] rdata_from_q; // read data from queue to compare to Receiver
  logic[31:0] dataQ ; // queue, to store/read incoming data
  logic[31:0] dataQsize; // queue size. 
     
  clocking cb @ (posedge clk_xt33,clk_rcv25);
   output wr_33,wdata,reset_n,waddr,raddr,dataQ,dataQsize;
   input  rd_25,rdata,rdata_from_q;
    
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
     int i;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
            @ (vif.cb);
           `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
    timeunit 1ns;   timeprecision 100ps;
    logic clk_xt33=0;
    logic clk_rcv25=0;
    initial forever #10  clk_xt33=!clk_xt33;
    initial forever #10  clk_rcv25=!clk_rcv25; 

      // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
bus_xfr_data_integrity_check  dut1 ( 
                    .clk_rcv25(clk_rcv25),
                   .clk_xt33(clk_xt33),
                    .wr_33(if_0.wr_33),
                    .rd_25(if_0.rd_25),
                    .wdata(if_0.wdata),
                    .rdata(if_0.rdata),
                    .reset_n(if_0.reset_n),
		     .waddr(if_0.waddr),
                     .rdata_from_q(if_0.rdata_from_q),
		     .dataQ (if_0.dataQ),
                     .dataQsize(if_0.dataQsize),
                     .raddr(if_0.raddr)				
                );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top

