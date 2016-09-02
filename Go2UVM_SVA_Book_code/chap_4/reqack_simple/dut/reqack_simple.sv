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

checker reqack_chk (event  clk, untyped max,	
    				logic  done, request, acknowledge, interrupt;
   // declarations
   logic req_delay;  // checker local variable 
   default clocking @(clk); endclocking
   property p_reqack; 
     request |-> ##[1:max] acknowledge ##1 done; 
   endproperty : p_reqack
 
   // static concurrent assertions
   ap_reqack: assert property(@(clk) p_reqack);
   ap_req_intrpt: assert property(@(clk) req_delay |=> ##[0:$] intrpt);

   // procedural concurrent assertion  
   always @(clk) begin : a1
	 req_delay <= req;
       
		ap_interrupt: assert property(if(done) ##[0:3] interrupt); 
   end  : a1

 endchecker : reqack_chk

 
module m;
  logic clk, enb, reset_n;
  logic  req, ack, done, intrpt;  
  always @ (posedge clk) begin : a1
     if(enb) 
         reqack_chk  reqack_chk1
            (posedge clk, 5, done, req, ack, intrpt);
  end : a1 

   dut dut1(.*);
endmodule : m
 -----/\----- EXCLUDED -----/\----- */

module m_equivalent( input clk, enb, reset_n,
   req,  intrpt,output ack, done,);
timeunit 1ns;
timeprecision 1ns;
 
  logic clk, enb, reset_n;
  logic  req, ack, done, intrpt;
// ***************** CHECKER EQUIVALENT  **************************************  
  // checker local variables and declarations
//  begin : checker_equivalent
// **** Declarations 	
    default clocking @(posedge clk); endclocking
	`define max_cp0 5
	logic req_delay_cp0;  // separate copies for each instance (_cp postfix for CoPy)
	property p_reqack_cp0; 
     req |-> ##[1:`max_cp0] ack ##1 done; 
    endproperty : p_reqack_cp0  
					
// **** ASSERTION STATEMENTS AND PROCEDURAL BLOCKS OF CHECKER  
 // procedural concurrent assertion  
   always @(posedge clk) begin : a1
	 req_delay_cp0 <= req;
      if(done) 
		ap_interrupt_cp0: assert property(##[0:3] intrpt); 
     end  : a1   	
       
    always @ (posedge clk) begin : aa1
        if(enb) begin : enb1
         ap_reqack_cp0: assert property(@(posedge clk) p_reqack_cp0);
         ap_req_intrpt_cp0 : assert property(@(posedge clk) 
                                   req_delay_cp0 |=> ##[0:$] intrpt);		  
        end : enb1
     end : aa1
  //end : checker_equivalent
  //dut dut1(.*);
endmodule : m_equivalent

//module dut;
//endmodule
