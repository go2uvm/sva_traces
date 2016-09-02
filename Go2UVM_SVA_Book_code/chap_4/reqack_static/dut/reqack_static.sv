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
 
   // static concurrent assertion
   ap_reqack: assert property(@(clk) p_reqack);


   // procedural concurrent assertion  
   always @(clk) begin : a1
     req_delay <= req;
      if(done) 
        ap_interrupt: assert property(##[0:3] interrupt); 
   end  : a1

endchecker : reqack_chk

 
module m;
  logic clk, enb, reset_n;
  logic [1:0] req, ack, done, intrpt;  
  reqack_chk  reqack_chk1
            (posedge clk, 5, done[2], req[2], ack[2], intrpt[2]);
  reqack_chk  reqack_chk_loop
            (posedge clk, 4, done[i], req[i], ack[i], intrpt[i]);
  dut dut1(.*);
endmodule : m
 -----/\----- EXCLUDED -----/\----- */
	`define max_cp0 5

module m_equivalent( input clk,  reset_n,enb,
   input [2:0]req,  intrpt,output [2:0] ack, done);
 
//  logic clk, enb, reset_n;
 // logic [2:0] req, ack, done, intrpt;
// ***************** CHECKER EQUIVALENT  **************************************  
  // checker local variables and declarations
  //begin : checker_equivalent
// **** Declarations for checker instance reqack_chk1 
   	logic req_delay_cp0;  // separate copies for each instance (_cp postfix for CoPy)
	property p_reqack_cp0; 
     req[2] |-> ##[1:`max_cp0] ack[2] ##1 done[2]; 
    endproperty : p_reqack_cp0

// **** Declarations for checker instance reqack_chk_loop
// One copy of declaration variables for checker instance
//    default clocking @(posedge clk); endclocking
	// constant for loop index 0
	`define max_cp1 2
	// constant for loop index 1
	`define max_cp1a 3		
	logic req_delay_cp1;  
	property p_reqack_cp1;  // One copy only. Updated twice in loop 
     req[0] |-> ##[1:`max_cp1] ack[0] ##1 done[0]; 
    endproperty : p_reqack_cp1  
    property p_reqack_cp1a; 
     req[1] |-> ##[1:`max_cp1a] ack[1] ##1 done[1]; 
    endproperty : p_reqack_cp1a 		
					
// **** ASSERTION STATEMENTS AND PROCEDURAL BLOCKS OF CHECKER  
 // procedural concurrent assertion  for checker instance reqack_chk1 
   always @(posedge clk) begin : a1
	 req_delay_cp0 <= req[2];
      if(done) 
		ap_interrupt_cp0: assert property(##[0:3] intrpt); 
      end  : a1

  // procedural concurrent assertion for checker instance reqack_chk_loop 1st loop 
   always @(posedge clk) begin : a_lp0
	 req_delay_cp1 <= req[0];
      if(done) 
		ap_interrupt_cp1: assert property(##[0:3] intrpt[0]); 
      end  : a_lp0
  // procedural concurrent assertion for checker instance eqack_chk_loop 2nd loop 
    always @(posedge clk) begin : a_lp1
	 req_delay_cp1 <= req[1];
      if(done) 
		ap_interrupt_cp1b: assert property(##[0:3] intrpt[1]); 
     end  : a_lp1   	

  // module m code    
    always @ (posedge clk) begin : aa1
        if(enb) begin : enb1
		// checker static concurrent assertions go here
         ap_reqack_cp0: assert property(@(posedge clk) p_reqack_cp0);
        end : enb1
   // for (int i=0; i<2; i++) 
   //      reqack_chk  reqack_chk_loop
   //          (posedge clk, i+2, done[i], req[i], ack[i], intrpt[i]);
	  // checker static concurrent assertions go here for the loop 
	  ap_reqack_cp1: assert property(@(posedge clk) p_reqack_cp1);
	  ap_reqack_cp1a: assert property(@(posedge clk) p_reqack_cp1a);
     end : aa1
//  end : checker_equivalent
  dut dut1(.*);
endmodule : m_equivalent

module dut;
endmodule
