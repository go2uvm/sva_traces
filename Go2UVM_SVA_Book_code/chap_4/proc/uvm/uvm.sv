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
   logic  clk2,a,b,c,d,e,f;
  


  clocking cb @(posedge clk);
    output clk2,a,b,c,d,e,f;  
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
   begin @ (vif.cb);

       #2  @ (vif.cb);vif.cb.a<=1; 
       #1  @ (vif.cb);vif.cb.a<=0; vif.cb.b <=1; vif.cb.c<=0;  
    end  
    
     begin
        fork
            begin
                 @ (vif.cb);vif.cb.c <= 1; 
                           end
            begin
                                @ (vif.cb);vif.cb.d <= 1; 
            end
        join
    end
 

        
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test


module top;
   logic clk=0;
initial forever #10 clk=!clk;
 initial forever #13 if_0.clk2=!if_0.clk2; 

    // Instantiate the Interface
   sva_if if_0 (.*);

    // Instantiate the DUT
   proc dut (.clk(clk),
                  
                    .clk2(if_0.clk2),
                    .a(if_0.a),
                    .b(if_0.b),
                    .c(if_0.c),
                    .d(if_0.d),
                    .e(if_0.e),
                    .f(if_0.f)
                    
                    
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


