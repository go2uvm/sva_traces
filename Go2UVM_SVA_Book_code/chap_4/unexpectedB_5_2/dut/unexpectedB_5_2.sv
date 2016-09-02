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
module unexpectedB_5_2(input clk,start,input [1:0] s_bits); 
 // timeunit 1ns;
  //timeprecision 100ps;
  parameter IDLE = 2'b00;
  parameter STATE1 = 2'b01;
  parameter STATE2 = 2'b10;
  parameter STATE3 = 2'b11;
			
  //typedef enum {IDLE, STATE1, STATE2, STATE3}  state_enum;
  
  reg [1:0] s_bits;
  reg start;
  reg clk;

  // Clock
    
  // architecture unexpected
  property UNEXPECTED_PROP;
  @ (posedge clk) 
    start |=> s_bits == STATE1 ##1 s_bits == STATE2;
  endproperty : UNEXPECTED_PROP

  UA1: assert property (UNEXPECTED_PROP);
  

 endmodule : unexpectedB_5_2

