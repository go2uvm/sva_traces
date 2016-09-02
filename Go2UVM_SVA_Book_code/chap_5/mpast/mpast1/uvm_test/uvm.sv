interface blobclk_if (input clk);
logic index; 
    logic var1, cur_var1, past_var1; 
    logic a; 

   
   clocking cb @(posedge clk);
    output index; 
    output var1, cur_var1, past_var1; 
    output a; 

 


    endclocking : cb
 endinterface : blobclk_if  

 import uvm_pkg::*;
   `include "uvm_macros.svh"
 
 import vw_go2uvm_pkg::*;

 class uvm_sva_test extends go2uvm_base_test;
   virtual blobclk_if vif;
    task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    //repeat(10) @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
     int m,addr,TEST_NUM;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
      //      @ (vif.cb);
begin : sim 

    @ (vif.cb);vif.cb.index <= 0; 
    @ (vif.cb);vif.cb.var1 <= 1'b0; 

    
    @ (vif.cb);vif.cb.index <= 7; 
    @ (vif.cb);vif.cb.var1 <= 1'b1; 

     
    @ (vif.cb);vif.cb.a <= 1; 
     
    @ (vif.cb);vif.cb.a <= 0; 

     
    @ (vif.cb);vif.cb.a <= 1; 
     
    @ (vif.cb);vif.cb.a <= 0; 


    // ##10 $finish; 
end                                           
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
    endtask : main

endclass : uvm_sva_test

//`timescale 1ns/100
module top;
   timeunit 1ns;
   timeprecision 1ns;

  logic clk=1;
 initial forever #10 clk = !clk;  //Instantiate the Interface 
  blobclk_if if_0 (.*);
   mpast dut (.clk(clk),
                     .index(if_0.index),
		     .var1(if_0.var1),
		     .cur_var1(if_0.cur_var1),
                     .past_var1(if_0.past_var1),
                      .a(if_0.a)


                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
