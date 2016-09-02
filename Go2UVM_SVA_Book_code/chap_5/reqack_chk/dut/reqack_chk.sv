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

  module reqack_chk (logic  clk,
  //checker reqack_chk (event  clk, 					  
					  logic   request, acknowledge, done, interrupt, reset_n, 
					  logic[3:0]  max);
//  					  untyped max);
timeunit 1ns;
timeprecision 1ns;

   default clocking @(clk); endclocking
   // default disable iff (!reset_n);
   // sequence q_reqack; request ##[1: max] acknowledge ##1 done; endsequence : q_reqack
   sequence q_reqack; request ##[1: 6] acknowledge ##1 done; endsequence : q_reqack	 
   csq_reqack : cover sequence(q_reqack);
	   
   // property p_reqack; request |-> ##[1:max] acknowledge ##1 done; endproperty : p_reqack
   property p_reqack; request |-> ##[1:6] acknowledge ##1 done; endproperty : p_reqack
   // concurrent assertions
    ap_reqack: assert property(p_reqack) else $error("property p_reqack  error");

    always @(clk) begin : a1 
      if(done) begin : d1 
		ap_interrupt: assert property(##[0:3] interrupt); // procedural assertion
		assert(!acknowledge) else  // immediate assertion
                 $error("acknowledge asserted when done");
	  end : d1
     end  : a1 
  // endchecker : unit_chk
  endmodule : reqack_chk
 

module m(input clk,req,reset_n,intrpt,output ack,done);

  //logic clk, req, ack, done, intrpt, reset_n;
  reqack_chk reqack_chk1 ( clk, req, ack, done, intrpt, reset_n);
  reqack_chk reqack_chkMax ( clk, req, ack, done, intrpt, reset_n); 
 // dut dut1(.*);
endmodule : m


module dut();
endmodule:dut
