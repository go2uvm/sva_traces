
interface sva_if (input clk);
 logic a, b, c, d, w ; 
 logic v; 
   
  clocking cb @(posedge clk);
  output  c, w; 
    inout a,b,v;
    input d;	
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
         repeat (10) begin @(vif.cb);
         if(!randomize(vif.cb.a, vif.cb.b, vif.cb.v))  $error("randomization failure"); 
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
   assert_cntrl dut (.clk(clk),
                    .a(if_0.a),
                    .b(if_0.b),
                    .c(if_0.c),
                    .d(if_0.d),
                    .v(if_0.v),
                    .w(if_0.w)
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


