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
    logic load_mem, done, ready, ready2;
 
 
  
  clocking cb @(posedge clk);
    output load_mem,done;
    input ready,ready2;
     
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
   
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
             @ (vif.cb);

        /* begin  @ (vif.cb);

   repeat (100) 
   $display("end of simulation");
   $stop; 
   end*/

 //  always @ (posedge clk) assert (randomize(load_mem, done));
 begin
 logic load_mem,done;

     load_mem = 1'b1;
    load_mem = 1'b0;done = 1'b1;
   end



    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
    timeunit 1ns;   timeprecision 1ns;
    logic clk=0;
    initial forever #10 clk=!clk; 

    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
   seq_trigger3 dut (.clk(clk),
                    .ready(if_0.ready),
	            .ready2(if_0.ready2),
                    .done(if_0.done),
                    .load_mem(if_0.load_mem)
                            );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


