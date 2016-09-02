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
 typedef enum {IDLE, STATE1, STATE2, STATE3}  state_enum;

module unexpectedA_5_2(input clk,start,input int i); 
  //timeunit 1ns;
  //timeprecision 100ps;

   
  state_enum s_bits;
  reg start;
  reg clk;


  
  property UNEXPECTED_PROP;
  @ (posedge clk) 
    start |=> s_bits == STATE1 ##1 s_bits == STATE2;
  endproperty : UNEXPECTED_PROP

  a_UNEXPECTED_PROP : assert property (UNEXPECTED_PROP);
  
  endmodule : unexpectedA_5_2











