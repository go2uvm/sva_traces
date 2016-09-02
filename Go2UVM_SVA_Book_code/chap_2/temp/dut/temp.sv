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
 module temp(input a, b, c, d,  clk, output reg f,e); 
  timeunit 1ns;
  timeprecision 1ns;

  sequence qS1;
   @(posedge clk) a ##1 b; 
  endsequence : qS1
  property p_abcd;
   @ (posedge clk) qS1 |=> c;
   endproperty : p_abcd 
  ap_abcdef :  assert property (@(posedge clk) p_abcd);

  
  always @ (qS1) // Illegal -- should be @ qS1
	 e <= 1;  // e is never assigned. 

  always @ (qS1) // legal 
	 f <= 1;
      // ap_cda: assert property(@ (posedge clk) c ##1 d |=> a);
  
endmodule : temp

