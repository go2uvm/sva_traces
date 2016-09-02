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
   int i;
logic start;

  clocking cb @(posedge clk);
    output i,start;
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

 /*begin
    for (int i=1; i<=5; i=i+1) begin@ (vif.cb);
     
       @ (vif.cb);vif.cb.s_bits <= IDLE;
    end
 
    @ (vif.cb);vif.cb.start <= 1'b1;
   
      @ (vif.cb);vif.cb.s_bits <= STATE1;
   
     @ (vif.cb);vif.cb.s_bits <= STATE2;
   
    repeat (100) @ (vif.cb);

    $stop;
  end */

    


        
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
   logic clk=1;
 initial forever #5 clk=!clk; 
    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
    unexpectedA_5_2 dut (.clk(clk),
                  
                    .start(if_0.start)
                                       
                    
                    
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


