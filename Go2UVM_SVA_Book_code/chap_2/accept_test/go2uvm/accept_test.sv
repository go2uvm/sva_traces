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
    logic  reset_n,dma_req, data_transfer,done; 
    
  clocking cb @(posedge clk);
    output reset_n,dma_req,data_transfer;
    output done; 
  endclocking : cb

endinterface : sva_if
import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;

/*
class uvm_sva_test_2 extends go2uvm_base_test;
   task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
	vif.cb.reset_n <= 1'b0;
    repeat(12) @ (vif.cb);
	vif.cb.reset_n <= 1'b1;
        @ (vif.cb);

    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
 endtask : reset
*/
class uvm_sva_test extends go2uvm_base_test;
  virtual sva_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
	vif.cb.reset_n <= 1'b0;
    repeat(5) @ (vif.cb);
	vif.cb.reset_n <= 1'b1;
        @ (vif.cb);

    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset
/*
  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    vif.cb.reset_n <= 1'b0;
   // vif.cb.BVALID <=1'b0;
    repeat(10) @ (vif.cb);
    vif.cb.reset_n <= 1'b1;
    @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset
*/


  task main();
         `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
        
        @ (vif.cb);

	
     begin
        @ (vif.cb);
        @ (vif.cb);
        @(vif.cb);vif.cb.dma_req <= 1'b1; 
	$monitor("pass");
        @(vif.cb);vif.cb.data_transfer <=1'b1; 
        repeat (5) @(vif.cb);
        @(vif.cb);vif.cb.done <= 1'b1; 
	$monitor("pass");

        repeat (5)@(vif.cb);   
	//@(vif.cb);vif.cb.done <= 1'b0; 
      //  @(vif.cb);vif.cb.dma_req <= 1'b0; 
    end

       
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
   accept_test dut (.clk(clk),
                    .reset_n(if_0.reset_n),
                    .dma_req(if_0.dma_req),
                    .done(if_0.done),
                    .data_transfer(if_0.data_transfer)
                    );

   uvm_sva_test test_0;
//uvm_sva_test_2 test_2;

    initial begin
      test_0 = new(); 
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


