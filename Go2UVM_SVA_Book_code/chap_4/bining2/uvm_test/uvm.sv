interface blobclk_if (input clk);
  logic c_miss, mm_rd;
int c_a, m_a;
     
   
   clocking cb @(posedge clk);
output  c_miss, mm_rd,c_a, m_a;
 


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
begin
         @ (vif.cb);vif.cb.c_miss <= 0; 
	 @ (vif.cb);vif.cb.mm_rd <= 0;          
        
        for (int i=0; i<TEST_NUM; ++i)
        begin                          
            m = $urandom_range(10,100);
            addr = $urandom();
            $display("%d c read addr=%0h delay=%0d",$time,addr,m
                     );

             @ (vif.cb); vif.cb.c_miss <= 1;     
           vif.cb <= 1;    
           vif.cb <= 0;
             @ (vif.cb);vif.cb.c_miss <= 0;

            for (int j=0; j<m; ++j)
            begin
                vif.cb <= 1;
               vif.cb <= 0;
            end         

            @ (vif.cb);vif.cb.mm_rd <= 1;
           vif.cb <= 1;
            vif.cb <= 0;
            @ (vif.cb); vif.cb.mm_rd <= 0;
            //#10;

        end
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
   temporal_bining_test dut (.clk(clk),
                     .c_miss(if_0.c_miss),
		     .mm_rd(if_0.mm_rd),
		     .c_a(if_0.c_a),
                     .m_a(if_0.m_a)
                     

                    );

 uvm_sva_test test_0;

  initial begin
    test_0 = new();
    test_0.vif = if_0;
    run_test();
   end
  endmodule 
