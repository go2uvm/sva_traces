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
 
 // A bus request if followed by an acknowledge, and then a done.  
 // This requirement maybe prefaced in a module with an enable signal. 
 // checker static concurrent assertion 
 // Behavior is dependent on point of checker instantiation 
 ap_reqack: assert property(@(clk) request |=> acknowledge ##[1:max] done);
 
 // If a done, there should be an interrupt within 5 cycles.  
 // This requirementmay not be prefaced by an enable. 
 // checker procedural concurrent assertion  
 // Behavior is independent on point of checker instantiation 
   always @(clk) begin : a1
    ap_interrupt: assert property(done |-> ##[1:max] interrupt); 
   end  : a1
endchecker : reqack_chk

 
module m;
  timeunit 1ns;
  timeprecision 1ns;
  logic clk, enb, reset_n;
  logic req, ack, done, intrpt;  
  always @ (posedge clk) begin : a1 
    if (enb) begin : enb1
      // checker instantiation point 
       reqack_chk  reqack_chk_enb
            (posedge clk, 5, done, req, ack, intrpt);
    // ... other code 
    end : enb1
   end : a1 
  dut dut1(.*);
endmodule : m
 -----/\----- EXCLUDED -----/\----- */

module m_equivalent(input clk,enb,reset_n,[2:0]req,ack,done,intrpt); 
  timeunit 1ns;
  timeprecision 1ns;
  //logic clk, enb, reset_n;
  //logic [2:0] req, ack, done, intrpt;
// ***************** CHECKER EQUIVALENT  **************************************  
  // checker local variables and declarations
  //begin : checker_equivalent //CVC change commented curent line
// **** Declarations for checker instance reqack_chk1 
    //default clocking @(posedge clk); endclocking
	`define max_cp0 5
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
 // end : checker_equivalent //CVC change commented current line
  dut dut1(.*);
endmodule : m_equivalent

module dut;
  timeunit 1ns;
  timeprecision 1ns;
endmodule
