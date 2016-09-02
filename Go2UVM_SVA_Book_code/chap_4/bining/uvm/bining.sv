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
    logic c_miss,mm_rd;
    int   c_a,m_a;
   //  int addr,m; 
   // int TEST_NUM;
  clocking cb @(posedge clk);
    output c_miss,mm_rd;
    output   c_a,m_a; 
    //output addr,m;
   //output TEST_NUM;
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
        

       begin
 int TEST_NUM;
 int addr,m;

        @(vif.cb);vif.cb.c_miss <= 0;
        @(vif.cb);vif.cb.mm_rd <= 0;          
       
          //clk = 0;

        for (int i=0; i<TEST_NUM; ++i) begin  
            @ (vif.cb);                        
            @ (vif.cb);vif.cb.m_a <= $urandom_range(2,10);
              addr = $urandom();
          //  $display("%d c read addr=%0h delay=%0d"$time,addr,m);
            @(vif.cb);vif.cb.c_a <= addr;
            @(vif.cb);vif.cb.c_miss <= 1;     
            @(vif.cb);vif.cb.c_miss <= 0;
            repeat (m) @ (vif.cb); 
            @(vif.cb);vif.cb.m_a <= addr;
            @(vif.cb);vif.cb.mm_rd <= 1;
            @(vif.cb);
            @(vif.cb);vif.cb.mm_rd <= 0;
        end
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
      bining dut (.clk(clk),
                    .mm_rd(if_0.mm_rd),
                    .c_miss(if_0.c_miss),
                    .c_a(if_0.c_a),
                    .m_a(if_0.m_a)
                                        
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


