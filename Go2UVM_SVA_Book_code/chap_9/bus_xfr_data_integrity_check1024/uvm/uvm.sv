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


interface sva_if (input clk_rcv25 );
   logic wr_33, rd_25,reset_n,clk_xt33;
    int   wdata, rdata; // read data from Receiver
   /* int waddr;  // write address for storage of incoming data
    int raddr;  // read address for reading of received data
    int rdata_from_q; // read data from queue to compare to Receiver
    int dataQ [$:1024];  // queue, to store/read incoming data
    int dataQ_size;*/
    
  clocking cb @(posedge clk_rcv25);
    output wr_33,rd_25,wdata,rdata,reset_n,clk_xt33;
  
   
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
// logic clk_xt33=0;
logic clk_rcv25=0;

    initial forever #10 clk_rcv25=!clk_rcv25; 

         // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
 bus_xfr_data_integrity_check1024 dut (.clk_xt33(clk_xt33),
                    .clk_rcv25(clk_rcv25),   
                    
                    .wr_33(if_0.wr_33),
                    .rd_25(if_0.rd_25),
                    .wdata(if_0.wdata),
                    .rdata(if_0.rdata),
                    .reset_n(if_0.reset_n)
                                         );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


