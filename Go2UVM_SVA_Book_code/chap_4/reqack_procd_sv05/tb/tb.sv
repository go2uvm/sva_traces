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
/* -----\/----- EXCLUDED -----\/-----

checker reqack_chk (event  clk, 
                    untyped max,					  
    				logic   request, acknowledge, done, interrupt, reset_n);
   default clocking @(clk); endclocking
   default disable iff (!reset_n);
   logic req_delay;
   sequence q_reqack; request ##[1:max] acknowledge ##1 done; endsequence : q_reqack
   csq_reqack : cover property(q_reqack);
	   
   property p_reqack; request |-> ##[1:max] acknowledge ##1 done; endproperty : p_reqack
   // concurrent assertions
   ap_reqack: assert property(@(clk) p_reqack) else $error("property p_reqack  error");
   ap_req_intrpt: assert property(@(clk) req_delay |=> ##[0:$] intrpt);
	 
	 always  @(clk) begin : a1
	 req_delay <= req;
      if(done) begin : d1 
		ap_interrupt: assert property(##[0:3] interrupt); // procedural assertion
		assert(!acknowledge) else  // immediate assertion
                 $error("acknowledge asserted when done");
	  end : d1
     end  : a1 
 endchecker : reqack_chk

 
module m;
  timeunit 1ns;
  timeprecision 1ns;
logic clk, enb, reset_n;
  logic [1:0] req, ack, done, intrpt;  
  always @ (posedge clk) begin : a1
     if(enb) 
       for (int i=0; i<2; i++) begin : lp1 
         reqack_chk reqack_chk_loop 
            (posedge clk, i+3, req[i], ack[i], done[i], intrpt[i], reset_n);
       end : lp1 
   end : a1 
  dut dut1(.*);
endmodule : m
 -----/\----- EXCLUDED -----/\----- */

module m_equivalent1; // ERR: Range must be bounded by constant expressions
  timeunit 1ns;
  timeprecision 1ns;
logic clk, enb, reset_n;
  logic [1:0] req, ack, done, intrpt;
m_equivalent dut(.*);
default clocking @(posedge clk); endclocking


  endmodule
