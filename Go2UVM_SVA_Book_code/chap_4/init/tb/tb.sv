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
/*checker reqack_chk (event  clk, untyoed max, 
    				logic  done, request, acknowledge, interrupt;
   // declarations
logic req_delay;  // checker local variable 
   default clocking @(clk); endclocking
					
   // static concurrent assertions
   ap_reqack: assert property(request |-> ##[1:max] acknowledge ##1 done);        
   ap_req_intrpt: assert property(req_delay |=> ##[0:$] intrpt);

   // initial procedure					
   initial begin : c_init
	@clk;
     assert (interrupt==0);				
   end  : c_init
					
   // procedural concurrent assertion  
   always  @(clk) begin : c_a1
	 req_delay <= req;
     ap_interrupt: assert property(if(done) ##[0:3] interrupt); 
   end  : c_a1
   
   // final procedure	
   final begin : c_final 
     assert (!done && !interrupt);
     $display("Number of cycles executed %d",$time/period);
     $display("Final request = %b", request);
   end : c_final

 endchecker : reqack_chk

 
module m;
  timeunit 1ns;
  timeprecision 1ns;
logic clk, enb, reset_n;
  logic  req, ack, done, intrpt;  
  always  @ (posedge clk) begin : a1
     if(enb) 
         reqack_chk  reqack_chk1
            (posedge clk, 5, done, req, ack, intrpt);
  end : a1 

   dut dut1(.*);
endmodule : m
 -----/\----- EXCLUDED -----/\----- */

module m_equivalent1; 
  timeunit 1ns;
  timeprecision 1ns;
logic clk, enb, reset_n;
  logic  req, ack, done, intrpt;
m_equivalent dut(.*);
    default clocking @(posedge clk); endclocking
endmodule : m_equivalent1
