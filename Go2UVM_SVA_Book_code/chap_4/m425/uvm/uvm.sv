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
     logic x, y,enb, enb0, enb1, a1, b1, c1, d1, e1, f1; 
    logic en, en1, a, b, c, reset_n, d, e, enb_local,f,ev;

  clocking cb @(posedge clk);
     output x, y, enb, enb0, enb1, a1, b1, c1, d1, e1, f1; 
    output en, en1, a, b, c, reset_n, d, e, f,enb_local,ev;
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
      begin
        repeat (3)  @ (vif.cb);
         @ (vif.cb);vif.cb.a1<=1'b1; 
         @ (vif.cb);vif.cb.e1 <= 1'b0; 
         @ (vif.cb);vif.cb.a1 <=1'b0; 
    end   

       begin
         @ (vif.cb);
             @ (vif.cb);vif.cb.a <= 1'b1; 
        @ (vif.cb); vif.cb.b <= 1'b0; 
      
        @ (vif.cb); vif.cb.b <= 1'b1;
               @ (vif.cb); vif.cb.a <= 1'b0; 
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
   m425 dut (.clk(clk),
                    .x(if_0.x),
                    .y(if_0.y),
                    .a(if_0.a),
                    .b(if_0.b),
                    .c(if_0.c),
			.enb(if_0.enb),
.enb0(if_0.enb0),
.enb1(if_0.enb1),
.a1(if_0.a1),
.b1(if_0.b1),
.c1(if_0.c1),
.d1(if_0.d1),
.e1(if_0.e1),
.f1(if_0.f1),
.en(if_0.en),
.en1(if_0.en1),
.d(if_0.d),
.e(if_0.e),
.f(if_0.f),
.enb_local(if_0.enb_local),
.ev(if_0.ev),




                    .reset_n(if_0.reset_n)
			
                   );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


