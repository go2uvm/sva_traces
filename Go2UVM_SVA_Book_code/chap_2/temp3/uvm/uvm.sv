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
logic clk1, clk2, req, ack, done, crc_pass, crc_err, busy, ready,req_data, reset, x, a,  b0, b, c, d, e, fx1, x0, a1, a2, a0, a4, a5, reset_n, x1,flag,
        l_b,bus_select,bus1,req1,ack1,req2,ack2 ;  


  clocking cb @(posedge clk);
    output clk1, clk2, req, ack, done, crc_pass, crc_err, busy, ready,req_data, reset, x, a,  b0, b, c, d, e, fx1, x0, a1, a2, a0, a4, a5, reset_n, x1,flag,
              l_b,bus_select,bus1,req1,ack1,req2,ack2;
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
             @ (vif.cb);  vif.cb.a <= 1'b0; 
        repeat (5) @ (vif.cb);
 begin
                   end
        @ (vif.cb);  vif.cb.a <= 1'b1;
               @ (vif.cb);  vif.cb.a <= 1'b0;
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
  temp3 dut (.clk(clk),
		.clk1(clk1),
.clk2(clk2),
. crc_pass(if_0. crc_pass),
.crc_err(if_0.crc_err),
. busy(if_0. busy),
.req_data(if_0.req_data),
. reset(if_0. reset),
.x(if_0.x),
.a(if_0.a),
. b0(if_0. b0),
.c(if_0.c),   
.b(if_0.b),
.d(if_0.d),
.e(if_0.e),  
.fx1(if_0.fx1),
.x0(if_0.x0),
.bus_select(if_0.bus_select),
.bus1(if_0.bus1),
.req1(if_0.req1),
.ack1(if_0.ack1),
.req2(if_0.req2),
.ack2(if_0.ack2)


                

                                       );

   uvm_sva_test test_0;


    initial begin
      test_0 = new();
      test_0.vif = if_0;
      run_test();
    end
endmodule : top


